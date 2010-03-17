From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: ASoC updates for 2.6.35
Date: Wed, 17 Mar 2010 14:26:10 +0000
Message-ID: <20100317142609.GA12208@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 1BBCD10383E
	for <alsa-devel@alsa-project.org>; Wed, 17 Mar 2010 15:26:11 +0100 (CET)
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

The following changes since commit fbc2dae854da5fc44e2ce2f97446c8bd283c7e17:
  Mark Brown (1):
        ASoC: Support GPIO based microphone detection for WM8904

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound-2.6.git for-2.6.35

Mark Brown (3):
      ASoC: Implement WM835x microphone jack detection support
      ASoC: Remove current PGA control handling
      ASoC: Refresh WM8750 bias management

The PGA control handling is the build issue fix.

 include/linux/mfd/wm8350/audio.h |    2 +
 sound/soc/codecs/wm8350.c        |   58 +++++++++++++++++++++++
 sound/soc/codecs/wm8350.h        |    3 +
 sound/soc/codecs/wm8750.c        |   50 ++++-----------------
 sound/soc/soc-dapm.c             |   93 +------------------------------------
 5 files changed, 75 insertions(+), 131 deletions(-)
