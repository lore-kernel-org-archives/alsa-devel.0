From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 4/7] ASoC: Pass snd_soc_card instead of
 snd_soc_dapm_context were appropriate
Date: Thu, 28 Apr 2011 20:47:57 +0100
Message-ID: <20110428194757.GC16837@opensource.wolfsonmicro.com>
References: <1304009173-5786-1-git-send-email-lars@metafoo.de>
	<1304009173-5786-4-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 3972A2414F
	for <alsa-devel@alsa-project.org>;
	Thu, 28 Apr 2011 21:47:48 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1304009173-5786-4-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Thu, Apr 28, 2011 at 06:46:10PM +0200, Lars-Peter Clausen wrote:

>  	if (w->event && (w->event_flags & event)) {
> -		pop_dbg(dapm->dev, card->pop_time, "pop test : %s %s\n",
> +		pop_dbg(card->dev, card->pop_time, "pop test : %s %s\n",

This isn't a good change - logging the widgets with the card device
rather than the device of the widget isn't going to clarify things.

> -	pop_dbg(dapm->dev, card->pop_time,
> +	pop_dbg(card->dev, card->pop_time,
>  		"DAPM sequencing finished, waiting %dms\n", card->pop_time);

It's fine here because this is the system-wide sequencing that's
terminated.

>  int snd_soc_dapm_sync(struct snd_soc_dapm_context *dapm)
>  {
> -	return dapm_power_widgets(dapm, SND_SOC_DAPM_STREAM_NOP, NULL);
> +	return dapm_power_widgets(dapm->card, SND_SOC_DAPM_STREAM_NOP, NULL);
>  }
>  EXPORT_SYMBOL_GPL(snd_soc_dapm_sync);

This should really just operate on the card, syncing an isolated DAPM
context is meaningless.  I'll just go do that...

Otherwise these look good.
