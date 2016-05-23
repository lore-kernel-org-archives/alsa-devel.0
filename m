From: Petr Kulhavy <petr@barix.com>
Subject: Re: [PATCH v2 2/2] ASoC: wm8985: add support for WM8758
Date: Mon, 23 May 2016 09:34:26 +0200
Message-ID: <CAEP=dzAarh55OFtFvnK0amreBaip3oFxq=bih-bwAXPu4O7hjQ@mail.gmail.com>
References: <1463489334-17549-1-git-send-email-petr@barix.com>
 <1463489334-17549-3-git-send-email-petr@barix.com>
 <20160520161143.GQ1646@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yw0-f176.google.com (mail-yw0-f176.google.com
 [209.85.161.176])
 by alsa0.perex.cz (Postfix) with ESMTP id 77EF026043C
 for <alsa-devel@alsa-project.org>; Mon, 23 May 2016 09:34:46 +0200 (CEST)
Received: by mail-yw0-f176.google.com with SMTP id c127so46020821ywb.1
 for <alsa-devel@alsa-project.org>; Mon, 23 May 2016 00:34:46 -0700 (PDT)
In-Reply-To: <20160520161143.GQ1646@localhost.localdomain>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Cc: Plamen Prodanov <plamen@barix.com>, ALSA Development Mailing List <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

On 20 May 2016 at 18:11, Charles Keepax
<ckeepax@opensource.wolfsonmicro.com> wrote:
> On Tue, May 17, 2016 at 02:48:54PM +0200, Petr Kulhavy wrote:
>> The WM8758 chip is almost identical to WM8985 with the difference that it
>> doesn't feature the AUX input. This patch adds the WM8758 support into the
>> WM8985 driver.
>>
>> The chip selection is done by the I2C name. The SPI probe supports only
>> the WM8985.
>>
>> Signed-off-by: Petr Kulhavy <petr@barix.com>
>> ---
>> +
>> +static int wm8985_add_widgets(struct snd_soc_codec *codec)
>> +{
>> +     struct wm8985_priv *wm8985 = snd_soc_codec_get_drvdata(codec);
>> +     struct snd_soc_dapm_context *dapm = snd_soc_codec_get_dapm(codec);
>> +
>> +     snd_soc_dapm_new_controls(dapm, wm8985_common_dapm_widgets,
>> +             ARRAY_SIZE(wm8985_common_dapm_widgets));
>> +     snd_soc_dapm_add_routes(dapm, wm8985_common_dapm_routes,
>> +             ARRAY_SIZE(wm8985_common_dapm_routes));
>> +
>> +     switch (wm8985->dev_type) {
>> +     case WM8758:
>> +             snd_soc_add_codec_controls(codec, wm8985_alc_snd_controls,
>> +                     ARRAY_SIZE(wm8985_alc_snd_controls));
>> +             snd_soc_add_codec_controls(codec, wm8985_adc_snd_controls,
>> +                     ARRAY_SIZE(wm8985_adc_snd_controls));
>> +             snd_soc_add_codec_controls(codec, wm8985_dac_snd_controls,
>> +                     ARRAY_SIZE(wm8985_dac_snd_controls));
>> +             snd_soc_add_codec_controls(codec, wm8985_eq_snd_controls,
>> +                     ARRAY_SIZE(wm8985_eq_snd_controls));
>> +             snd_soc_add_codec_controls(codec, wm8985_3d_snd_controls,
>> +                     ARRAY_SIZE(wm8985_3d_snd_controls));
>
> Why not just put all these in a common controls array? They seem
> to all be used on 8985 as well.

In general I agree with you. But doesn't the order in which
snd_soc_add_codec_controls() is called affect the order in which the
controls appear in the mixer?
I have split the controls in order to preserve the original order of
the controls.

>>  err_reg_enable:
>> @@ -1047,13 +1164,6 @@ static struct snd_soc_codec_driver soc_codec_dev_wm8985 = {
>>       .probe = wm8985_probe,
>>       .set_bias_level = wm8985_set_bias_level,
>>       .suspend_bias_off = true,
>> -
>> -     .controls = wm8985_snd_controls,
>> -     .num_controls = ARRAY_SIZE(wm8985_snd_controls),
>> -     .dapm_widgets = wm8985_dapm_widgets,
>> -     .num_dapm_widgets = ARRAY_SIZE(wm8985_dapm_widgets),
>> -     .dapm_routes = wm8985_dapm_routes,
>> -     .num_dapm_routes = ARRAY_SIZE(wm8985_dapm_routes),
>
> I think you should still be able to use these for the common
> functionality.

All these are set by wm8985_add_widgets() now.
Or maybe I didn't quite get what you mean?

Thanks
Petr
