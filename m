From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: ASoC updates for 2.6.33
Date: Thu, 26 Nov 2009 16:04:34 +0000
Message-ID: <20091126160434.GC10674@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 6E185103886
	for <alsa-devel@alsa-project.org>; Thu, 26 Nov 2009 17:04:35 +0100 (CET)
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
Cc: alsa-devel@alsa-project.org, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

The following changes since commit 97cef58521288ade8d957e4d568a3d409dea7d64:
  Mark Brown (1):
        Merge branch 'for-2.6.32' into for-2.6.33

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound-2.6.git for-2.6.33

Daniel J Blueman (1):
      mfd: twl4030: fix ELF section mismatch...

Mark Brown (2):
      Merge branch 'twl4030-mfd' into for-2.6.33
      ASoC: Add BCLK calculation utility for TDM mode too

Peter Ujfalusi (1):
      ASoC: tlv320dac33: Change RT wq to singlethread wq

 drivers/mfd/twl4030-core.c     |    2 +-
 include/sound/soc.h            |    1 +
 sound/soc/codecs/tlv320dac33.c |    3 ++-
 sound/soc/soc-utils.c          |    6 ++++++
 4 files changed, 10 insertions(+), 2 deletions(-)
