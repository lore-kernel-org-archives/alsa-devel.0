From: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: [PATCH 16/17] ASoC: Basic split of mpc5200 DMA
	code out from mpc5200_psc_i2s
Date: Tue, 28 Apr 2009 15:32:18 -0400
Message-ID: <9e4733910904281232s32e73f3ka793fdbe5b5db9a0@mail.gmail.com>
References: <20090428152256.GB2244@rakim.wolfsonmicro.main>
	<1240932222-3718-16-git-send-email-broonie@opensource.wolfsonmicro.com>
	<s5hljpk233w.wl%tiwai@suse.de> <20090428192543.GA4241@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from qw-out-1920.google.com (qw-out-1920.google.com [74.125.92.147])
	by alsa0.perex.cz (Postfix) with ESMTP id 66EBF24569
	for <alsa-devel@alsa-project.org>;
	Tue, 28 Apr 2009 21:32:19 +0200 (CEST)
Received: by qw-out-1920.google.com with SMTP id 4so567222qwk.56
	for <alsa-devel@alsa-project.org>; Tue, 28 Apr 2009 12:32:18 -0700 (PDT)
In-Reply-To: <20090428192543.GA4241@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@sirena.org.uk>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, Apr 28, 2009 at 3:25 PM, Mark Brown <broonie@sirena.org.uk> wrote:
> On Tue, Apr 28, 2009 at 05:46:11PM +0200, Takashi Iwai wrote:
>
>> And, the jiffies check shall be anyway fixed in the upstream PCM core
>> side, thus there is no big merit to hurry to merge the unfinished
>> changes now.
>
> The refactoring is a largely orthogonal issue to the jiffies check - the
> refactoring is needed to split the DMA code out so that it can be shared
> with the AC97 driver John is writing.
>
>> So, could you back off mpc5200 changes and wait for a while until the
>> issue regarding PCM jiffies-check is resolved?
>
> Done:

Now I get to deal with the merge mess in my patch stack. All this did
was move the problem.


>
> The following changes since commit 8a1f936acdfd53cb0a981f3f80483863dcd84f=
a9:
> =A0Peter Ujfalusi (1):
> =A0 =A0 =A0 =A0ASoC: TWL4030: Add 4 channel TDM support
>
> are available in the git repository at:
>
> =A0git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound-2.6.git fo=
r-2.6.31
>
> Daniel Mack (3):
> =A0 =A0 =A0ASoC: add SOC_DOUBLE_EXT macro
> =A0 =A0 =A0ASoC: cs4270: fix Master Capture Switch polarity
> =A0 =A0 =A0ASoC: cs4270: add Master Playback Switch
>
> Jon Smirl (1):
> =A0 =A0 =A0ASoC: Set the MPC5200 i2s driver to BROKEN status.
>
> Jonathan Cameron (1):
> =A0 =A0 =A0ASoC WM8940 Driver
>
> Joonyoung Shim (1):
> =A0 =A0 =A0ASoC: TWL4030: Fix gain control for earpiece amplifier
>
> Mark Brown (10):
> =A0 =A0 =A0ASoC: Fix S3C64xx IIS device registration and support both por=
ts
> =A0 =A0 =A0ASoC: S3C2412: Failing to get the I2S clock is an error
> =A0 =A0 =A0ASoC: Enforce symmetric rates for S3C64xx I2S interface
> =A0 =A0 =A0ASoC: Include WM8350 register definitions in CODEC header
> =A0 =A0 =A0ASoC: s3c-i2s-v2 diagnostic improvements
> =A0 =A0 =A0ASoC: Use our registration function for S3C64xx
> =A0 =A0 =A0ASoC: Fix logic in WM8350 master clocking check
> =A0 =A0 =A0Merge branch 'for-2.6.30' into for-2.6.31
> =A0 =A0 =A0ASoC: Staticise TLV values in WM8940
> =A0 =A0 =A0Merge branch 'for-2.6.30' into for-2.6.31
>
> Peter Ujfalusi (1):
> =A0 =A0 =A0ASoC: Beagle: Add support for 4 channel
>
> =A0include/sound/soc.h =A0 =A0 =A0 =A0 =A0 =A0 | =A0 =A08 +
> =A0sound/soc/codecs/Kconfig =A0 =A0 =A0 =A0| =A0 =A04 +
> =A0sound/soc/codecs/Makefile =A0 =A0 =A0 | =A0 =A02 +
> =A0sound/soc/codecs/cs4270.c =A0 =A0 =A0 | =A0 44 ++-
> =A0sound/soc/codecs/twl4030.c =A0 =A0 =A0| =A0 =A08 +-
> =A0sound/soc/codecs/wm8350.c =A0 =A0 =A0 | =A0 =A02 +-
> =A0sound/soc/codecs/wm8350.h =A0 =A0 =A0 | =A0 =A01 +
> =A0sound/soc/codecs/wm8940.c =A0 =A0 =A0 | =A0955 +++++++++++++++++++++++=
++++++++++++++++
> =A0sound/soc/codecs/wm8940.h =A0 =A0 =A0 | =A0104 +++++
> =A0sound/soc/fsl/Kconfig =A0 =A0 =A0 =A0 =A0 | =A0 =A02 +-
> =A0sound/soc/omap/omap3beagle.c =A0 =A0| =A0 26 +-
> =A0sound/soc/s3c24xx/s3c2412-i2s.c | =A0 =A02 +-
> =A0sound/soc/s3c24xx/s3c64xx-i2s.c | =A0148 ++++--
> =A0sound/soc/s3c24xx/s3c64xx-i2s.h | =A0 =A02 +-
> =A014 files changed, 1241 insertions(+), 67 deletions(-)
> =A0create mode 100644 sound/soc/codecs/wm8940.c
> =A0create mode 100644 sound/soc/codecs/wm8940.h
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>



-- =

Jon Smirl
jonsmirl@gmail.com
