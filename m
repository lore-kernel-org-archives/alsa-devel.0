From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: ASoC updates for 2.6.36
Date: Tue, 3 Aug 2010 10:09:22 +0100
Message-ID: <20100803090922.GD25306@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id B680F2415D
	for <alsa-devel@alsa-project.org>;
	Tue,  3 Aug 2010 11:09:23 +0200 (CEST)
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

The following changes since commit 988b0dc1547f9f6a7c8cae472cad0a55df31818c:

  Merge branch 'for-2.6.36' of git://git.kernel.org/pub/scm/linux/kernel/git/lrg/asoc-2.6 into topic/asoc (2010-08-02 12:10:52 +0200)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound-2.6.git for-2.6.36

Axel Lin (12):
      ASoC: ad1836: fix a memory leak if another ad1836 is registered
      ASoC: ak4642: fix a memory leak if failed to initialise AK4642
      ASoC: da7210: fix a memory leak if failed to initialise da7210 audio codec
      ASoC: wm8523: fix resource reclaim in wm8523_register error path
      ASoC: wm8711: fix a memory leak if another WM8711 is registered
      ASoC: wm8904: fix resource reclaim in wm8904_register error path
      ASoC: wm8940: fix a memory leak if wm8940_register return error
      ASoC: wm8955: fix resource reclaim in wm8955_register error path
      ASoC: wm8961: fix resource reclaim in wm8961_register error path
      ASoC: wm8974: fix a memory leak if another WM8974 is registered
      ASoC: wm8978: fix a memory leak if a wm8978_register fail
      ASoC: wm9081: fix resource reclaim in wm9081_register error path

Ian Lartey (1):
      ASoC: Initial WM8741 CODEC driver

 sound/soc/codecs/Kconfig  |    4 +
 sound/soc/codecs/Makefile |    2 +
 sound/soc/codecs/ad1836.c |    1 +
 sound/soc/codecs/ak4642.c |    4 +-
 sound/soc/codecs/da7210.c |    8 +-
 sound/soc/codecs/wm8523.c |   10 +-
 sound/soc/codecs/wm8711.c |    3 +-
 sound/soc/codecs/wm8741.c |  579 +++++++++++++++++++++++++++++++++++++++++++++
 sound/soc/codecs/wm8741.h |  214 +++++++++++++++++
 sound/soc/codecs/wm8904.c |   13 +-
 sound/soc/codecs/wm8940.c |    7 +-
 sound/soc/codecs/wm8955.c |   10 +-
 sound/soc/codecs/wm8961.c |    9 +-
 sound/soc/codecs/wm8974.c |    3 +-
 sound/soc/codecs/wm8978.c |   10 +-
 sound/soc/codecs/wm9081.c |   11 +-
 16 files changed, 857 insertions(+), 31 deletions(-)
 create mode 100644 sound/soc/codecs/wm8741.c
 create mode 100644 sound/soc/codecs/wm8741.h
