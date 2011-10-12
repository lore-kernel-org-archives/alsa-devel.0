From: Ashish Chavan <ashish.chavan@kpitcummins.com>
Subject: [PATCH 00/09] ASoC: da7210: Add support for all IOs
 and other features
Date: Wed, 12 Oct 2011 20:24:06 +0530
Message-ID: <1318431246.12107.393.camel@matrix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from AM1EHSOBE001.bigfish.com (am1ehsobe001.messaging.microsoft.com
	[213.199.154.204])
	by alsa0.perex.cz (Postfix) with ESMTP id 00CA5245AD
	for <alsa-devel@alsa-project.org>;
	Wed, 12 Oct 2011 16:43:22 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, lrg@ti.com, alsa-devel <alsa-devel@alsa-project.org>
Cc: linux-kernel@vger.kernel.org, kuninori.morimoto.gx@renesas.com, David Dajun Chen <david.chen@diasemi.com>
List-Id: alsa-devel@alsa-project.org

Hi,
  Existing da7210 driver is very minimalistic in terms of functionality.
It supports only one output i.e. head phone. da7210 codec hardware
supports many more IOs and features.

Here is a patch series that is "feature update" in nature. This adds
support for all inputs(MIC L-R, AUX1 L-R, AUX2) and outputs (OUT1 L-R,
OUT2) as well as following features,

- ADC and DAC equalizers
- Mute
- Zero cross
- Other DAI word lengths, format and mode
- ALC
- Noise suppression
- High pass and voice filters
- DAPM

This series also contains a small bug fix for head phone volume control.

Thanks,

-- Ashish (GNU FAN)

---
Ashish Chavan (9):
      ASoC: da7210: Add support for line out and DAC
      ASoC: da7210: Add support for line input and mic
      ASoC: da7210: Add support for ADC & DAC equalizers
      ASoC: da7210: Add support for mute and zero cross controls
      ASoC: da7210: Add support for other DAI length, format and mode
      ASoC: da7210: bugfix for head phone volume control
      ASoC: da7210: Add support for ALC and Noise suppression
      ASoC: da7210: Add support for High pass and Voice filters
      ASoC: da7210: Add support for DAPM

 sound/soc/codecs/da7210.c |  642 +++++++++++++++++++++++++++++++++++---
 1 files changed, 586 insertions(+), 56 deletions(-)

-- 
1.7.1
