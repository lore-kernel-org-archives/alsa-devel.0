From: Kai-Heng Feng <kai.heng.feng@canonical.com>
Subject: Re: [PATCH v3] ASoC: rt286: fix headphone click/crack
 noise on Dell XPS 9343 I2S mode
Date: Thu, 23 Mar 2017 12:41:45 +0800
Message-ID: <CAAd53p4Wc0jH7D+hzeSX+nRWO-c9KemyXFSJL-KM7OnQCGfvbA@mail.gmail.com>
References: <20170320035831.10762-1-kai.heng.feng@canonical.com>
 <ABFD875FF5FB574BA706497D987D48D701C4E587@RTITEXTEMP.realtek.com.tw>
 <CAAd53p6rzVtV7kiBpChrHrrpTG1RhTiQbOZVU+wC1rFWeb=5ow@mail.gmail.com>
 <ABFD875FF5FB574BA706497D987D48D701C4F38E@RTITEXTEMP.realtek.com.tw>
 <CAAd53p6xiZEFvWnFt5KQU79tM9gvANHmYs=W3UKeC82Uks+ekg@mail.gmail.com>
 <ABFD875FF5FB574BA706497D987D48D701C52CFB@RTITEXTEMP.realtek.com.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yw0-f169.google.com (mail-yw0-f169.google.com
 [209.85.161.169])
 by alsa0.perex.cz (Postfix) with ESMTP id 2F330266A13
 for <alsa-devel@alsa-project.org>; Thu, 23 Mar 2017 05:41:47 +0100 (CET)
Received: by mail-yw0-f169.google.com with SMTP id p77so138935544ywg.1
 for <alsa-devel@alsa-project.org>; Wed, 22 Mar 2017 21:41:47 -0700 (PDT)
In-Reply-To: <ABFD875FF5FB574BA706497D987D48D701C52CFB@RTITEXTEMP.realtek.com.tw>
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

[snip]

> Let me explain it in more detail. rt5670 need to set a serious of
> registers to prevent the pop noise of powering up/down muting/
> unmuting headphone. That's what rt5670_hp_event() does. But,
> what rt286_hp_power_event do is only mute/unmute headphone
> which is done by "HPO L" and "HPO R" widget.

Thanks for the explanation.

[snip]

> If HPO is already muted as what we expected, it means "HPO L" and "HPO R"
> work properly. And there is no reason we create an event to do the same
> thing.

Can you advise me how to do a simple check on HPO L&R mute status?

>
>> >>
>> >> I found that the effect is most noticeable if the mute callback is
>> >> associated with "LDO2" and "HP Power".
>> >> But again, this is just what I observed.
>> >
>> > Could you try only associated with "LDO2"?
>> > It makes sense that will reduce the noise if a jack is plugged in/out
>> > when HPO is already powered up.
>>
>> Does it also help to reduce noise at other power events?
>
> I don't know. In theory, you shouldn't hear any sound when HPO
> is muted. If you need our help for debugging, please send a mail
> to our FAE and cc me.

Unfortunately it did happen. AMP mute did well for me and another user
- please check the bug report link.

>
>>
>> >
>> > I have question about the code below
>> > +               /* Fix headphone click noise */
>> > +               if (dmi_check_system(dmi_dell_dino))
>> > +                       regmap_write(rt286->regmap,
>> > +                                       RT286_MIC1_DET_CTRL,
>> 0x0020);
>> > +
>> >
>> > What does this for? How did you get the value 0x0020?
>> > I just checked with Kailang, but he have no idea about that.
>>
>> It's PIN_VREFHIZ. It's from commit 3e1b0c4a9d56.
>
> snd_hda_codec_set_pin_target(codec, 0x19, PIN_VREFHIZ);
> 0x19 here means nid 0x19. But if you write 0x19 in rt286.c means
> write a hidden register with index 0x19. It is totally different.
> The corresponding code on rt286.c will be
> rt286->regmap(rt286->regmap,
>         VERB_CMD(AC_VERB_SET_PIN_WIDGET_CONTROL, 0x19, 0x20));

Understood, will use it instead.

>>
>> >
>> >>
>> >> >
>> >> >
>> >>
>> >> ------Please consider the environment before printing this e-mail.
