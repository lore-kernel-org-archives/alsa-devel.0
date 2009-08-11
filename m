From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: ASoC updates for 2.6.32
Date: Tue, 11 Aug 2009 17:31:06 +0100
Message-ID: <20090811163106.GA3603@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id E807724CCA
	for <alsa-devel@alsa-project.org>;
	Tue, 11 Aug 2009 18:31:08 +0200 (CEST)
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

The following changes since commit e0c48a18f76415d3ec1ac28e5f7a0df10e2f3d8c:
  Mark Brown (1):
        ASoC: Drop unneeded declaration of removed wm8731 SPI write function

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound-2.6.git for-2.6.32

Daniel Ribeiro (1):
      ASoC: change set_tdm_slot api to allow slot_width override.

Mark Brown (2):
      Merge commit 'a5479e389e989acfeca9c32eeb0083d086202280' into for-2.6.32
      ASoC: Update WM9081 for tdm_slot() API change

Randy Dunlap (1):
      ASoC: fix I2C build errors

 include/sound/soc-dai.h   |    5 ++-
 sound/soc/codecs/wm9081.c |   63 ++++++++++++++++++++++++++------------------
 sound/soc/pxa/magician.c  |    2 +-
 sound/soc/pxa/pxa-ssp.c   |   27 ++++++++++++++-----
 sound/soc/soc-cache.c     |    4 +-
 sound/soc/soc-core.c      |    9 ++++--
 6 files changed, 69 insertions(+), 41 deletions(-)
