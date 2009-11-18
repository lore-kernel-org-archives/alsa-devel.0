From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: ASoC updates for 2.6.32
Date: Wed, 18 Nov 2009 14:30:07 +0000
Message-ID: <20091118143007.GA13345@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id EC91724335
	for <alsa-devel@alsa-project.org>; Wed, 18 Nov 2009 15:30:08 +0100 (CET)
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
To: Takaahi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

The following changes since commit 6fc786d5034ed7ce2d43c459211137de6d99dd28:
  Jassi Brar (1):
        ASoC: S3C64XX I2S: Enable audio-bus clock

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound-2.6.git for-2.6.32

All very driver-local so should be low impact.

Anuj Aggarwal (1):
      ASoC: Modifying the license string GPLv2 for OMAP3 EVM

Grazvydas Ignotas (1):
      ASoC: OMAP3 Pandora: update for TWL4030 codec changes

Troy Kisky (1):
      ASoC: tlv320aic23 fix rate selection

 sound/soc/codecs/tlv320aic23.c |    2 +-
 sound/soc/omap/omap3evm.c      |    2 +-
 sound/soc/omap/omap3pandora.c  |    3 ++-
 3 files changed, 4 insertions(+), 3 deletions(-)
