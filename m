From: Xavier Hsu <xavier.hsu@linaro.org>
Subject: Re: [PATCHv3 2/9] WM8971 uses SOC_ENUM_SINGLE_DECL to
 replace SOC_ENUM_SINGLE
Date: Thu, 4 Sep 2014 11:53:44 +0800
Message-ID: <CAHa2TOb3yhKxmjynn+4f4G7Ly5U4ay8Z=heLE0g2TB04y=Szsg@mail.gmail.com>
References: <1409628470-13059-1-git-send-email-xavier.hsu@linaro.org>
 <1409628470-13059-2-git-send-email-xavier.hsu@linaro.org>
 <5405DA8C.7020403@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wi0-f177.google.com (mail-wi0-f177.google.com
 [209.85.212.177])
 by alsa0.perex.cz (Postfix) with ESMTP id 908C226109E
 for <alsa-devel@alsa-project.org>; Thu,  4 Sep 2014 05:53:44 +0200 (CEST)
Received: by mail-wi0-f177.google.com with SMTP id cc10so299808wib.16
 for <alsa-devel@alsa-project.org>; Wed, 03 Sep 2014 20:53:44 -0700 (PDT)
In-Reply-To: <5405DA8C.7020403@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Cc: Andy Green <andy.green@linaro.org>, alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Patch Tracking <patches@linaro.org>
List-Id: alsa-devel@alsa-project.org

Hi Charles and Lars-Peter :
Thanks for your feedback.
I will split into two patch (Modify De-emphasis and Using SOC_ENUM_SINGLE_DECL
macro to replace SOC_ENUM_SINGLE macro) and use local mutex to replace the
snd_soc_codec mutex.

Thanks.

BR,
Xavier


2014-09-02 22:56 GMT+08:00 Lars-Peter Clausen <lars@metafoo.de>:

> On 09/02/2014 05:27 AM, Xavier Hsu wrote:
> [...]
>
>  +static int wm8971_put_deemph(struct snd_kcontrol *kcontrol,
>> +                            struct snd_ctl_elem_value *ucontrol)
>> +{
>> +       struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
>> +       struct wm8971_priv *wm8971 = snd_soc_codec_get_drvdata(codec);
>> +       int deemph = ucontrol->value.enumerated.item[0];
>> +       int ret = 0;
>> +
>> +       if (deemph > 1)
>> +               return -EINVAL;
>> +
>> +       mutex_lock(&codec->mutex);
>>
>
> Please use a driver local mutex. The snd_soc_codec mutex is going to be
> removed sooner or later and we shouldn't add new users.
>
>
>  +       if (wm8971->deemph != deemph) {
>> +               wm8971->deemph = deemph;
>> +               wm8971_set_deemph(codec);
>> +
>> +               ret = 1;
>> +       }
>> +       mutex_unlock(&codec->mutex);
>> +
>> +       return ret;
>> +}
>>
>
>
