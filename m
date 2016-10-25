From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH 2/2] ASoC: add Component level
	suspend/resume
Date: Tue, 25 Oct 2016 11:44:07 +0200
Message-ID: <2f63d518-670c-dea7-5225-a8f5e18bfd6a@metafoo.de>
References: <87vawhb5el.wl%kuninori.morimoto.gx@renesas.com>
 <87shrlb5bg.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from www381.your-server.de (www381.your-server.de [78.46.137.84])
 by alsa0.perex.cz (Postfix) with ESMTP id AF184260083
 for <alsa-devel@alsa-project.org>; Tue, 25 Oct 2016 11:44:14 +0200 (CEST)
In-Reply-To: <87shrlb5bg.wl%kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Mark Brown <broonie@kernel.org>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Simon <horms@verge.net.au>
List-Id: alsa-devel@alsa-project.org

On 10/25/2016 03:21 AM, Kuninori Morimoto wrote:
> 
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> 
> In current ALSA SoC, Codec only has suspend/resume feature.
> But it should be supported on Component level. This patch adds it.
> This patch replaces current codec_dev_list to component_dev_list.
> 
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>


This looks good, but can you move the removal of the codec_dev_list to a
separate patch. This will make it more clear what is going on. One patch to
move suspend to component, one patch to cleanup and remove codec_dev_list.

> ---
>  include/sound/soc.h                     |  9 ++--
>  sound/soc/intel/boards/broadwell.c      | 10 +++--
>  sound/soc/intel/boards/cht_bsw_rt5672.c | 10 +++--
>  sound/soc/soc-core.c                    | 73 +++++++++++++++++++--------------
>  4 files changed, 59 insertions(+), 43 deletions(-)
[...]
>  static int broadwell_suspend(struct snd_soc_card *card){
> -	struct snd_soc_codec *codec;
> +	struct snd_soc_component *component;
>  
> -	list_for_each_entry(codec, &card->codec_dev_list, card_list) {
> +	list_for_each_entry(component, &card->component_dev_list, card_list) {
> +		struct snd_soc_codec *codec = snd_soc_component_to_codec(component);

The case should happen after the name has been matched, otherwise we are
casting components that are not CODECs. Same for the other similar places.

>  		if (!strcmp(codec->component.name, "i2c-INT343A:00")) {
>  			dev_dbg(codec->dev, "disabling jack detect before going to suspend.\n");
>  			rt286_mic_detect(codec, NULL);
> @@ -233,9 +234,10 @@ static int broadwell_suspend(struct snd_soc_card *card){
>  }
