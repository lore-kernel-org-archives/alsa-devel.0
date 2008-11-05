From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 0/4] ASoC updates
Date: Wed, 5 Nov 2008 18:52:20 +0000
Message-ID: <20081105185220.GA10816@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 7733F2414F
	for <alsa-devel@alsa-project.org>; Wed,  5 Nov 2008 19:52:21 +0100 (CET)
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

The following changes since commit 0ee4663617fb0f78cec4cc6558a096ccbd8c3ffc:
  Takashi Iwai (1):
        ALSA: ASoC - Remove unnecessary inclusion of linux/version.h

are available in the git repository at:

  git://opensource.wolfsonmicro.com/linux-2.6-asoc for-tiwai

David Anders (1):
      ASoC: Add new parameter to s3c24xx_pcm_enqueue

Marek Vasut (1):
      ASoC: Add Palm/PXA27x unified ASoC audio driver

Mark Brown (1):
      ASoC: Remove core version number

Troy Kisky (1):
      ASoC: TLV320AIC23B Support more sample rates

 arch/arm/mach-pxa/include/mach/palmasoc.h |   13 ++
 include/sound/soc.h                       |    2 -
 sound/soc/codecs/tlv320aic23.c            |  227 +++++++++++++++++++-----
 sound/soc/pxa/Kconfig                     |    9 +
 sound/soc/pxa/Makefile                    |    2 +
 sound/soc/pxa/palm27x.c                   |  269 +++++++++++++++++++++++++++++
 sound/soc/s3c24xx/s3c24xx-pcm.c           |   12 +-
 sound/soc/soc-core.c                      |    1 -
 8 files changed, 483 insertions(+), 52 deletions(-)
 create mode 100644 arch/arm/mach-pxa/include/mach/palmasoc.h
 create mode 100644 sound/soc/pxa/palm27x.c
