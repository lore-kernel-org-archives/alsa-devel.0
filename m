From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: ASoC updaets for 2.6.38
Date: Wed, 8 Dec 2010 15:57:26 +0000
Message-ID: <20101208155725.GO16418@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 48AB8244F4
	for <alsa-devel@alsa-project.org>; Wed,  8 Dec 2010 16:57:27 +0100 (CET)
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

The following changes since commit 0afc8c733e95642ee9200966081da82564af8f8f:

  Merge branch 'for-2.6.37' into for-2.6.38 (2010-12-06 14:14:47 +0000)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound-2.6.git for-2.6.38

Axel Lin (2):
      ASoC: Fix resource leak if soc_register_ac97_dai_link failed
      ASoC: Fix snd_soc_instantiate_card error path

Dimitris Papastamos (3):
      ASoC: soc-core: Replace use of strncpy() with strlcpy()
      ASoC: soc-core: Remove useless inline function construct
      ASoC: soc-core: Fix null pointer dereference

Jarkko Nikula (1):
      ASoC: Merge common code in DAI link and auxiliary codec probing/removal

Jassi Brar (1):
      ASoC: WM8580: Debug BCLK and sample size

Mark Brown (3):
      ASoC: Correct WM8962 interrupt mask register read
      Merge branch 'for-2.6.37' into for-2.6.38
      ASoC: Support WM8994 mono AIF configurations

Uk Kim (1):
      ASoC: Add ADC high pass filter support to WM8994

 sound/soc/codecs/wm8580.c |    8 +-
 sound/soc/codecs/wm8962.c |    2 +-
 sound/soc/codecs/wm8994.c |   43 ++++++-
 sound/soc/soc-core.c      |  308 +++++++++++++++++++++------------------------
 4 files changed, 187 insertions(+), 174 deletions(-)
