From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: ASoC updates for 2.6.35
Date: Fri, 30 Apr 2010 16:35:05 +0100
Message-ID: <20100430153504.GA7010@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 285A3244C3
	for <alsa-devel@alsa-project.org>;
	Fri, 30 Apr 2010 17:35:07 +0200 (CEST)
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

The following changes since commit cb7b76961f73e4ae934d44f7b2e7ba974442f2fe:
  Takashi Iwai (1):
        Merge branch 'for-2.6.35' of git://git.kernel.org/.../lrg/asoc-2.6 into topic/asoc

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound-2.6.git for-2.6.35

Mark Brown (2):
      ASoC: Remove redundant WM8960 SYSCLKSEL clkdiv option
      ASoC: Add WM9090 amplifier driver

 include/sound/wm9090.h    |   28 ++
 sound/soc/codecs/Kconfig  |    4 +
 sound/soc/codecs/Makefile |    2 +
 sound/soc/codecs/wm8960.c |    4 -
 sound/soc/codecs/wm8960.h |    1 -
 sound/soc/codecs/wm9090.c |  773 +++++++++++++++++++++++++++++++++++++++++++++
 sound/soc/codecs/wm9090.h |  715 +++++++++++++++++++++++++++++++++++++++++
 7 files changed, 1522 insertions(+), 5 deletions(-)
 create mode 100644 include/sound/wm9090.h
 create mode 100644 sound/soc/codecs/wm9090.c
 create mode 100644 sound/soc/codecs/wm9090.h
