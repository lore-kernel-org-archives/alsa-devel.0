From: Stuart Longland <redhatter@gentoo.org>
Subject: Update on TLV320AIC3204 Driver
Date: Fri, 11 Jun 2010 15:55:12 +1000
Message-ID: <20100611055512.GG23431@www.longlandclan.yi.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ossa.mas.viperplatform.net.au (ossa.mas.viperplatform.net.au
	[202.147.75.25]) by alsa0.perex.cz (Postfix) with ESMTP id F1B732449D
	for <alsa-devel@alsa-project.org>;
	Fri, 11 Jun 2010 07:55:22 +0200 (CEST)
Received: from mail by ossa.mas.viperplatform.net.au with spam-scanned (Exim
	4.43) id 1OMxD1-0001fA-MN
	for alsa-devel@alsa-project.org; Fri, 11 Jun 2010 15:55:16 +1000
Received: from [203.94.56.252] (helo=longlandclan.yi.org)
	by ossa.mas.viperplatform.net.au with esmtp (Exim 4.43)
	id 1OMxCz-0001eF-6Y
	for alsa-devel@alsa-project.org; Fri, 11 Jun 2010 15:55:15 +1000
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Takashi Iwai <tiwai@suse.de>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Eric =?unknown-8bit?Q?B=C3=A9nard?= <eric@eukrea.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

Hi all,
	I've managed to get significantly further along with a driver
for the TLV320AIC3204, to the point now that I'm starting to look at
further things to tidy up for its inclusion into the kernel.  Some
issues I've faced however:

(1)	When using the SOC_DOUBLE_R_SX_TLV controls, I notice there's an
	odd interaction between the mute switch associated with the
	control, and its corresponding gain setting.
	
	Nothing changes in the actual registers (except the mute bit of
	course) but the displayed gain shoots up to infinity if the mute
	is toggled when the gain associated with that mute control is
	set below 0dB.  When the gain is at 0dB or above, toggling the
	mute has no effect on the displayed gain setting.

	Has anyone noticed this before and what would be the cause?

	For reference; the controls are defined in lines 395..414 of
	tlv320aic3204.c.

(2)	On the TLV320AIC3204, the clocks used on the audio bus can either
	be sourced from the ADC clocks, or the DAC clocks.  Naturally,
	before you see any clocks on the bus, you must first power up
	either the DAC or ADC (or both), and choose the appropriate
	source.  I do this currently in the hw_params callback (right
	where I *used* to power up the DACs/ADCs, DAPM does this now).

	The issue I see, is what happens when a playback stream starts,
	followed later by a recording stream.  All will be fine until
	the recording stream stops -- if the playback is still going, I
	fear the clocks will get shut off with the DAC, and the
	recording will come to a grinding halt.  Duplex will be okay
	since both recording and playback are synchronised events in
	this case... but I can see the potential for this alternate case
	causing problems.

	Therefore, I ask: Is there a way to control this via DAPM, so
	that, when the component supplying the bit clocks is shut down,
	the serial interface clock source is switched automatically to
	the alternate source?  (i.e. if DAC is shut down, switch to
	using the ADC clocks)

	For reference; the switching presently occurs in lines 917..924
	of tlv320aic3204.c.

(3)	The sysfs interface of my driver still remains.  I had a look at
	using the ASoC debugfs interface, however there are a *lot* of
	registers on the 'AIC3204 in a sparse memory map.  When I try to
	inspect the registers via
	/sys/kernel/debug/asoc/tlv320aic3204.0-0018/codec_reg ... I
	notice there are more registers in the device than are
	accessible via this interface:

	karo ~ # tail
	/sys/kernel/debug/asoc/tlv320aic3204.0-0018/codec_reg 
	tlv320aic3204-i2c 0-0018: aic3204_write: pg 0 reg 0[0000] <= 01
	tlv320aic3204-i2c 0-0018: aic3204_write: pg 0 reg 0[0000] <= 02
	tlv320aic3204-i2c 0-0018: aic3204_write: pg 0 reg 0[0000] <= 03
	tlv320aic3204-i2c 0-0018: aic3204_write: pg 0 reg 0[0000] <= 00
	tlv320aic3204-i2c 0-0018: aic3204_write: pg 0 reg 0[0000] <= 01
	tlv320aic3204-i2c 0-0018: aic3204_write: pg 0 reg 0[0000] <= 02
	tlv320aic3204-i2c 0-0018: aic3204_write: pg 0 reg 0[0000] <= 03
	1a7:    0
	1a8:    0
	1a9:    0
	1aa:    0
	1ab:    0
	1ac:    0
	1ad:    0
	1ae:    0
	1af:    0
	1b0:   karo ~ # 

	Notice it stops at 0x01b0 (corresponding to page 3, register
	48), with an incomplete line.  There were more registers, than
	there was buffer space to write the file.  Is there a way to
	increase this buffer?
	
	Or alternatively, should I perhaps port my sysfs interface to
	debugfs, and modify it to augment the existing debugfs
	interface?

The driver is still using the registration model that was used in kernel
2.6.34.  I've managed to backport the ALSA tree to 2.6.28 for our
project (since that's what's officially supported by Ka-Ro) and so far,
it's working, although things are still quite crude.

Since my last contact I've managed to figure out some aspects of DAPM,
for instance the DACs and ADCs are powered up and down by DAPM, whereas
I used to do this when setting the PLL manually.

I cache more of the registers now, I tried doing something "clever" and
skipping the pages of registers that aren't used and trying to cache
just the pages that were meaningful, but I noticed that the rest of ALSA
more or less assumed the register address used with cache was the real
address.  Digging around on the mailing list about how to handle a
sparse register map lead me to the solution of just biting the bullet
and caching all 80-odd pages.  Wasteful on memory, but I won't miss
anything.

The driver still has an initialisation script facility, whereby custom
register settings can be made at init.  I'm still undecided as to
whether to keep this or not... it's not the "done thing", but if I leave
it there, it allows for custom adaptive filtering coefficients and other
parameters to be set by the machine driver, which may be useful in some
applications.  Is it worth cleaning this up, or should it be ditched
before the driver is submitted for inclusion?

The driver is accessible online at
<http://www.longlandclan.yi.org/~stuartl/asoc/> along with some comments
about how to add it to your kernel sources.  I'd appreciate any feedback
or advice on how the driver can be improved.

Regards,
-- 
Stuart Longland (aka Redhatter, VK4MSL)      .'''.
Gentoo Linux/MIPS Cobalt and Docs Developer  '.'` :
. . . . . . . . . . . . . . . . . . . . . .   .'.'
http://dev.gentoo.org/~redhatter             :.'

I haven't lost my mind...
  ...it's backed up on a tape somewhere.
