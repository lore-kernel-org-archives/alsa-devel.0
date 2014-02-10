From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: Re: Regression caused by "ASoC: core: Rework
 SOC_DOUBLE_R_SX_TLV add SOC_SINGLE_SX_TLV"
Date: Mon, 10 Feb 2014 15:22:44 +0100
Message-ID: <20140210152244.19f9d647@skate>
References: <20140130144807.5b102b28@skate>
 <alpine.DEB.2.10.1401300856050.10630@heelrod.ad.cirrus.com>
 <20140130160554.694a8a84@skate>
 <alpine.DEB.2.10.1401300922150.10630@heelrod.ad.cirrus.com>
 <alpine.DEB.2.10.1401300934340.10630@heelrod.ad.cirrus.com>
 <20140130175658.11469081@skate>
 <alpine.DEB.2.10.1401301108450.10630@heelrod.ad.cirrus.com>
 <20140130181607.6a694b8f@skate>
 <alpine.DEB.2.10.1401301122200.10630@heelrod.ad.cirrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.free-electrons.com (top.free-electrons.com [176.31.233.9])
 by alsa0.perex.cz (Postfix) with ESMTP id B70D22619D6
 for <alsa-devel@alsa-project.org>; Mon, 10 Feb 2014 15:23:06 +0100 (CET)
In-Reply-To: <alpine.DEB.2.10.1401301122200.10630@heelrod.ad.cirrus.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Brian Austin <brian.austin@cirrus.com>
Cc: Lior Amsalem <alior@marvell.com>, alsa-devel@alsa-project.org, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Mark Brown <broonie@kernel.org>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, Gregory =?UTF-8?B?Q2zDqW1lbnQ=?= <gregory.clement@free-electrons.com>
List-Id: alsa-devel@alsa-project.org

Dear Brian Austin,

On Thu, 30 Jan 2014 11:23:57 -0600, Brian Austin wrote:

> >>          SOC_DOUBLE_R_SX_TLV("Analog Playback Volume",
> >>                          CS42L51_AOUTA_VOL, CS42L51_AOUTB_VOL,
> >> -                       0, 0x34, 0xE4, aout_tlv),
> >> +                       8, 0xffffff19, 0x18, aout_tlv),
> >>          SOC_DOUBLE_R_SX_TLV("ADC Mixer Volume",
> >>
> >> shifting 8 on an 8bit register?
> >
> > These values are just the ones that were here before your commit
> > 1d99f2436d0d1c7741d6dfd9d27b5376cdbbca40. I didn't invent anything,
> > just reverted partially your commit.
> >
> Oh yes, of course. I was just making the comment that it looks very 
> strange to have that shift value. I'm glad it works for your system and 
> you can go forward with your development.
> 
> Once I get it figured out, I'll CC you on the submission for your review 
> and test.

Any news about this volume control problem on cs42l51 ?

Thanks!

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
