From: Bard Liao <bardliao@realtek.com>
Subject: Re: [PATCH v3] ASoC: rt286: fix headphone click/crack
	noise on Dell XPS 9343 I2S mode
Date: Tue, 21 Mar 2017 09:15:18 +0000
Message-ID: <ABFD875FF5FB574BA706497D987D48D701C4F43D@RTITEXTEMP.realtek.com.tw>
References: <20170320035831.10762-1-kai.heng.feng@canonical.com>
 <20170320150845.7rltrhycdkk2mza4@sirena.org.uk>
 <CAAd53p53MnZcSEgS47wWcCfm48=J6O3ynjqBdfN6_1nhBMdNwA@mail.gmail.com>
 <20170320160622.5s2oqdyluvanjp2u@sirena.org.uk>
 <CAAd53p4T33uKEPVHET1F-PFVbW9R-JeKoCTzYwCP7+iM+j0+qg@mail.gmail.com>
 <20170320172647.t7qacxqcgawe7xlf@sirena.org.uk>
 <CAAd53p6GLKgJR=gkA+D1Zi2WHieTeZ478CWraeGF1-neWv5ObQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
 by alsa0.perex.cz (Postfix) with ESMTP id A2F502670F5
 for <alsa-devel@alsa-project.org>; Tue, 21 Mar 2017 10:15:26 +0100 (CET)
In-Reply-To: <CAAd53p6GLKgJR=gkA+D1Zi2WHieTeZ478CWraeGF1-neWv5ObQ@mail.gmail.com>
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
To: Kai-Heng Feng <kai.heng.feng@canonical.com>, Mark Brown <broonie@kernel.org>
Cc: Oder Chiou <oder_chiou@realtek.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Liam Girdwood <lgirdwood@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

> -----Original Message-----
> From: Kai-Heng Feng [mailto:kai.heng.feng@canonical.com]
> Sent: Tuesday, March 21, 2017 1:26 PM
> To: Mark Brown
> Cc: Liam Girdwood; Bard Liao; Oder Chiou; alsa-devel@alsa-project.org;
> linux-kernel@vger.kernel.org
> Subject: Re: [PATCH v3] ASoC: rt286: fix headphone click/crack noise on Dell
> XPS 9343 I2S mode
> >
> >> I had the same thought originally, but printk under each case suggests
> >> otherwise - _POST_PMU is triggered not right after _PRE_PMU but right
> >> before _PRE_PMD.
> >
> > Then you've broken something else on your system, that is obviously
> > completely nonsensical and would break anything that relies on having a
> > _POST_PMU event.  Why would we have two events that run at the same
> time
> > one of which is obviously misnamed?
> 
> Hmm, that's weird though. I did the same test to rt286_spk_event()
> (without applying the patch I sent), what I observed was the same:
> _POST_PMU was triggered right after I stopped play sound, i.e. right
> before _PRE_PMD not right after _PRE_PMU.
> 

Although I don't think it will happen on my side, but I still
ran the same test as you. The result is just as what we
expected, _PRE_PMU and _POST_PMU run on powering
up stage and _PRE_PMD and _POST_PMD run on powering
down stage. Please check what's going on with your system.


> ------Please consider the environment before printing this e-mail.
