From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: ASoC updates for 2.6.37
Date: Thu, 9 Dec 2010 16:16:06 +0000
Message-ID: <20101209161606.GE4469@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 4D26E103809
	for <alsa-devel@alsa-project.org>; Thu,  9 Dec 2010 17:16:09 +0100 (CET)
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

The following changes since commit 2a7b1a00206895cfa444fd83477dca67a88a9d25:

  ASoC: Correct WM8962 interrupt mask register read (2010-12-07 15:49:42 +0000)

are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound-2.6.git for-2.6.37

The usual small, focused bug fixes.

Dmitry Artamonow (1):
      ASoC: fix deemphasis control in wm8904/55/60 codecs

Seungwhan Youn (1):
      ASoC: WM8580: Fix R8 initial value

 sound/soc/codecs/wm8580.c |    2 +-
 sound/soc/codecs/wm8904.c |    3 ++-
 sound/soc/codecs/wm8955.c |    3 ++-
 sound/soc/codecs/wm8960.c |    3 ++-
 4 files changed, 7 insertions(+), 4 deletions(-)
