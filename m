From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: ASoC updates for 2.6.38
Date: Fri, 25 Feb 2011 11:51:48 +0000
Message-ID: <20110225115148.GA28980@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 9CC58244AA
	for <alsa-devel@alsa-project.org>; Fri, 25 Feb 2011 12:51:28 +0100 (CET)
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

The following changes since commit 3017358a75917b5ed5ad361c02ba2a7e257d3b2a:

  ASoC: Ensure supplies are maintained for force enabled widgets (2011-02-13 19:49:47 +0000)

are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound-2.6.git for-2.6.38

More of the usual small fixes.

Dmitry Eremin-Solenikov (1):
      ASoC: correct pxa AC97 DAI names

Mark Brown (3):
      ASoC: Fix WM8958 default microphone detection argument ordering
      ASoC: Correct definition of WM8903_VMID_RES_5K
      ASoC: Hook wm_hubs micbiases up to CLK_SYS

 sound/soc/codecs/wm8903.h      |    2 +-
 sound/soc/codecs/wm8994.c      |    5 ++---
 sound/soc/codecs/wm_hubs.c     |    3 +++
 sound/soc/pxa/e740_wm9705.c    |    4 ++--
 sound/soc/pxa/e750_wm9705.c    |    4 ++--
 sound/soc/pxa/e800_wm9712.c    |    4 ++--
 sound/soc/pxa/em-x270.c        |    4 ++--
 sound/soc/pxa/mioa701_wm9713.c |    4 ++--
 sound/soc/pxa/palm27x.c        |    4 ++--
 sound/soc/pxa/tosa.c           |    4 ++--
 sound/soc/pxa/zylonite.c       |    4 ++--
 11 files changed, 22 insertions(+), 20 deletions(-)
