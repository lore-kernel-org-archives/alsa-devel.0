From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: ASoC updaets
Date: Mon, 22 Dec 2008 16:36:47 +0000
Message-ID: <20081222163646.GA20181@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 324C21037FA
	for <alsa-devel@alsa-project.org>; Mon, 22 Dec 2008 17:36:48 +0100 (CET)
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

The following changes since commit a31501d1041c9d0a6c3f520736ae2b2fa081493a:
  Takashi Iwai (1):
        ALSA: ASoC - Add missing __devexit annotation to wm8350.c

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound-2.6.git for-tiwai

Jarkko Nikula (2):
      ASoC: Fix incorrect DSP format in OMAP McBSP DAI and affected drivers
      ASoC: Fix DSP formats in SSM2602 audio codec

 sound/soc/codecs/ssm2602.c     |    4 ++--
 sound/soc/codecs/tlv320aic23.c |    2 +-
 sound/soc/omap/omap-mcbsp.c    |    4 ++--
 sound/soc/omap/osk5912.c       |    4 ++--
 4 files changed, 7 insertions(+), 7 deletions(-)
