From: Liam Girdwood <lrg@ti.com>
Subject: Re: [PATCH] ASoC: Convert WM9081 to table based
	control init
Date: Tue, 18 Oct 2011 08:49:13 +0100
Message-ID: <1318924153.4001.2.camel@odin>
References: <1318892044-26609-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog102.obsmtp.com (na3sys009aog102.obsmtp.com
	[74.125.149.69]) by alsa0.perex.cz (Postfix) with ESMTP id A485724371
	for <alsa-devel@alsa-project.org>;
	Tue, 18 Oct 2011 09:49:20 +0200 (CEST)
Received: by wwf5 with SMTP id 5so320216wwf.26
	for <alsa-devel@alsa-project.org>; Tue, 18 Oct 2011 00:49:16 -0700 (PDT)
In-Reply-To: <1318892044-26609-1-git-send-email-broonie@opensource.wolfsonmicro.com>
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
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

On Mon, 2011-10-17 at 23:54 +0100, Mark Brown wrote:
> At least for the core controls, the optionally selected controls are still
> added programatically.
> 
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> ---
>  sound/soc/codecs/wm9081.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/sound/soc/codecs/wm9081.c b/sound/soc/codecs/wm9081.c
> index f4fc03b..93f794c 100644
> --- a/sound/soc/codecs/wm9081.c
> +++ b/sound/soc/codecs/wm9081.c
> @@ -1235,8 +1235,6 @@ static int wm9081_probe(struct snd_soc_codec *codec)
>  	snd_soc_update_bits(codec, WM9081_ANALOGUE_SPEAKER_PGA,
>  			    WM9081_SPKPGAZC, WM9081_SPKPGAZC);
>  
> -	snd_soc_add_controls(codec, wm9081_snd_controls,
> -			     ARRAY_SIZE(wm9081_snd_controls));
>  	if (!wm9081->pdata.num_retune_configs) {
>  		dev_dbg(codec->dev,
>  			"No ReTune Mobile data, using normal EQ\n");
> @@ -1296,6 +1294,8 @@ static struct snd_soc_codec_driver soc_codec_dev_wm9081 = {
>  	.reg_cache_default = wm9081_reg_defaults,
>  	.volatile_register = wm9081_volatile_register,
>  
> +	.controls         = wm9081_snd_controls,
> +	.num_controls     = ARRAY_SIZE(wm9081_snd_controls),
>  	.dapm_widgets	  = wm9081_dapm_widgets,
>  	.num_dapm_widgets = ARRAY_SIZE(wm9081_dapm_widgets),
>  	.dapm_routes     = wm9081_audio_paths,

Acked-by: Liam Girdwood <lrg@ti.com>
