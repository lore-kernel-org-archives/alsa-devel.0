From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: ASoC updates for 2.6.37
Date: Wed, 8 Dec 2010 15:08:34 +0000
Message-ID: <20101208150833.GN16418@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 1A349244D2
	for <alsa-devel@alsa-project.org>; Wed,  8 Dec 2010 16:08:35 +0100 (CET)
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

The following changes since commit 1dcb4f38e5bc28dfce0f8c7eef184a090b03bfc7:

  ASoC: Hold client_mutex while calling snd_soc_instantiate_cards() (2010-12-06 12:53:43 +0000)

are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound-2.6.git for-2.6.37

Axel Lin (1):
      ASoC: Fix resource leak if soc_register_ac97_dai_link failed

Jassi Brar (1):
      ASoC: WM8580: Debug BCLK and sample size

Mark Brown (1):
      ASoC: Correct WM8962 interrupt mask register read

More of the same small bug fixes.  There's a conflict with 2.6.38 which
I've already resolved - I'll send a pull request for that later.

 sound/soc/codecs/wm8580.c |    8 ++++----
 sound/soc/codecs/wm8962.c |    2 +-
 sound/soc/soc-core.c      |   12 +++++++-----
 3 files changed, 12 insertions(+), 10 deletions(-)
