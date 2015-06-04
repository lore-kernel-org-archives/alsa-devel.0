From: Jun Nie <jun.nie@linaro.org>
Subject: Re: [PATCH v3 6/6] ASoC: zx: add zx296702 hdmi codec
Date: Thu, 4 Jun 2015 11:35:55 +0800
Message-ID: <CABymUCPN0dymyyLsY7WyEqnjCH-fOOHq32n+qqiwywBebks5fw@mail.gmail.com>
References: <1432906281-27698-1-git-send-email-jun.nie@linaro.org>
 <1432906281-27698-7-git-send-email-jun.nie@linaro.org>
 <20150603175801.GQ14071@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-lb0-f173.google.com (mail-lb0-f173.google.com
 [209.85.217.173])
 by alsa0.perex.cz (Postfix) with ESMTP id 2055C265DCD
 for <alsa-devel@alsa-project.org>; Thu,  4 Jun 2015 05:35:56 +0200 (CEST)
Received: by lbcue7 with SMTP id ue7so19196409lbc.0
 for <alsa-devel@alsa-project.org>; Wed, 03 Jun 2015 20:35:55 -0700 (PDT)
In-Reply-To: <20150603175801.GQ14071@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: Jason Liu <jason.liu@linaro.org>, alsa-devel@alsa-project.org, Shawn Guo <shawn.guo@linaro.org>, "wan.zhijun" <wan.zhijun@zte.com.cn>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

2015-06-04 1:58 GMT+08:00 Mark Brown <broonie@kernel.org>:
> On Fri, May 29, 2015 at 09:31:21PM +0800, Jun Nie wrote:
>
>> +int zx_hdmi_audio_cfg(int audio_codec, int audio_way,
>> +                   u32 sample_rate, u32 sample_len);
>> +void zx_hdmi_audio_en(int on);
>
> It's a bit hard to review this properly without knowing what these
> functions do.
>
>> +static int zx_hw_params(struct snd_pcm_substream *substream,
>> +                     struct snd_pcm_hw_params *params,
>> +                     struct snd_soc_dai *dai)
>> +{
>> +#ifdef CONFIG_ZX_HDMI_SND_SPDIF
>> +     zx_hdmi_audio_cfg(1, 0, params_rate(params),
>> +#endif
>> +#ifdef CONFIG_ZX_HDMI_SND_I2S
>> +     zx_hdmi_audio_cfg(1, 1, params_rate(params),
>> +#endif
>> +                       params_physical_width(params));
>> +     return 0;
>> +}
>
> The magic numbers aren't great and it does seem a bit odd to call both
> I2S and S/PDIF versions always - but I guess this will be restructured
> following our discussion in the other thread anyway.

Yes, HDMI audio will be moved into video driver side and I will add a
DT property to indicate active HDMI I2S or SPDIF from machine dts.

Will post patches with taking Lars's comments with dropping HDMI stuff.
