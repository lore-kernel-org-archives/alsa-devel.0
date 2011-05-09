From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: ASoC updates for 2.6.39
Date: Mon, 9 May 2011 22:17:09 +0200
Message-ID: <20110509201708.GA21323@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id D8F0C1037EA
	for <alsa-devel@alsa-project.org>;
	Mon,  9 May 2011 22:17:04 +0200 (CEST)
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
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

The following changes since commit 69b91bc1551a2fc746a01fea9d3291e60be3780d:

  ASoC: Fix CODEC DAI names for Goni (2011-04-28 12:09:53 +0100)

are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound-2.6.git for-2.6.39

Lars-Peter Clausen (4):
      ASoC: JZ4740: Fix i2s shutdown
      ASoC: SSM2602: Properly annotate i2c probe and remove functions
      ASoC: SSM2602: Fix 'Mic Boost2' control
      ASoC: SSM2602: Fix reg_cache_size

Marek Belisko (1):
      ASoC: UDA134x: Remove POWER_OFF_ON_STANDBY define.

Mark Brown (1):
      ASoC: Don't crash on PM operations

xingchao (1):
      ASoC: sst_platform: add hw_free callback to fix resource leak

 sound/soc/codecs/ssm2602.c       |   10 +++++-----
 sound/soc/codecs/uda134x.c       |    2 --
 sound/soc/jz4740/jz4740-i2s.c    |    2 +-
 sound/soc/mid-x86/sst_platform.c |    6 ++++++
 sound/soc/soc-core.c             |    2 ++
 5 files changed, 14 insertions(+), 8 deletions(-)
