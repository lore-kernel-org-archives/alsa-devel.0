From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: ASoC updates for 2.6.39
Date: Wed, 23 Mar 2011 10:57:54 +0000
Message-ID: <20110323105753.GA1191@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id A39AC24461
	for <alsa-devel@alsa-project.org>; Wed, 23 Mar 2011 11:57:41 +0100 (CET)
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
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

The following changes since commit e58a8947b0264ec1f43ce5deef563b72acf1284f:

  Merge branch 'for-2.6.39' of git://git.kernel.org/pub/scm/linux/kernel/git/lrg/asoc-2.6 into topic/asoc (2011-03-16 12:14:46 +0100)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound-2.6.git for-2.6.39

Marek Belisko (1):
      ASoC: mini2440: Fix uda134x codec problem.

Mark Brown (3):
      Merge branch 'topic/asoc' of git://git.kernel.org/.../tiwai/sound-2.6 into for-2.6.39
      ASoC: Remove bogus check for register validity in debugfs write
      ASoC: Support !REGULATOR build for sgtl5000

 arch/arm/mach-s3c2440/mach-mini2440.c |    7 +++++++
 sound/soc/codecs/sgtl5000.c           |   14 ++++++++++++++
 sound/soc/codecs/uda134x.c            |    3 ++-
 sound/soc/samsung/s3c24xx_uda134x.c   |    3 ++-
 sound/soc/soc-core.c                  |    2 --
 5 files changed, 25 insertions(+), 4 deletions(-)
