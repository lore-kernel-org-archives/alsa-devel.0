From: Bard Liao <bardliao@realtek.com>
Subject: Re: [PATCH v3] ASoC: rt286: fix headphone click/crack
	noise on Dell XPS 9343 I2S mode
Date: Tue, 21 Mar 2017 08:59:27 +0000
Message-ID: <ABFD875FF5FB574BA706497D987D48D701C4F38E@RTITEXTEMP.realtek.com.tw>
References: <20170320035831.10762-1-kai.heng.feng@canonical.com>
 <ABFD875FF5FB574BA706497D987D48D701C4E587@RTITEXTEMP.realtek.com.tw>
 <CAAd53p6rzVtV7kiBpChrHrrpTG1RhTiQbOZVU+wC1rFWeb=5ow@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
 by alsa0.perex.cz (Postfix) with ESMTP id 8E1BB266CE6
 for <alsa-devel@alsa-project.org>; Tue, 21 Mar 2017 09:59:30 +0100 (CET)
In-Reply-To: <CAAd53p6rzVtV7kiBpChrHrrpTG1RhTiQbOZVU+wC1rFWeb=5ow@mail.gmail.com>
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
> Sent: Tuesday, March 21, 2017 1:39 PM
> To: Bard Liao
> Cc: broonie@kernel.org; lgirdwood@gmail.com; Oder Chiou;
> alsa-devel@alsa-project.org; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH v3] ASoC: rt286: fix headphone click/crack noise on Dell
> XPS 9343 I2S mode
> >>
> >> +     switch (event) {
> >> +     case SND_SOC_DAPM_PRE_PMD:
> >> +     case SND_SOC_DAPM_POST_PMD:
> >> +     case SND_SOC_DAPM_POST_PMU:
> >> +             snd_soc_write(codec, RT286_SET_AMP_GAIN_HPO,
> >> AMP_OUT_MUTE);
> >> +             break;
> >> +     case SND_SOC_DAPM_PRE_PMU:
> >> +             snd_soc_write(codec, RT286_SET_AMP_GAIN_HPO,
> >> AMP_OUT_UNMUTE);
> >> +             break;
> >
> > Besides Mark's comment, I have question here. It seems you want to mute
> > HPO before "HP Power" is powered up and after "HP Power" is powered
> down.
> > But "HPO L" and "HPO R" are autodisable. And "HP Power" is only connect to
> 
> What I really want to do is something rt5670's rt5670_hp_event(),
> maybe autodisable is not enough sometimes?

It is different. rt5670_hp_event() is doing depop sequence for
headphone. And there is no other mute/unmute controls on other
dapm widgets. For me, what you do here is not different from
"HPO L" and "HPO R" do.

> 
> > "HPO L" and "HPO R". From my understanding, HPO will mute if "HP Power"
> > is powered down. Any specific reason for muting HPO again before "HP
> Power"
> > is powered up?
> 
> You are right. Either one of them should be sufficient.

My point is that you seem to do things that driver is already done.
But why and how it can reduce the click noise?

> 
> > Will HPO be unmuted before "HP Power" is powered up on your system?
> 
> Yes.
> I am no audio expert here - but from what I read from HDA, there's
> actually no AMP unmute counterpart to AMP mute.

I didn't get it. How did you check if HPO is muted?

> 
> > Or should the event be associated with "LDO1"?  Which power will
> > cause the click noise?
> 
> I found that the effect is most noticeable if the mute callback is
> associated with "LDO2" and "HP Power".
> But again, this is just what I observed.

Could you try only associated with "LDO2"?
It makes sense that will reduce the noise if a jack is plugged in/out
when HPO is already powered up.

I have question about the code below
+		/* Fix headphone click noise */
+		if (dmi_check_system(dmi_dell_dino))
+			regmap_write(rt286->regmap,
+					RT286_MIC1_DET_CTRL, 0x0020);
+

What does this for? How did you get the value 0x0020?
I just checked with Kailang, but he have no idea about that.

> 
> >
> >
> 
> ------Please consider the environment before printing this e-mail.
