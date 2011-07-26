From: Liam Girdwood <lrg@ti.com>
Subject: Re: [PATCH v3] ASoC: dapm - Add API call to query the
 widgets of valid DAPM paths.
Date: Tue, 26 Jul 2011 12:16:36 +0100
Message-ID: <1311678996.4088.4.camel@CNA0741383>
References: <1311588926-3439-1-git-send-email-lrg@ti.com>
	<20110725211620.GC6086@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from comal.ext.ti.com (comal.ext.ti.com [198.47.26.152])
	by alsa0.perex.cz (Postfix) with ESMTP id 4DA0024517
	for <alsa-devel@alsa-project.org>;
	Tue, 26 Jul 2011 13:16:44 +0200 (CEST)
In-Reply-To: <20110725211620.GC6086@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Mon, 2011-07-25 at 23:16 +0200, Mark Brown wrote:
> On Mon, Jul 25, 2011 at 11:15:26AM +0100, Liam Girdwood wrote:
> 
> > +int snd_soc_dapm_get_connected_widgets(struct snd_soc_dapm_context *dapm,
> > +	const char *stream_name, struct snd_soc_dapm_widget_list **list,
> > +	int stream)
> 
> > +	/* get stream root widget AIF from stream string and direction */
> > +	list_for_each_entry(w, &dapm->card->widgets, list) {
> > +
> > +		if (w->id != type)
> > +			continue;
> > +
> > +		if (!strcmp(w->sname, stream_name))
> > +			goto found;
> > +	}
> 
> Hrm, so I must be missing something here but this still has the issue
> with only finding the first widget if we've got more than one widget for
> a stream.  For example, the tlv320aic3x driver defines:
> 
>    SND_SOC_DAPM_DAC("Left DAC", "Left Playback", DAC_PWR, 7, 0),
>    SND_SOC_DAPM_DAC("Right DAC", "Right Playback", DAC_PWR, 6, 0),
> 
> and hooks them both up to a single "Playback" stream (most devices don't
> even have the distinct names at the widget level).  

This will only match on the exact name here. So we can retrieve both
left and right stream widgets by making two separate calls. We should
also not have two AIF widgets with the same stream name within a DAPM
context.

> This makes sense as
> DAPM really does want mono streams to work with but if we only look at
> the first match we'll fail to enumerate some of the widgets connected to
> the stream.  

This will only happen if we have AIF widgets with exactly the same
stream names in a dapm context so there should only ever be 1 match.

Liam
