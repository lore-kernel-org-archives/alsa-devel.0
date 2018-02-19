From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 0/2] ASoC: tlv320aic31xx: Optimize the master
	mode I2S clock handling
Date: Mon, 19 Feb 2018 11:45:06 +0200
Message-ID: <20180219094508.26662-1-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fllnx210.ext.ti.com (fllnx210.ext.ti.com [198.47.19.17])
 by alsa0.perex.cz (Postfix) with ESMTP id 30996266E7D
 for <alsa-devel@alsa-project.org>; Mon, 19 Feb 2018 10:44:34 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Jyri Sarha <jsarha@ti.com>
Cc: alsa-devel@alsa-project.org, s.mueller-klieser@phytec.de, afd@ti.com
List-Id: alsa-devel@alsa-project.org

Hi,

Instead of forcing DAC/ADC to be turned on, we can use P0 R29, Bit2 to let the
I2S clocks running, but we do not want it to run all the time and we do not want
I2S clocks when it is not needed (analog loopback mode).

Use DAPM_SUPPLY for the bit and connect it to the in/out AIF.

The DAPM routes can be modify to not include the DAC/ADC.

Regards,
Peter
---
Peter Ujfalusi (2):
  ASoC: tlv320aic31xx: Rename AIF_IN from 'DAC IN' to 'AIF IN'
  ASoC: tlv320aic31xx: Do not force power on the DAC/ADC in clock master
    mode

 sound/soc/codecs/tlv320aic31xx.c | 46 +++++++++++++++++++++++++---------------
 sound/soc/codecs/tlv320aic31xx.h |  1 +
 2 files changed, 30 insertions(+), 17 deletions(-)

-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
