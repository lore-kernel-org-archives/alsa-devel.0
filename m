From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: ASoC updates for-2.6.36
Date: Tue, 13 Jul 2010 12:51:14 +0100
Message-ID: <20100713115113.GK12686@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 709CC24449
	for <alsa-devel@alsa-project.org>;
	Tue, 13 Jul 2010 13:51:15 +0200 (CEST)
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

The following changes since commit 66b47fdb851924956b6e4696fb43a3496ae2c462:

  ASoC: Implement WM8994 OPCLK support (2010-07-09 08:50:12 +0900)

are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound-2.6.git for-2.6.36

Arnaud Patard (2):
      ASoC: Fix kirkwood i2s mono playback
      ASoC: kirkwood-i2s: Handle mute/unmute playback/record

Joe Perches (2):
      ASoC: Remove unnecessary casts of private_data
      ASoC: Remove unnecessary casts of private_data

Kuninori Morimoto (8):
      ASoC: fsi: fixup clock inversion operation
      ASoC: fsi: fixup wrong value setting order of TDM
      ASoC: fsi: modify format area definition on flags
      ASoC: fsi: remove un-used variable on fsi_dai_startup
      ASoC: fsi: remove noisy CR_FMT macro
      ASoC: fsi: Change struct fsi_regs to fsi_core
      ASoC: fsi: Add pr_err for noticing unsupported access
      ASoC: fsi: Fixup for master mode

Manuel Lauss (1):
      ASoC: au1x: fix section mismatch in psc-i2s.c

Mark Brown (1):
      Merge branch 'for-2.6.35' into for-2.6.36

 include/sound/sh_fsi.h            |   44 +++++++-
 sound/soc/au1x/psc-i2s.c          |    2 +-
 sound/soc/blackfin/bf5xx-ac97.c   |    6 +-
 sound/soc/blackfin/bf5xx-tdm.c    |    6 +-
 sound/soc/davinci/davinci-pcm.c   |    2 +-
 sound/soc/kirkwood/kirkwood-i2s.c |   27 ++++--
 sound/soc/kirkwood/kirkwood.h     |    3 +
 sound/soc/sh/fsi.c                |  213 ++++++++++++++++++++++++++-----------
 8 files changed, 219 insertions(+), 84 deletions(-)
