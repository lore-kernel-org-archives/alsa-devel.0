From: Bard Liao <bardliao@realtek.com>
Subject: Re: [PATCH v3] ASoC: rt286: fix headphone click/crack
	noise on Dell XPS 9343 I2S mode
Date: Thu, 23 Mar 2017 03:29:45 +0000
Message-ID: <ABFD875FF5FB574BA706497D987D48D701C52CFB@RTITEXTEMP.realtek.com.tw>
References: <20170320035831.10762-1-kai.heng.feng@canonical.com>
 <ABFD875FF5FB574BA706497D987D48D701C4E587@RTITEXTEMP.realtek.com.tw>
 <CAAd53p6rzVtV7kiBpChrHrrpTG1RhTiQbOZVU+wC1rFWeb=5ow@mail.gmail.com>
 <ABFD875FF5FB574BA706497D987D48D701C4F38E@RTITEXTEMP.realtek.com.tw>
 <CAAd53p6xiZEFvWnFt5KQU79tM9gvANHmYs=W3UKeC82Uks+ekg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
 by alsa0.perex.cz (Postfix) with ESMTP id 76F08266A13
 for <alsa-devel@alsa-project.org>; Thu, 23 Mar 2017 04:29:51 +0100 (CET)
In-Reply-To: <CAAd53p6xiZEFvWnFt5KQU79tM9gvANHmYs=W3UKeC82Uks+ekg@mail.gmail.com>
Content-Language: zh-TW
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc: Oder Chiou <oder_chiou@realtek.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "broonie@kernel.org" <broonie@kernel.org>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

> -----Original Message-----
> From: Kai-Heng Feng [mailto:kai.heng.feng@canonical.com]
> Sent: Wednesday, March 22, 2017 1:37 PM
> To: Bard Liao
> Cc: broonie@kernel.org; lgirdwood@gmail.com; Oder Chiou;
> alsa-devel@alsa-project.org; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH v3] ASoC: rt286: fix headphone click/crack noise on Dell
> XPS 9343 I2S mode
> 
> >> What I really want to do is something rt5670's rt5670_hp_event(),
> >> maybe autodisable is not enough sometimes?
> >
> > It is different. rt5670_hp_event() is doing depop sequence for
> > headphone. And there is no other mute/unmute controls on other
> > dapm widgets. For me, what you do here is not different from
> > "HPO L" and "HPO R" do.
> 
> There are two issues - background click noise and the cracking pop noise.
> Depop is exactly what I want to do here.

Let me explain it in more detail. rt5670 need to set a serious of
registers to prevent the pop noise of powering up/down muting/
unmuting headphone. That's what rt5670_hp_event() does. But,
what rt286_hp_power_event do is only mute/unmute headphone
which is done by "HPO L" and "HPO R" widget.

> 
> >
> >>
> >> > "HPO L" and "HPO R". From my understanding, HPO will mute if "HP
> Power"
> >> > is powered down. Any specific reason for muting HPO again before "HP
> >> Power"
> >> > is powered up?
> >>
> >> You are right. Either one of them should be sufficient.
> >
> > My point is that you seem to do things that driver is already done.
> > But why and how it can reduce the click noise?
> 
> This is for the crack (pop) noise not click noise - see below.
> 
> >
> >>
> >> > Will HPO be unmuted before "HP Power" is powered up on your system?
> >>
> >> Yes.
> >> I am no audio expert here - but from what I read from HDA, there's
> >> actually no AMP unmute counterpart to AMP mute.
> >
> > I didn't get it. How did you check if HPO is muted?
> 
> I didn't. Now sure why do we need to check that?

If HPO is already muted as what we expected, it means "HPO L" and "HPO R"
work properly. And there is no reason we create an event to do the same
thing.

> >>
> >> I found that the effect is most noticeable if the mute callback is
> >> associated with "LDO2" and "HP Power".
> >> But again, this is just what I observed.
> >
> > Could you try only associated with "LDO2"?
> > It makes sense that will reduce the noise if a jack is plugged in/out
> > when HPO is already powered up.
> 
> Does it also help to reduce noise at other power events?

I don't know. In theory, you shouldn't hear any sound when HPO
is muted. If you need our help for debugging, please send a mail
to our FAE and cc me.

> 
> >
> > I have question about the code below
> > +               /* Fix headphone click noise */
> > +               if (dmi_check_system(dmi_dell_dino))
> > +                       regmap_write(rt286->regmap,
> > +                                       RT286_MIC1_DET_CTRL,
> 0x0020);
> > +
> >
> > What does this for? How did you get the value 0x0020?
> > I just checked with Kailang, but he have no idea about that.
> 
> It's PIN_VREFHIZ. It's from commit 3e1b0c4a9d56.

snd_hda_codec_set_pin_target(codec, 0x19, PIN_VREFHIZ);
0x19 here means nid 0x19. But if you write 0x19 in rt286.c means
write a hidden register with index 0x19. It is totally different.
The corresponding code on rt286.c will be
rt286->regmap(rt286->regmap,
	VERB_CMD(AC_VERB_SET_PIN_WIDGET_CONTROL, 0x19, 0x20));
> 
> >
> >>
> >> >
> >> >
> >>
> >> ------Please consider the environment before printing this e-mail.
