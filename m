From: Barry Song <21cnbao@gmail.com>
Subject: Re: [PATCH 5/6] ASoC: sirf-inner: add mach driver for
 SiRFSoC internal codec
Date: Thu, 25 Jul 2013 16:57:22 +0800
Message-ID: <CAGsJ_4w5G3ppgWdFYJ0-cMLbuvDMdy+dJneMshkeYz5MR6RW+Q@mail.gmail.com>
References: <1374232042-26088-1-git-send-email-Baohua.Song@csr.com>
 <1374232042-26088-6-git-send-email-Baohua.Song@csr.com>
 <20130719185101.GV9858@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qa0-f47.google.com (mail-qa0-f47.google.com
 [209.85.216.47])
 by alsa0.perex.cz (Postfix) with ESMTP id 2E48926030F
 for <alsa-devel@alsa-project.org>; Thu, 25 Jul 2013 10:57:43 +0200 (CEST)
Received: by mail-qa0-f47.google.com with SMTP id o19so2032184qap.13
 for <alsa-devel@alsa-project.org>; Thu, 25 Jul 2013 01:57:42 -0700 (PDT)
In-Reply-To: <20130719185101.GV9858@sirena.org.uk>
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
Cc: alsa-devel@alsa-project.org, lgirdwood@gmail.com, Workgroup.Linux@csr.com, Rongjun Ying <Rongjun.Ying@csr.com>, Barry Song <Baohua.Song@csr.com>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

2013/7/20 Mark Brown <broonie@kernel.org>:
> On Fri, Jul 19, 2013 at 07:07:21PM +0800, Barry Song wrote:
>
>> +#ifndef CONFIG_ANDROID
>> +     unsigned int            gpio_hp_detect;
>> +     struct snd_soc_jack     hp_jack;
>> +#endif
>
> Not for mainline.  I'd suggest setting it up for extcon anyway
> especially if it's just a simple accessory, that should work for both
> Android and mainline.

sounds good as if CONFIG_ANDROID is enabled without
CONFIG_ANDROID_SWITCH, /sys/class/switch/* will be symbolically linked
to /sys/class/extcon/, so that they are still compatible with legacy
userspace processes.

>
>> +static int sirf_inner_speaker_out_put(struct snd_kcontrol *kcontrol,
>> +             struct snd_ctl_elem_value *ucontrol)
>> +{
>> +     int is_spk_out = ucontrol->value.integer.value[0];
>> +     struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
>> +     struct snd_soc_card *card = codec->card;
>> +     struct sirf_inner_card *sinner_card = snd_soc_card_get_drvdata(card);
>> +
>> +     if (gpio_is_valid(sinner_card->gpio_spk_pa))
>> +             gpio_direction_output(sinner_card->gpio_spk_pa, is_spk_out);
>> +     return 0;
>> +}
>
> Oh, right.  If this is doing what I think this is doing you want to use
> DAPM within the CODEC then this can just become a pin switch or you can
> hook in directly if you continue to use soc-jack - it has DAPM
> integration.

ok. here it is more of machine stuff than codec stuff, so i think we
move to snd_soc_jack_gpio.

-barry
