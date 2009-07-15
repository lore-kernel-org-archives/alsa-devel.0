From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: ASoC updates for 2.6.32
Date: Wed, 15 Jul 2009 11:25:41 +0100
Message-ID: <20090715102538.GA27594@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id D91B81037F3
	for <alsa-devel@alsa-project.org>;
	Wed, 15 Jul 2009 12:25:43 +0200 (CEST)
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The following changes since commit ba3b64b976f91067710ef1a87b9b445406910e8f:
  Mark Brown (1):
        Merge branch 'for-2.6.31' into for-2.6.32

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound-2.6.git for-2.6.32

Cliff Cai (2):
      ASoC: Blackfin AC97: fix resume handling
      ASoC: Blackfin I2S: fix resume handling

Mark Brown (2):
      ASoC: Fix sample rate lookup in WM8993
      ASoC: Error out if we can't determine a suitable WM9081 sysclk

 sound/soc/blackfin/bf5xx-ac97.c |   10 +++-------
 sound/soc/blackfin/bf5xx-i2s.c  |    8 ++------
 sound/soc/codecs/wm8993.c       |    3 ++-
 sound/soc/codecs/wm9081.c       |    8 ++++++++
 4 files changed, 15 insertions(+), 14 deletions(-)
