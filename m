From: Cosmin-Gabriel Samoila <cosmin.samoila@nxp.com>
Subject: [PATCH v3 0/2] Add support for AK4458 DAC
Date: Wed, 14 Feb 2018 15:21:05 +0200
Message-ID: <1518614467-20613-1-git-send-email-cosmin.samoila@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from NAM02-BL2-obe.outbound.protection.outlook.com
 (mail-bl2nam02on0075.outbound.protection.outlook.com [104.47.38.75])
 by alsa0.perex.cz (Postfix) with ESMTP id 49E332677F0
 for <alsa-devel@alsa-project.org>; Wed, 14 Feb 2018 14:56:00 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org, alsa-devel@alsa-project.org, devicetree@vger.kernel.org, robh@kernel.org
Cc: shegjiu.wang@nxp.com, linux-kernel@vger.kernel.org, linux-imx@nxp.com, Cosmin-Gabriel Samoila <cosmin.samoila@nxp.com>, daniel.baluta@nxp.com, mihai.serban@gmail.com
List-Id: alsa-devel@alsa-project.org

We support Normal Mode, TDM Mode and PM.

Changes since V2:
- remove unused code left from V1
- rewrite set_dai_fmt to only remember the format since
- the format is rewritten in hw_params
- use defined constants for mode in set_tdm_slot function
- use GENMASK
- add commit message for bindings patch
- modify bindings description text since we only support I2C for now
- rename ak4458_codec_probe to ak4458_probe
- write whole implementation of regmap init and gpiod get in i2c_probe
- added ak4458_remove where we power_off the chip

Changes since V1:
- support only i2c
- i2c probe / remove/suspend/ resume moved into shared code                                                         
- change enum array to separate variables
- aggregate Volume control for Left and Right Channel
- remove mux from DAPM
- remove unused functions
- remove unused controls
- remove unused macros
- use snd_soc_update_bits instead of soc_read + soc_write
- use GPIOD
- use SPDX identifier
- use dac@10 instgitead of ak4458@10
- use explicit power_on/off functions
- add __maybe_unused attribute
- use probe_new for i2c_probe

Cosmin-Gabriel Samoila (2):
  ASoC: codecs: Add support for AK4458 DAC driver
  ASoC: ak4458: Add bindings for AK4458 DAC

 Documentation/devicetree/bindings/sound/ak4458.txt |  23 +
 sound/soc/codecs/Kconfig                           |   6 +
 sound/soc/codecs/Makefile                          |   2 +
 sound/soc/codecs/ak4458.c                          | 659 +++++++++++++++++++++
 sound/soc/codecs/ak4458.h                          |  86 +++
 5 files changed, 776 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/ak4458.txt
 create mode 100644 sound/soc/codecs/ak4458.c
 create mode 100644 sound/soc/codecs/ak4458.h

-- 
2.7.4
