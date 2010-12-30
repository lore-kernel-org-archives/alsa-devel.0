From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: ASoC updates for 2.6.37
Date: Thu, 30 Dec 2010 12:54:24 +0000
Message-ID: <20101230125421.GB2667@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 2025E1038BF
	for <alsa-devel@alsa-project.org>; Thu, 30 Dec 2010 13:55:21 +0100 (CET)
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
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

The following changes since commit 862af8adbe6b9ccb7c00c13717b1f92465f79aa2:

  ASoC: Fix bias power down of non-DAPM codec (2010-12-13 16:47:48 +0000)

are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound-2.6.git for-2.6.37

This is very late for such a big set of changes, but unfortunately
Lars-Peter only reported them just before Christmas.  Most of the
changes are small and easy to verify by hand, the big one is the WM8753
which has had the benefit of testing from Lars-Peter and which consists
mostly of replacing the custom wm8753 write function with the generic
snd_soc_write() and so can be relatively easily verified by eye.

In case you don't want to send these on to Linus I've also marked them
as CC to stable so they'll go into the stable release when that goes
out.

Lars-Peter Clausen (9):
      ASoC: codecs: Add missing control_type initialization
      ASoC: codecs: max98088: Fix register cache incoherency
      ASoC: codecs: wm8523: Fix register cache incoherency
      ASoC: codecs: wm8741: Fix register cache incoherency
      ASoC: codecs: wm8904: Fix register cache incoherency
      ASoC: codecs: wm8955: Fix register cache incoherency
      ASoC: codecs: wm8962: Fix register cache incoherency
      ASoC: codecs: wm9090: Fix register cache incoherency
      ASoC: codecs: wm8753: Fix register cache incoherency

 sound/soc/codecs/max98088.c |   10 +-
 sound/soc/codecs/wm8523.c   |    9 +-
 sound/soc/codecs/wm8741.c   |   10 +-
 sound/soc/codecs/wm8753.c   |  226 ++++++++++++++++---------------------------
 sound/soc/codecs/wm8904.c   |   37 ++++----
 sound/soc/codecs/wm8940.c   |    1 +
 sound/soc/codecs/wm8955.c   |   31 +++---
 sound/soc/codecs/wm8960.c   |    1 +
 sound/soc/codecs/wm8962.c   |   45 ++++-----
 sound/soc/codecs/wm8971.c   |    1 +
 sound/soc/codecs/wm9081.c   |    1 +
 sound/soc/codecs/wm9090.c   |   18 ++--
 12 files changed, 164 insertions(+), 226 deletions(-)
