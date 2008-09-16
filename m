From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 0/3] ASoC updates
Date: Tue, 16 Sep 2008 13:48:51 +0100
Message-ID: <20080916124851.GA15445@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id B81982440F
	for <alsa-devel@alsa-project.org>;
	Tue, 16 Sep 2008 14:48:52 +0200 (CEST)
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

The following changes since commit 78bd2cd2124d3a77f7f78af47849ea571a73f2a1:
  Dmitry Baryshkov (1):
        ALSA: Separate common pxa2xx-pcm code

are available in the git repository at:

  git://opensource.wolfsonmicro.com/linux-2.6-asoc for-tiwai

Mark Brown (3):
      ASoC: Fix dependency on AC97_BUS
      ASoC: DAPM support for ADC on WM9713 PCM interface
      ASoC: Add WM8750 SPI support

 sound/soc/Kconfig         |    1 +
 sound/soc/codecs/wm8750.c |   70 ++++++++++++++++++++++++++++++++++++++++++++-
 sound/soc/codecs/wm8750.h |    1 +
 sound/soc/codecs/wm9713.c |   12 ++++++-
 4 files changed, 81 insertions(+), 3 deletions(-)
