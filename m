From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: ASoC updates for 2.6.32
Date: Wed, 26 Aug 2009 19:15:46 +0100
Message-ID: <20090826181546.GA7914@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 3A78324433
	for <alsa-devel@alsa-project.org>;
	Wed, 26 Aug 2009 20:15:50 +0200 (CEST)
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
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The following changes since commit d09a2afc9359407114b7062519101f1ee2d05388:
  Jarkko Nikula (1):
        ARM: OMAP: McBSP: Merge two functions into omap_mcbsp_start/_stop

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound-2.6.git for-2.6.32

Candelaria Villareal, Jorge (1):
      ASoC: SDP3430: Fix TWL GPIO6 pin mux request

Mark Brown (4):
      ASoC: Add S3C24xx dependencies for Simtec machines
      ASoC: Make platform data optional for TLV320AIC3x
      ASoC: Fix s3c-i2s-v2 build
      ASoC: Don't reconfigure WM8350 FLL if not needed

Shine Liu (1):
      ASoC: S3C platform: Fix s3c2410_dma_started() called at improper time

 sound/soc/codecs/tlv320aic3x.c   |   13 ++++++-------
 sound/soc/codecs/wm8350.c        |    9 +++++++++
 sound/soc/omap/sdp3430.c         |   15 +++++++++++----
 sound/soc/s3c24xx/Kconfig        |    4 ++--
 sound/soc/s3c24xx/s3c-i2s-v2.c   |   11 +++++++++++
 sound/soc/s3c24xx/s3c2443-ac97.c |   10 ++++++++++
 sound/soc/s3c24xx/s3c24xx-i2s.c  |    5 +++++
 sound/soc/s3c24xx/s3c24xx-pcm.c  |    1 -
 8 files changed, 54 insertions(+), 14 deletions(-)
