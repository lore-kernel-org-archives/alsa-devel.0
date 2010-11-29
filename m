From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: ASoC updates for 2.6.37
Date: Mon, 29 Nov 2010 18:57:58 +0000
Message-ID: <20101129185758.GU30360@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 5E507245F0
	for <alsa-devel@alsa-project.org>; Mon, 29 Nov 2010 19:58:00 +0100 (CET)
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

The following changes since commit 25436180ee8bed6740f29d92c2030c759885c147:

  ASoC: Fix resource reclaim for osk5912 (2010-11-25 21:15:49 +0000)

are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound-2.6.git for-2.6.37

More small, targetted bugfixes from Axel.

Axel Lin (6):
      ASoC: Fix compile error for nuc900-ac97.c
      ASoC: Fix prototype for nuc900_ac97_probe and nuc900_ac97_remove
      ASoC: Fix compile error for nuc900-pcm.c
      ASoC: Remove unneeded !! operations while checking return value of nuc900_checkready
      ASoC: Add missing dev_set_drvdata in mpc8610_hpcd_probe
      ASoC: Add missing dev_set_drvdata in p1022_ds_probe

 sound/soc/fsl/mpc8610_hpcd.c    |    1 +
 sound/soc/fsl/p1022_ds.c        |    1 +
 sound/soc/nuc900/nuc900-ac97.c  |   15 +++++++--------
 sound/soc/nuc900/nuc900-audio.h |    2 ++
 sound/soc/nuc900/nuc900-pcm.c   |    2 +-
 5 files changed, 12 insertions(+), 9 deletions(-)
