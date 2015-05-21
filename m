From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v3 00/10] ASoC: qcom: add support to apq8016 audio
Date: Thu, 21 May 2015 22:52:05 +0100
Message-ID: <1432245125-8939-1-git-send-email-srinivas.kandagatla@linaro.org>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Patrick Lai <plai@codeaurora.org>, Mark Brown <broonie@kernel.org>
Cc: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Banajit Goswami <bgoswami@codeaurora.org>, Kenneth Westfield <kwestfie@codeaurora.org>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, linux-arm-msm@vger.kernel.org, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
List-Id: alsa-devel@alsa-project.org

Hi Mark, 

Am resending the the patches with rebased on top of topic/qcom branch.

All these patches are tested and Acked.

Thankyou for reviewing the v2 patches, here is the v3 patchset after
incorporating review comments and testing on Storm Board.
This patchset adds apq8016 audio support into lpass driver. Existing
Lpass driver can not be used as-it-is for apq8016 as it contains code
specific to ipq806x. Also the driver only supports single i2s port,
single dma channel and single bitclk control.

APQ8016 has 4 MI2S( Primary, Secondary, Tertiary, Quaternary) which can be routed
to internal wcd codec or external codecs. This routing is controlled by 2 mux
registers.

This patch series firstly re-organizes the lpass driver such that the SOC
specific bits are moved away from the driver. And secondly the SOC specifics
are now passed as lpass variant data which would include various register
offsets, dma channel allocations and SOC specific clock handling.

Finally the last few patchs add apq8016 lpass and machine driver.

All these patches are tested for HDMI audio via adv7533 bridge and Analog audio
on APQ8016-SBC, msm8916-mtp boards and Kenneth tested this patchset on
ipq806x Storm board too.

Changes since v2(https://lkml.org/lkml/2015/5/16/236)
 - dropped 3 patches which are already applied by Mark.
 - rebased on top of topic/qcom branch.
 - changed dev_err to dev_warn spotted by Kenneth.
 - fixed typo spotted by kenneth.

Changes since v1(https://lwn.net/Articles/644266/)
 - Fixed Kconfig dependencies spotted by Kenneth
 - Fixed compilation error on ipq806x spotted by Kenneth
 - Fixed clk error messages spotted by Kenneth

Changes since RFC(https://lwn.net/Articles/642661/)
 - droped cleanup patches, as they are already applied by Mark.
 - prefixed shared functions with asoc_qcom_* as suggested by Kenneth
 - made LPASS driver depended on OF.
 - removed ipq806x specific bits from ipaif_reg.h
 - removed no_osr clk flag as suggested by Mark and Kenneth
 - fixed irq return values spotted by Kenneth
 - renamed the machine file to apq8016-sbc.c as suggested by Kenneth.
 - use dai->driver->id instead of dai->id as it breaks on Storm board.


--srini

Srinivas Kandagatla (10):
  ASoC: qcom: make lpass driver depend on OF
  ASoC: qcom: support bitclk and osrclk per i2s port
  ASoC: qcom: make osr clock optional
  ASoC: qcom: add dma channel control offset to variant data
  ASoC: qcom: Add ability to handle interrupts per dma channel
  ASoC: qcom: add bit map to track static dma channel allocations
  ASoC: qcom: Add apq8016 lpass driver support
  ASoC: qcom: add apq8016 sound card support
  ASoC: qcom: Document apq8016 bindings.
  ASoC: qcom: document apq8016 sbc machine driver bindings

 .../devicetree/bindings/sound/qcom,apq8016-sbc.txt |  61 ++++++
 .../devicetree/bindings/sound/qcom,lpass-cpu.txt   |  13 +-
 include/dt-bindings/sound/apq8016-lpass.h          |   9 +
 sound/soc/qcom/Kconfig                             |  17 ++
 sound/soc/qcom/Makefile                            |   4 +
 sound/soc/qcom/apq8016_sbc.c                       | 215 ++++++++++++++++++
 sound/soc/qcom/lpass-apq8016.c                     | 242 +++++++++++++++++++++
 sound/soc/qcom/lpass-cpu.c                         |  77 +++++--
 sound/soc/qcom/lpass-platform.c                    |  96 +++++---
 sound/soc/qcom/lpass.h                             |  21 +-
 10 files changed, 692 insertions(+), 63 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/qcom,apq8016-sbc.txt
 create mode 100644 include/dt-bindings/sound/apq8016-lpass.h
 create mode 100644 sound/soc/qcom/apq8016_sbc.c
 create mode 100644 sound/soc/qcom/lpass-apq8016.c

-- 
1.9.1
