From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 0/3] ASoC updates
Date: Thu, 27 Nov 2008 15:15:53 +0000
Message-ID: <20081127151553.GA15999@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 2808024349
	for <alsa-devel@alsa-project.org>; Thu, 27 Nov 2008 16:15:55 +0100 (CET)
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

The following changes since commit 5c0d7bb797a975691ca8bbc38e53da03c6e151bb:
  Dmitry Baryshkov (1):
        ASoC: tosa: move gpio probing to machine callbacks

are available in the git repository at:

  git://opensource.wolfsonmicro.com/linux-2.6-asoc for-tiwai

Daniel Mack (1):
      ASoC: Allow more routing features for tlv320aic3x

Mark Brown (1):
      ASoC: Fix word wrapping in OMAP Kconfig

Qinghuang Feng (1):
      ASoC: Clean up kernel-doc for snd_soc_dai_set_fmt

 sound/soc/codecs/tlv320aic3x.c |   96 +++++++++++++++++++++++++++------------
 sound/soc/codecs/tlv320aic3x.h |   12 +++++
 sound/soc/omap/Kconfig         |    5 +-
 sound/soc/soc-core.c           |    1 -
 4 files changed, 80 insertions(+), 34 deletions(-)
