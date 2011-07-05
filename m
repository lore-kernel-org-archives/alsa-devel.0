From: Liam Girdwood <lrg@ti.com>
Subject: Re: ALSA become "Segmentation fault" on current linus
 tree
Date: Tue, 5 Jul 2011 11:22:33 +0100
Message-ID: <4E12E5E9.7090605@ti.com>
References: <87k4bxfjue.wl%kuninori.morimoto.gx@renesas.com>	<s5hvcvhffnt.wl%tiwai@suse.de>	<87ei25fewa.wl%kuninori.morimoto.gx@renesas.com>	<87d3hpfefz.wl%kuninori.morimoto.gx@renesas.com>	<s5hmxgtfdvo.wl%tiwai@suse.de>	<87aactfdf0.wl%kuninori.morimoto.gx@renesas.com>	<s5hei25fd80.wl%tiwai@suse.de>	<878vsdfcd4.wl%kuninori.morimoto.gx@renesas.com>	<877h7xfbge.wl%kuninori.morimoto.gx@renesas.com>
	<s5h7h7xfah0.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from arroyo.ext.ti.com (arroyo.ext.ti.com [192.94.94.40])
	by alsa0.perex.cz (Postfix) with ESMTP id 2313710380C
	for <alsa-devel@alsa-project.org>;
	Tue,  5 Jul 2011 12:22:40 +0200 (CEST)
In-Reply-To: <s5h7h7xfah0.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>, "kuninori.morimoto.gx@renesas.com" <kuninori.morimoto.gx@renesas.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On 05/07/11 08:33, Takashi Iwai wrote:
> At Tue, 05 Jul 2011 00:12:04 -0700 (PDT),
> kuninori.morimoto.gx@renesas.com wrote:
>>
>>
>> Dear Mark, Liam
>>
>> These are fsi-xxx card name fixup patches.
>> It are needed for current linus tree.
>>
>> Kuninori Morimoto (3):
>>       ASoC: sh: fsi-ak4642: fixup snd_soc_card name
>>       ASoC: sh: fsi-da7210: fixup snd_soc_card name
>>       ASoC: sh: fsi-hdmi: fixup snd_soc_card name
> 
> The name string itself is allowed to contain spaces or other special
> letters.  These are copied to longname and shortname.
> But the driver_name string isn't, and the problem is to reuse the same
> string for it.
> 
> Since no driver sets driver_name string yet, a better fix would be
> to keep it empty like the earlier version.  The revised patch below.
> 

I can give a little background here, the intention is to allow a single "family" driver to support several different machines. i.e. the Panda, Blaze and SDP4430 are use the same "OMAP4" sound driver, but all have slightly different analog outputs (requiring slightly different userspace alsa-lib/UCM configs).

I do have a patch queued using driver name for OMAP4, but that will be for 3.2. 

> 
> Takashi
> 
> ---
> From: Takashi Iwai <tiwai@suse.de>
> Subject: [PATCH] ASoC: Don't set invalid name string to snd_card->driver
>  field
> 
> The snd_card->driver field contains a driver name string, and in
> general it shouldn't contain space or special letters.  The commit
> 2b39535b9e54888649923beaab443af212b6c0fd changed the string copy from
> card->name, but the long name string may contain such letters, thus
> it may still lead to a segfault.
> 
> A temporary fix is not to copy the long name string but just keep it
> empty as the earlier version did.
> 
> Reported-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> Signed-off-by: Takashi Iwai <tiwai@suse.de>

Acked-by: Liam Girdwood <lrg@ti.com>

> ---
>  sound/soc/soc-core.c |    5 +++--
>  1 files changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
> index d75043e..b194be0 100644
> --- a/sound/soc/soc-core.c
> +++ b/sound/soc/soc-core.c
> @@ -1929,8 +1929,9 @@ static void snd_soc_instantiate_card(struct snd_soc_card *card)
>  		 "%s", card->name);
>  	snprintf(card->snd_card->longname, sizeof(card->snd_card->longname),
>  		 "%s", card->long_name ? card->long_name : card->name);
> -	snprintf(card->snd_card->driver, sizeof(card->snd_card->driver),
> -		 "%s", card->driver_name ? card->driver_name : card->name);
> +	if (card->driver_name)
> +		strlcpy(card->snd_card->driver, card->driver_name,
> +			sizeof(card->snd_card->driver));
>  
>  	if (card->late_probe) {
>  		ret = card->late_probe(card);
