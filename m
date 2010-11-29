From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH 0/5] Fix compile error and missing spin_unlock_irqrestore
	for NUC900 SoC audio
Date: Mon, 29 Nov 2010 17:38:11 +0800
Message-ID: <1291023491.22911.1.camel@mola>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Liam Girdwood <lrg@slimlogic.co.uk>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Wan ZongShun <mcuos.com@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

This serial fixes compile error and missing spin_unlock_irqrestore for NUC900 SoC audio.

Regards,
Axel

Axel Lin (5):
  ASoC: Fix compile error for nuc900-ac97.c
  ASoC: Fix prototype for nuc900_ac97_probe and nuc900_ac97_remove
  ASoC: Fix compile error for nuc900-pcm.c
  ASoC: Fix missing spin_unlock_irqrestore
  ASoC: Remove unneeded !! operations while checking return value of
    nuc900_checkready

 sound/soc/nuc900/nuc900-ac97.c  |   15 +++++++--------
 sound/soc/nuc900/nuc900-audio.h |    2 ++
 sound/soc/nuc900/nuc900-pcm.c   |   11 ++++++-----
 3 files changed, 15 insertions(+), 13 deletions(-)

-- 
1.7.2
