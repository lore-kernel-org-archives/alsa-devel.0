From: Sergey Lapin <slapin@ossfans.org>
Subject: McBSP troubles
Date: Sat, 21 Nov 2009 18:54:41 +0300
Message-ID: <48239d390911210754q5ef62784p4168a4e2a7324db0__11036.3366701224$1258821804$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from build.ossfans.org (build.ossfans.org [67.223.233.67])
	by alsa0.perex.cz (Postfix) with ESMTP id A42DD1037F3
	for <alsa-devel@alsa-project.org>; Sat, 21 Nov 2009 17:43:11 +0100 (CET)
Received: from build.ossfans.org ([127.0.0.1])
	by build.ossfans.org (8.14.3/8.14.3/Debian-5) with ESMTP id
	nALGhAEo024429
	for <alsa-devel@alsa-project.org>; Sat, 21 Nov 2009 19:43:10 +0300
Received: (from slapin@localhost)
	by build.ossfans.org (8.14.3/8.14.3/Submit) id nALGhA4n024428
	for alsa-devel@alsa-project.org; Sat, 21 Nov 2009 19:43:10 +0300
Resent-Message-ID: <20091121164310.GB23851@build.ossfans.org>
Resent-To: alsa-devel@alsa-project.org
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
List-Id: alsa-devel@alsa-project.org

Hi, all!

I have problems making any sound with current linux-omap master.
ASoC repository did not change anything either. I use slightly
modified (removed all GPIOs/jacks and different clock names because we
use OMAP3 instead of OMAP2 n810 uses)
sound/soc/omap/n810.c, with McBSP2. Codec is tlv320aic32 and
it is well supplied with 13 MHz clock, so should work happily.
Old 2.6.28-omap1 kernel + modifications works well with this,
but it lacks some fundamental features recently added to mainline and
linux-omap kernels, so we considered upgrading. Almost all stuff
on custom board works, except for sound, which I fight for several weeks
already, so I look for any help with this. I use OMAP3525 SoC.

Debugging output of
mcbsp driver is the following:
gnome5:~# aplay -c 2 -f S16_LE /dev/urandom
[ 4593.488159] disabling LINE_OUT
[ 4593.491302] disabling DMIC
[ 4593.494018] Disabling ASSYM pin
Playing raw data '/dev/urandom' : Signed 16 bit Little Endian, Rate
8000 Hz, Stereo
[ 4593.620086] omap-mcbsp omap-mcbsp.2: Configuring McBSP2  phys_base:
0x49022000
[ 4593.678375] gnome5_jack_event
[ 4593.735015] omap-mcbsp omap-mcbsp.2: **** McBSP2 regs ****
[ 4593.740539] omap-mcbsp omap-mcbsp.2: DRR2:  0xd907da5a
[ 4593.745697] omap-mcbsp omap-mcbsp.2: DRR1:  0x0000
[ 4593.750518] omap-mcbsp omap-mcbsp.2: DXR2:  0x0000
[ 4593.755340] omap-mcbsp omap-mcbsp.2: DXR1:  0x0000
[ 4593.760162] omap-mcbsp omap-mcbsp.2: SPCR2: 0x02f5
[ 4593.764984] omap-mcbsp omap-mcbsp.2: SPCR1: 0x0030
[ 4593.769805] omap-mcbsp omap-mcbsp.2: RCR2:  0x8041
[ 4593.774627] omap-mcbsp omap-mcbsp.2: RCR1:  0x0040
[ 4593.779449] omap-mcbsp omap-mcbsp.2: XCR2:  0x8041
[ 4593.784271] omap-mcbsp omap-mcbsp.2: XCR1:  0x0040
[ 4593.789093] omap-mcbsp omap-mcbsp.2: SRGR2: 0x001f
[ 4593.793884] omap-mcbsp omap-mcbsp.2: SRGR1: 0x0f00
[ 4593.798706] omap-mcbsp omap-mcbsp.2: PCR0:  0x000f
[ 4593.803527] omap-mcbsp omap-mcbsp.2: ***********************
[ 4603.811187] ALSA sound/core/pcm_lib.c:1708: playback write error
(DMA or IRQ trouble?)
[ 4614.818878] ALSA sound/core/pcm_lib.c:1708: playback write error
(DMA or IRQ trouble?)
aplay: pcm_write:1442: write error:

And no sound at all. Codec is supplied properly with clock, and
programmed normally, so
I think that's McBSP trouble, but I might be wrong.

Clock is supplied properly.
So, what is changed and needs updating? Is it McBSP or codec?
I see no signals using oscilloscope on _FSX and _CLKX.
Any ideas?

S.
