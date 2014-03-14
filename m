From: Rongjun Ying <Rongjun.Ying@csr.com>
Subject: Re: [PATCH 1/2] ASoC: sirf-audio-codec: Remove
 snd_soc_codec_set_cache_io() call
Date: Fri, 14 Mar 2014 10:16:08 +0000
Message-ID: <86130EF012BDF348AA0D464A4F449478012AE585CE@SHAASIEXM01.ASIA.ROOT.PRI>
References: <1394785572-28315-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cluster-g.mailcontrol.com (cluster-g.mailcontrol.com
 [208.87.233.190])
 by alsa0.perex.cz (Postfix) with ESMTP id EE3922652F8
 for <alsa-devel@alsa-project.org>; Fri, 14 Mar 2014 11:16:19 +0100 (CET)
In-Reply-To: <1394785572-28315-1-git-send-email-lars@metafoo.de>
Content-Language: zh-CN
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: Barry Song <baohua@kernel.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org



> -----Original Message-----
> From: Lars-Peter Clausen [mailto:lars@metafoo.de]
> Sent: Friday, March 14, 2014 4:26 PM
> To: Mark Brown; Liam Girdwood
> Cc: Rongjun Ying; Barry Song; alsa-devel@alsa-project.org; Lars-Peter
> Clausen
> Subject: [PATCH 1/2] ASoC: sirf-audio-codec: Remove
> snd_soc_codec_set_cache_io() call
> 
> There was a overlap between the snd_soc_codec_set_cache_io() cleanup
> and the addition of the sirf-audio-codec resulting in the sirf-audio-
> codec driver still using the old signature of
> snd_soc_codec_set_cache_io(), which will cause a compile error. Since
> the core is able to automatically setup IO for this driver we can just
> remove both the snd_soc_set_cache_io() call and the control_data
> assignment.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> ---
>  sound/soc/codecs/sirf-audio-codec.c | 9 ---------
>  1 file changed, 9 deletions(-)
> 
> diff --git a/sound/soc/codecs/sirf-audio-codec.c
> b/sound/soc/codecs/sirf-audio-codec.c
> index 90e3a22..58e7c1f 100644
> --- a/sound/soc/codecs/sirf-audio-codec.c
> +++ b/sound/soc/codecs/sirf-audio-codec.c
> @@ -337,18 +337,9 @@ struct snd_soc_dai_driver sirf_audio_codec_dai = {
> 
>  static int sirf_audio_codec_probe(struct snd_soc_codec *codec)  {
> -	int ret;
>  	struct snd_soc_dapm_context *dapm = &codec->dapm;
> -	struct sirf_audio_codec *sirf_audio_codec =
> snd_soc_codec_get_drvdata(codec);
> 
>  	pm_runtime_enable(codec->dev);
> -	codec->control_data = sirf_audio_codec->regmap;
> -
> -	ret = snd_soc_codec_set_cache_io(codec, 0, 0, SND_SOC_REGMAP);
> -	if (ret != 0) {
> -		dev_err(codec->dev, "Failed to set cache I/O: %d\n", ret);
> -		return ret;
> -	}
> 

May be need invoke snd_soc_codec_set_cache_io(codec, sirf_audio_codec->regmap)?

>  	if (of_device_is_compatible(codec->dev->of_node, "sirf,prima2-
> audio-codec")) {
>  		snd_soc_dapm_new_controls(dapm,
> --
> 1.8.0
> 
> 
> 
>  To report this email as spam click
> https://www.mailcontrol.com/sr/MZbqvYs5QwJvpeaetUwhCQ==
> 7ZVumiOHvh5meKBFThUi75+9byUhoVPh5vdkxH4nYzTQYQ== .

Thanks
RongJun Ying


Member of the CSR plc group of companies. CSR plc registered in England and Wales, registered number 4187346, registered office Churchill House, Cambridge Business Park, Cowley Road, Cambridge, CB4 0WZ, United Kingdom
More information can be found at www.csr.com. Keep up to date with CSR on our technical blog, www.csr.com/blog, CSR people blog, www.csr.com/people, YouTube, www.youtube.com/user/CSRplc, Facebook, www.facebook.com/pages/CSR/191038434253534, or follow us on Twitter at www.twitter.com/CSR_plc.
New for 2014, you can now access the wide range of products powered by aptX at www.aptx.com.
