From: Pavel Hofman <pavel.hofman@ivitera.com>
Subject: Re: [PATCH 3/4] Add Wolfson Microelectronics WM8776
 codec ALSA driver
Date: Tue, 17 Apr 2012 22:16:01 +0200
Message-ID: <4F8DCF81.4080508@ivitera.com>
References: <1334611118-10301-1-git-send-email-linux@rainbow-software.org>
	<20120417170431.GT6652@opensource.wolfsonmicro.com>
	<s5h3982p71g.wl%tiwai@suse.de>
	<201204172015.14582.linux@rainbow-software.org>
	<20120417182204.GV6652@opensource.wolfsonmicro.com>
	<s5hwr5enpau.wl%tiwai@suse.de>
	<20120417194341.GX6652@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cable.insite.cz (static-84-242-75-189.net.upcbroadband.cz
	[84.242.75.189]) by alsa0.perex.cz (Postfix) with ESMTP id C197D24330
	for <alsa-devel@alsa-project.org>;
	Tue, 17 Apr 2012 22:16:16 +0200 (CEST)
In-Reply-To: <20120417194341.GX6652@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Ondrej Zary <linux@rainbow-software.org>
List-Id: alsa-devel@alsa-project.org

Dne 17.4.2012 21:43, Mark Brown napsal(a):
>
> That's the case in the PC world but obviously this is exactly how
> essentially all embedded systems are built up.  It needs to be very
> clear that this is just legacy code for these old PC sound cards and
> nothing else, nothing about either the directory naming or the changelog
> here suggests that this is anything other than the standard way to add
> support for new CODECs to ALSA.
>
> We usually have to go through a loop of "you need to use the frameworks"
> with new vendors, we need to make the process of figuring out what they
> should do as simple as we can.

Mark, I have always viewed alsa drivers as split to two parts

1. the "PC world" where mostly individual often amateur developers post 
patches improving support of the hardware they own.

2. the ASoC world of embedded solutions, where mostly vendors contribute 
patches for the hardware they produce. All ASoC posts are prefixed by 
ASoC and I have always viewed them as something I do not have to care 
about when fixing and developing stuff for PCI.

Even the until recently highly active intel-hda section does not use any 
of the ASoC infrastructure. If you read the ASoC documentation 
http://alsa-project.org/main/index.php/ASoC, it would not occur to me I 
should be using asoc codecs infrastructure for ice1724 card.

If you want these independent contributors to start using the kernel 
infrastructure common in the ASoC "tree", please tell them clearly on 
the alsa-project.org website, at best directly at 
http://alsa-project.org/main/index.php/Developer_Zone

Working hard on series of patches and being met with cold attitude as 
for not adhering to ASoC standards (quoting the alsa-project.org: "The 
overall project goal of the ALSA System on Chip (ASoC) layer is to 
provide better ALSA support for embedded system on chip procesors") the 
developer had no idea he was supposed to follow is not really 
motivating. And I think every helpful hand and brain counts here.

I can understand the very active ASoC subproject is defining current 
standards for the rest of alsa tree but please tell the currently valid 
rules to all the developers.

Thanks a lot for understanding,

Pavel.
