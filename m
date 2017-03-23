From: Bard Liao <bardliao@realtek.com>
Subject: Re: [PATCH v3] ASoC: rt286: fix headphone click/crack
	noise on Dell XPS 9343 I2S mode
Date: Thu, 23 Mar 2017 06:33:47 +0000
Message-ID: <ABFD875FF5FB574BA706497D987D48D701C5315B@RTITEXTEMP.realtek.com.tw>
References: <20170320035831.10762-1-kai.heng.feng@canonical.com>
 <ABFD875FF5FB574BA706497D987D48D701C4E587@RTITEXTEMP.realtek.com.tw>
 <CAAd53p6rzVtV7kiBpChrHrrpTG1RhTiQbOZVU+wC1rFWeb=5ow@mail.gmail.com>
 <ABFD875FF5FB574BA706497D987D48D701C4F38E@RTITEXTEMP.realtek.com.tw>
 <CAAd53p6xiZEFvWnFt5KQU79tM9gvANHmYs=W3UKeC82Uks+ekg@mail.gmail.com>
 <ABFD875FF5FB574BA706497D987D48D701C52CFB@RTITEXTEMP.realtek.com.tw>
 <CAAd53p4Wc0jH7D+hzeSX+nRWO-c9KemyXFSJL-KM7OnQCGfvbA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
 by alsa0.perex.cz (Postfix) with ESMTP id DAD312671D8
 for <alsa-devel@alsa-project.org>; Thu, 23 Mar 2017 07:37:45 +0100 (CET)
In-Reply-To: <CAAd53p4Wc0jH7D+hzeSX+nRWO-c9KemyXFSJL-KM7OnQCGfvbA@mail.gmail.com>
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
> Sent: Thursday, March 23, 2017 12:42 PM
> To: Bard Liao
> Cc: broonie@kernel.org; lgirdwood@gmail.com; Oder Chiou;
> alsa-devel@alsa-project.org; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH v3] ASoC: rt286: fix headphone click/crack noise on Dell
> XPS 9343 I2S mode
> 
> > If HPO is already muted as what we expected, it means "HPO L" and "HPO R"
> > work properly. And there is no reason we create an event to do the same
> > thing.
> 
> Can you advise me how to do a simple check on HPO L&R mute status?

You can cat /sys/kernel/debug/regmap/<bus name>/registers
And check the registers of 0x2139000 for HPOR and 0x213a000 for HPOL.
bit 15 = 1 for muted and 0 for unmuted.
for example
Mute:
2139000: 00000080
213a000: 00000080

UnMute:
2139000: 00000000
213a000: 00000000

> 
> >
> >> >>
> >> >> I found that the effect is most noticeable if the mute callback is
> >> >> associated with "LDO2" and "HP Power".
> >> >> But again, this is just what I observed.
> >> >
> >> > Could you try only associated with "LDO2"?
> >> > It makes sense that will reduce the noise if a jack is plugged in/out
> >> > when HPO is already powered up.
> >>
> >> Does it also help to reduce noise at other power events?
> >
> > I don't know. In theory, you shouldn't hear any sound when HPO
> > is muted. If you need our help for debugging, please send a mail
> > to our FAE and cc me.
> 
> Unfortunately it did happen. AMP mute did well for me and another user
> - please check the bug report link.

I know it happens. But it works fine on my Intel Ultrabook Development
System with upstream driver. So I need our FAE's help to check what
happened on Dell XPS. According to our company policy, you should
report the bug to Dell and Dell will contact our FAE if needed.
