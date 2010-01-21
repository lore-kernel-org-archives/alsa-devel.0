From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: ASoC updates for 2.6.34
Date: Thu, 21 Jan 2010 12:42:55 +0000
Message-ID: <20100121124255.GA28630@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 85868243C6
	for <alsa-devel@alsa-project.org>; Thu, 21 Jan 2010 13:42:56 +0100 (CET)
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

The following changes since commit 9135f6db09aa9d186f05d41e9c516ec8e3550d78:
  Mark Brown (1):
        Merge branch 'mxc-audio' into for-2.6.34

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound-2.6.git for-2.6.34

Guennadi Liakhovetski (1):
      ASoC: fix compile breakage - add a missing header include

Mark Brown (3):
      ASoC: Remove console DAPM debug code
      ASoC: Support turning off bias when the CODEC is idle
      ASoC: Use BIAS_OFF when idle for wm_hubs devices

Peter Ujfalusi (3):
      ASoC: tlv320dac33: Correct the prefill number of samples
      ASoC: tlv320dac33: BCLK divider fix
      ASoC: tlv320dac33: Burst mode BCLK divider configuration

 include/sound/soc-dai.h          |    2 +
 include/sound/soc.h              |    2 +
 include/sound/tlv320dac33-plat.h |    1 +
 sound/soc/codecs/tlv320dac33.c   |   24 +++++++--
 sound/soc/codecs/wm_hubs.c       |    6 ++
 sound/soc/soc-dapm.c             |  105 ++++++++++----------------------------
 6 files changed, 56 insertions(+), 84 deletions(-)
