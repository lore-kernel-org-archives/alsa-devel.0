From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: dapm - Add API calls to query valid
	DAPM paths.
Date: Wed, 6 Jul 2011 20:32:54 -0700
Message-ID: <20110707033250.GC13154@opensource.wolfsonmicro.com>
References: <1309981768-3201-1-git-send-email-lrg@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 30BB2244EC
	for <alsa-devel@alsa-project.org>;
	Thu,  7 Jul 2011 05:33:00 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1309981768-3201-1-git-send-email-lrg@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, Jul 06, 2011 at 08:49:28PM +0100, Liam Girdwood wrote:

> Add DAPM API calls to determine whether a DAPM audio path is valid between
> source and sink widgets and return a lits of active widgets in that path.
> This also takes into account all kcontrol mux and mixer settings in between
> the source and sink widgets to validate the audio path.

Hrm, I'm not entirely sure about this.  My overall feeling is that it
feels complicated and I'm not comfortable that it's doing something
different to the rest of DAPM that doesn't normally get used.  It
doesn't seem like the tree walk we're doing here should be different
enough to the walk we do for the normal power check to require a
completely separate implementation and having the two checks feels like
it's going to cause issues later on.  I may be missing something but
shouldn't we be able to replace the current list walk with a walk which
uses this sort of interface on each relevant widget it finds?

There's already some drift with things like the callbacks for dynamic
routes not being implemented...

It does also occur to me that perhaps what we want to do here is allow
widgets to find out about paths when they're being activated anyway?
That'd also be useful for things like DVFS charge pumps, sometimes they
can easily be controlled with a fake widget but not always if there's
complicated digital routing within the device.

> @@ -432,6 +440,8 @@ struct snd_soc_dapm_path {
>  	u32 connect:1;	/* source and sink widgets are connected */
>  	u32 walked:1;	/* path has been walked */
>  	u32 weak:1;	/* path ignored for power management */
> +	u32 length:6;	/* path length - used by route checker */
> +

The :6 seems very odd here.

> index 0a78482..800af10 100644
> --- a/sound/soc/soc-dapm.c
> +++ b/sound/soc/soc-dapm.c
> @@ -48,6 +48,8 @@
>  
>  #include <trace/events/asoc.h>
>  
> +#define DAPM_MAX_HOPS 16
> +

This seems too low, if we need a limit I'd expect it to be an order of
magnitude higher.  I'm not sure we should need a limit, though.

> +/* add widget to list if it's not already in the list */
> +static int dapm_add_unique_widget(struct snd_soc_dapm_context *dapm,
> +	struct snd_soc_dapm_widget_list **list,
> +	struct snd_soc_dapm_widget *w)

Just make this plain old add_widget()?  I can't see us ever wanting a
non-unique version, and it's going to have fun with the standard list
implementation if we do.  Perhaps also shove a list in the name.

> +	/* is the list empty ? */
> +	if (*list == NULL) {
> +
> +		wlistsize = sizeof(struct snd_soc_dapm_widget_list) +
> +				sizeof(struct snd_soc_dapm_widget *);
> +		*list = kzalloc(wlistsize, GFP_KERNEL);
> +		if (*list == NULL) {
> +			dev_err(dapm->dev, "can't allocate widget list for %s\n",
> +				w->name);
> +			return -ENOMEM;

It seems really odd to be allocating here rather than in the caller.

> +		*list = krealloc(wlist, wlistsize, GFP_KERNEL);
> +		if (*list == NULL) {
> +			dev_err(dapm->dev, "can't allocate widget list for %s\n",
> +				w->name);
> +			return -ENOMEM;
> +		}

This will leak the pointer to the list when it fails.

> +/* is widget an output endpoint */
> +static int is_output_widget_ep(struct snd_soc_dapm_widget *widget)
> +{
> +	switch (widget->id) {
> +	case snd_soc_dapm_adc:
> +	case snd_soc_dapm_aif_out:
> +		return 1;
> +	case snd_soc_dapm_output:
> +		if (widget->connected && !widget->ext)
> +			return 1;
> +		else
> +			return 0;
> +	case snd_soc_dapm_hp:
> +	case snd_soc_dapm_spk:
> +	case snd_soc_dapm_line:
> +		return !list_empty(&widget->sources);
> +	default:
> +		return 0;

With both this and the input version we're duplicating sort of the logic
that's in is_connected_foo_ep.  I'd feel much happier if we factored the
shared logic out of those functions rather than duplicating it, as it is
I'm worried the two could drift apart over time.

> +	case snd_soc_dapm_mic:
> +		return !list_empty(&widget->sources);

That doesn't seem right?

> +/**
> + * snd_soc_dapm_get_connected_widgets_type - query audio path and it's widgets.
> + * @dapm: the dapm context.
> + * @stream_name: stream name.
> + * @list: list of active widgets for this stream.
> + * @stream: stream direction.
> + * @type: Initial widget type.
> + *
> + * Queries DAPM graph as to whether an valid audio stream path exists for
> + * the DAPM stream and initial widget type specified. This takes into account
> + * current mixer and mux kcontrol settings. Creates list of valid widgets.

Why would someone want to query by type?  That seems surprising.  Name
and/or direction yes but type seems hard to find a use for.
