From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: ASoC update for 2.6.33
Date: Tue, 20 Oct 2009 13:02:57 +0100
Message-ID: <20091020120257.GB31441@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 24537246DB
	for <alsa-devel@alsa-project.org>;
	Tue, 20 Oct 2009 14:02:58 +0200 (CEST)
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

The following changes since commit 3da8e6885ec2dea67321c904d721be90e00cd748:
  Mark Brown (1):
        Merge branch 'for-2.6.32' into for-2.6.33

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound-2.6.git for-2.6.33

Barry Song (1):
      ASoC: Fix possible codec_dai->ops NULL pointer problems

Julia Lawall (1):
      ASoC: Move dereference after NULL test

Manuel Lauss (2):
      ASoC: au1x: psc-ac97: verify correct codec register was read
      ASoC: au1x: psc-ac97: reorganize timeouts

Mark Brown (1):
      Merge branch 'for-2.6.32' into for-2.6.33

Peter Ujfalusi (1):
      ASoC: TWL4030: Only update the needed bits in *set_dai_sysclk

 sound/soc/au1x/psc-ac97.c  |   49 +++++++++++++++++++++++++++++--------------
 sound/soc/codecs/twl4030.c |   22 ++++++++++---------
 sound/soc/soc-core.c       |   11 +++++++--
 sound/soc/soc-jack.c       |    3 +-
 4 files changed, 55 insertions(+), 30 deletions(-)
