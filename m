From: Cosmin-Gabriel Samoila <cosmin.samoila@nxp.com>
Subject: [PATCH v2 0/2] Add support for AK4458 DAC
Date: Tue, 13 Feb 2018 16:14:46 +0200
Message-ID: <1518531288-2017-1-git-send-email-cosmin.samoila@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on0068.outbound.protection.outlook.com [104.47.36.68])
 by alsa0.perex.cz (Postfix) with ESMTP id 653F1267734
 for <alsa-devel@alsa-project.org>; Tue, 13 Feb 2018 15:55:45 +0100 (CET)
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
 sound/soc/codecs/ak4458.c                          | 684 +++++++++++++++++++++
 sound/soc/codecs/ak4458.h                          |  75 +++
 5 files changed, 790 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/ak4458.txt
 create mode 100644 sound/soc/codecs/ak4458.c
 create mode 100644 sound/soc/codecs/ak4458.h

-- 
2.7.4
