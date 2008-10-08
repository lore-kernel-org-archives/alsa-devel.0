From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 0/8] ASoC updates
Date: Wed, 8 Oct 2008 10:36:11 +0100
Message-ID: <20081008093611.GA9425@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 41B09244C1
	for <alsa-devel@alsa-project.org>;
	Wed,  8 Oct 2008 11:36:25 +0200 (CEST)
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

The following changes since commit 691ac84a77b1aebb7e09b4924b4b9c07a0f4f66a:
  Takashi Iwai (1):
        Merge branch 'asoc-fixes' into topic/asoc

are available in the git repository at:

  git://opensource.wolfsonmicro.com/linux-2.6-asoc for-tiwai

This is all 2.6.28ish material.

Arun KS (1):
      ASoC: Add custom SOC_SINGLE_TLV for tlv320aic23 codec

Jarkko Nikula (2):
      ASoC: tlv320aic3x: Use uniform tlv320aic naming
      ASoC: Remove unused AUDIO_NAME define from codec drivers

Mark Brown (4):
      ASoC: Add WM8753 SPI support
      ASoC: Add WM8510 SPI support
      ASoC: Implement WM8510 bias level control
      ASoC: Make WM8510 microphone input a DAPM mixer

Richard Zhao (1):
      ALSA: ASoC: add new param mux to dapm_mux_update_power

 sound/soc/codecs/ak4535.c      |    1 -
 sound/soc/codecs/ssm2602.c     |    1 -
 sound/soc/codecs/tlv320aic23.c |   54 ++++++++++++++++++--
 sound/soc/codecs/tlv320aic3x.c |    5 +-
 sound/soc/codecs/uda1380.c     |    1 -
 sound/soc/codecs/wm8510.c      |  109 ++++++++++++++++++++++++++++++++++-----
 sound/soc/codecs/wm8510.h      |    1 +
 sound/soc/codecs/wm8580.c      |    1 -
 sound/soc/codecs/wm8731.c      |    1 -
 sound/soc/codecs/wm8750.c      |    1 -
 sound/soc/codecs/wm8753.c      |   72 +++++++++++++++++++++++++-
 sound/soc/codecs/wm8753.h      |    1 +
 sound/soc/codecs/wm8971.c      |    1 -
 sound/soc/codecs/wm8990.c      |    1 -
 sound/soc/soc-dapm.c           |    8 ++--
 15 files changed, 221 insertions(+), 37 deletions(-)
