From: Daniel Baluta <daniel.baluta@nxp.com>
Subject: [PATCH v4 0/2] Add support for AK5558 ADC
Date: Tue, 13 Feb 2018 16:29:32 +0200
Message-ID: <1518532174-11350-1-git-send-email-daniel.baluta@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from NAM03-BY2-obe.outbound.protection.outlook.com
 (mail-by2nam03on0056.outbound.protection.outlook.com [104.47.42.56])
 by alsa0.perex.cz (Postfix) with ESMTP id B2DE026790A
 for <alsa-devel@alsa-project.org>; Tue, 13 Feb 2018 15:55:46 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org, alsa-devel@alsa-project.org, devicetree@vger.kernel.org, andy.shevchenko@gmail.com, fabio.estevam@nxp.com, robh@kernel.org
Cc: daniel.baluta@gmail.com, shengjiu.wang@nxp.com, linux-kernel@vger.kernel.org, wakasugi.jb@om.asahi-kasei.co.jp, linux-imx@nxp.com, cosmin.samoila@nxp.com, daniel.baluta@nxp.com, mihai.serban@gmail.com
List-Id: alsa-devel@alsa-project.org

We support normal mode, TDM mode and pm.

Changes since v3: [addressed Mark's comments]
* use C++ comments for SPDX identifier
* removed some unused widgets and controls  (channel enable MUXes, TDM, DSD related stuff)
* removed set_dai_mute, set_bias_level, set_dai_sysclk as they are not used.
* refactored probe/remove to have symmetric operations
* use snd_soc_update_bits instead of hardcode read/write operation.

Changes since v2: [addressed comments from Andy, Fabio and Rob]
* sort include files
* use probe_new
* reword the binding document
* use adc@10 instead of ak5558@10
* remove file name at the beginning of codec source code.
* make i2c_probe and i2c_remove parameters naming consistent.

Changes since v1: [addressed comments from Andy and Fabio]
 * fix GPIO polarity from active high to active low for correct documentation
 * fix license header by using SPDX identifier
 * remove debug prints at the beginning of functions.
 * only support auto clock switching (manual switching was dead code anyway) (in the
   future we could add a DT property to choose between manual and auto)
 * Use gpiod API
 * use GENMASK
 * introduce power_off/power_on


Daniel Baluta (2):
  ASoC: codecs: Add support for AK5558 ADC driver
  ASoC: ak5558: Add bindings for AK5558 ADC

 Documentation/devicetree/bindings/sound/ak5558.txt |  22 ++
 sound/soc/codecs/Kconfig                           |   6 +
 sound/soc/codecs/Makefile                          |   2 +
 sound/soc/codecs/ak5558.c                          | 417 +++++++++++++++++++++
 sound/soc/codecs/ak5558.h                          |  52 +++
 5 files changed, 499 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/ak5558.txt
 create mode 100644 sound/soc/codecs/ak5558.c
 create mode 100644 sound/soc/codecs/ak5558.h

-- 
2.7.4
