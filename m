From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: ASoC updates for 2.6.38
Date: Thu, 9 Dec 2010 16:17:02 +0000
Message-ID: <20101209161702.GF4469@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id D890E103809
	for <alsa-devel@alsa-project.org>; Thu,  9 Dec 2010 17:17:03 +0100 (CET)
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

The following changes since commit 146fd574ec06b1c593805738b1c2c8c5a4128681:

  ASoC: Add ADC high pass filter support to WM8994 (2010-12-08 15:46:49 +0000)

are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound-2.6.git for-2.6.38

Alexander Sverdlin (1):
      ASoC: EP93xx: sampling rate range extended

Dmitry Artamonow (1):
      ASoC: fix deemphasis control in wm8904/55/60 codecs

Mark Brown (1):
      Merge branch 'for-2.6.37' into for-2.6.38

Seungwhan Youn (2):
      ASoC: WM8580: Fix R8 initial value
      ASoC: Remove unnecessary structure definitions

 include/sound/soc.h           |    3 ---
 sound/soc/codecs/wm8580.c     |    2 +-
 sound/soc/codecs/wm8904.c     |    3 ++-
 sound/soc/codecs/wm8955.c     |    3 ++-
 sound/soc/codecs/wm8960.c     |    3 ++-
 sound/soc/ep93xx/ep93xx-i2s.c |    4 ++--
 sound/soc/ep93xx/ep93xx-pcm.c |    4 ++--
 7 files changed, 11 insertions(+), 11 deletions(-)
