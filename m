From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: ASoC update for 3.3
Date: Tue, 24 Jan 2012 19:50:10 +0000
Message-ID: <20120124195009.GA30474@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id BF10E24600
	for <alsa-devel@alsa-project.org>; Tue, 24 Jan 2012 20:50:13 +0100 (CET)
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

The following changes since commit dcd6c92267155e70a94b3927bce681ce74b80d1f:

  Linux 3.3-rc1 (2012-01-19 15:04:48 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git asoc-3.3-20120124

for you to fetch changes up to c83f1d7e71625801c72f4013291194e09b6f0a6e:

  ASoC: wm2000: Fix use-after-free - don't release_firmware() twice on error (2012-01-24 11:34:19 +0000)

----------------------------------------------------------------
ASoC: Updates for 3.3

A bunch of small updates for drivers that accumilated during the merge
window.

----------------------------------------------------------------
Fabio Estevam (1):
      ASoC: mxs: Fix mxs-saif timeout

Jesper Juhl (2):
      ASoC: wm8958: Use correct format string in dev_err() call
      ASoC: wm2000: Fix use-after-free - don't release_firmware() twice on error

Mark Brown (4):
      ASoC: Mark WM5100 register map cache only when going into BIAS_OFF
      ASoC: Don't go through cache when applying WM5100 rev A updates
      ASoC: Disable register synchronisation for low frequency WM8996 SYSCLK
      ASoC: wm8996: Call _POST_PMU callback for CPVDD

Wolfram Sang (2):
      ASoC: tlv320aic32x4: always enable dividers
      ASoC: tlv320aic32x4: always enable analouge block

Zeng Zhaoming (1):
      ASoC: sgtl5000: Fix wrong register name in restore

 sound/soc/codecs/sgtl5000.c      |   17 +++++--
 sound/soc/codecs/tlv320aic32x4.c |  110 +++++++++++++++++--------------------
 sound/soc/codecs/wm2000.c        |   31 +++++------
 sound/soc/codecs/wm5100.c        |    3 +
 sound/soc/codecs/wm8958-dsp2.c   |    2 +-
 sound/soc/codecs/wm8996.c        |    7 ++-
 sound/soc/codecs/wm8996.h        |    4 ++
 sound/soc/mxs/mxs-saif.c         |    5 ++
 8 files changed, 96 insertions(+), 83 deletions(-)
