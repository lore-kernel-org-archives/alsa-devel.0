From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: ASoC updates for 2.6.38
Date: Tue, 18 Jan 2011 13:03:27 +0000
Message-ID: <20110118130327.GH26498@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 1B487103831
	for <alsa-devel@alsa-project.org>; Tue, 18 Jan 2011 14:03:31 +0100 (CET)
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

The following changes since commit 18b022eb117e7f70c191267551ff865f278a9258:

  Merge branch 'for-2.6.38' of git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound-2.6 into topic/asoc (2011-01-12 12:26:24 +0100)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound-2.6.git for-2.6.38

A few small bug fixes, the biggest change is the cleanup after the
wl1273 merge.

Alexander Sverdlin (1):
      ASoC: EP93xx: fixed LRCLK rate and DMA oper. in I2S code

Dimitris Papastamos (1):
      ASoC: WM8990: msleep() takes milliseconds not jiffies

Matti J. Aaltonen (1):
      ASoC: WL1273 FM radio: Fix breakage with MFD API changes

 sound/soc/codecs/Kconfig      |    2 +-
 sound/soc/codecs/wl1273.c     |   29 +++++++----------
 sound/soc/codecs/wl1273.h     |   71 -----------------------------------------
 sound/soc/codecs/wm8990.c     |   10 +++---
 sound/soc/ep93xx/ep93xx-i2s.c |   18 +++++-----
 5 files changed, 27 insertions(+), 103 deletions(-)
