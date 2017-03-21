From: Kai-Heng Feng <kai.heng.feng@canonical.com>
Subject: Re: [PATCH v3] ASoC: rt286: fix headphone click/crack
 noise on Dell XPS 9343 I2S mode
Date: Tue, 21 Mar 2017 13:38:55 +0800
Message-ID: <CAAd53p6rzVtV7kiBpChrHrrpTG1RhTiQbOZVU+wC1rFWeb=5ow@mail.gmail.com>
References: <20170320035831.10762-1-kai.heng.feng@canonical.com>
 <ABFD875FF5FB574BA706497D987D48D701C4E587@RTITEXTEMP.realtek.com.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yw0-f171.google.com (mail-yw0-f171.google.com
 [209.85.161.171])
 by alsa0.perex.cz (Postfix) with ESMTP id 9BAB9267000
 for <alsa-devel@alsa-project.org>; Tue, 21 Mar 2017 06:38:57 +0100 (CET)
Received: by mail-yw0-f171.google.com with SMTP id v198so103541240ywc.2
 for <alsa-devel@alsa-project.org>; Mon, 20 Mar 2017 22:38:57 -0700 (PDT)
In-Reply-To: <ABFD875FF5FB574BA706497D987D48D701C4E587@RTITEXTEMP.realtek.com.tw>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Bard Liao <bardliao@realtek.com>
Cc: Oder Chiou <oder_chiou@realtek.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "broonie@kernel.org" <broonie@kernel.org>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On Tue, Mar 21, 2017 at 11:07 AM, Bard Liao <bardliao@realtek.com> wrote:
>> -----Original Message-----
>> From: Kai-Heng Feng [mailto:kai.heng.feng@canonical.com]
>> Sent: Monday, March 20, 2017 11:59 AM
>> To: broonie@kernel.org
>> Cc: lgirdwood@gmail.com; Bard Liao; Oder Chiou;
>> alsa-devel@alsa-project.org; linux-kernel@vger.kernel.org; Kai-Heng Feng
>> Subject: [PATCH v3] ASoC: rt286: fix headphone click/crack noise on Dell XPS
>> 9343 I2S mode
>>
>> +     switch (event) {
>> +     case SND_SOC_DAPM_PRE_PMD:
>> +     case SND_SOC_DAPM_POST_PMD:
>> +     case SND_SOC_DAPM_POST_PMU:
>> +             snd_soc_write(codec, RT286_SET_AMP_GAIN_HPO,
>> AMP_OUT_MUTE);
>> +             break;
>> +     case SND_SOC_DAPM_PRE_PMU:
>> +             snd_soc_write(codec, RT286_SET_AMP_GAIN_HPO,
>> AMP_OUT_UNMUTE);
>> +             break;
>
> Besides Mark's comment, I have question here. It seems you want to mute
> HPO before "HP Power" is powered up and after "HP Power" is powered down.
> But "HPO L" and "HPO R" are autodisable. And "HP Power" is only connect to

What I really want to do is something rt5670's rt5670_hp_event(),
maybe autodisable is not enough sometimes?

> "HPO L" and "HPO R". From my understanding, HPO will mute if "HP Power"
> is powered down. Any specific reason for muting HPO again before "HP Power"
> is powered up?

You are right. Either one of them should be sufficient.

> Will HPO be unmuted before "HP Power" is powered up on your system?

Yes.
I am no audio expert here - but from what I read from HDA, there's
actually no AMP unmute counterpart to AMP mute.

> Or should the event be associated with "LDO1"?  Which power will
> cause the click noise?

I found that the effect is most noticeable if the mute callback is
associated with "LDO2" and "HP Power".
But again, this is just what I observed.

>
>
