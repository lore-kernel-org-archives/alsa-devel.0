From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 0/3] Minor ASoC updates
Date: Mon, 8 Sep 2008 16:12:50 +0100
Message-ID: <20080908151250.GA14434@rakim.wolfsonmicro.main>
References: <48C41F45.1060008@embeddedalley.com> <s5hzlmipvi3.wl%tiwai@suse.de>
	<48C536A5.4080209@embeddedalley.com> <s5htzcqputz.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id DD65A1037EC
	for <alsa-devel@alsa-project.org>;
	Mon,  8 Sep 2008 17:12:51 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5htzcqputz.wl%tiwai@suse.de>
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

The following changes since commit 17c4badb6077b14d1cc67860511abd2001cefbf1:
  Cliff Cai (1):
        ASoC: Blackfin: Include Blackfin architecture support in build

are available in the git repository at:

  git://opensource.wolfsonmicro.com/linux-2.6-asoc for-tiwai

Mark Brown (3):
      ALSA: ASoC: Fix indentation in WM9713
      ALSA: ASoC: Sort Kconfig and Makefile entries for codecs
      ALSA: ASoC: Use codec digital mute when stopping playback

 sound/soc/codecs/Kconfig  |   64 ++++++++++++++++++++++----------------------
 sound/soc/codecs/Makefile |   16 +++++-----
 sound/soc/codecs/wm9713.c |   22 +++++++-------
 sound/soc/soc-core.c      |    6 ++++
 4 files changed, 57 insertions(+), 51 deletions(-)
