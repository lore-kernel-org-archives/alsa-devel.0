From: Liam Girdwood <lrg@ti.com>
Subject: Re: [PATCH v2] ASoC: dapm - Add API call to query the
 widgets of valid DAPM paths.
Date: Thu, 21 Jul 2011 20:52:22 +0100
Message-ID: <4E288376.2040500@ti.com>
References: <1311160995-3475-1-git-send-email-lrg@ti.com>
	<20110720201524.GG26043@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from comal.ext.ti.com (comal.ext.ti.com [198.47.26.152])
	by alsa0.perex.cz (Postfix) with ESMTP id 14DC9103823
	for <alsa-devel@alsa-project.org>;
	Thu, 21 Jul 2011 21:52:28 +0200 (CEST)
In-Reply-To: <20110720201524.GG26043@opensource.wolfsonmicro.com>
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

On 20/07/11 21:15, Mark Brown wrote:
> On Wed, Jul 20, 2011 at 12:23:15PM +0100, Liam Girdwood wrote:
> 
>> +                       dev_dbg(widget->dapm->dev," %c : %s -> %s -> %s\n",
>> +                               path->sink && path->connect ? '*' : ' ',
>> +                               widget->name, path->name, path->sink->name);
> 
> We should fix the debugfs stuff to include unconnected paths too, only
> showing currently active paths was a mistake. 

This will show the unconnected paths but not weak paths.
I can update to include a flag for weak though.

 Might be worth dialing
> down to vdbg too, we look at DAPM a *lot* during scenario changes and
> on big systems it can obscure what's going on.

Ok, that would make sense. I can think of a few other areas for dev_vdbg too... 

> 
>> +/**
>> + * snd_soc_dapm_get_connected_widgets - query audio path and it's widgets.
>> + * @dapm: the dapm context.
>> + * @stream_name: stream name.
>> + * @list: list of active widgets for this stream.
>> + * @stream: stream direction.
>> + *
>> + * Queries DAPM graph as to whether an valid audio stream path exists for
>> + * the initial widget specified by name. This takes into account
> 
> s/initial widget/stream/
> 
>> +	/* get stream root widget AIF from stream string and direction */
>> +	list_for_each_entry(w, &dapm->card->widgets, list) {
>> +
>> +		if (w->id != type)
>> +			continue;
>> +
>> +		if (strstr(w->sname, stream_name))
>> +			goto found;
>> +	}
>> +	dev_err(dapm->dev, "root widget for %s not found\n", stream_name);
> 
> Hrm, this will only check the widgets connected to the first widget it
> sees for an AIF.  For streams with multiple widgets connected (eg, left
> and right channel) it's only going to see things on the first widget it
> comes across which probably isn't what we were expecting.  Unless we
> change to match the comment and query by widget name in which case we're
> already requiring uniqueness.

Yes, but I cant think of any single channel AIFs atm, unless Wolfson has some ?

Liam
