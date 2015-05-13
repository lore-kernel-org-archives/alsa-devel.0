From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v1 00/13] ASoC: qcom: add support to apq8016 audio
Date: Wed, 13 May 2015 12:58:22 +0100
Message-ID: <1431518302-7139-1-git-send-email-srinivas.kandagatla@linaro.org>
References: <1430414148-10869-1-git-send-email-srinivas.kandagatla@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1430414148-10869-1-git-send-email-srinivas.kandagatla@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Patrick Lai <plai@codeaurora.org>, Mark Brown <broonie@kernel.org>
Cc: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Banajit Goswami <bgoswami@codeaurora.org>, Kenneth Westfield <kwestfie@codeaurora.org>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, linux-arm-msm@vger.kernel.org, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
List-Id: alsa-devel@alsa-project.org

Hi All,

Thankyou for reviewing the RFC patches, here is the v1 patchset after
incorporating review comments from RFC. This patchset adds apq8016 audio
support into lpass driver. Existing Lpass driver can not be used as-it-is for
apq8016 as it contains code specific to ipq806x. Also the driver only supports
single i2s port, single dma channel and single bitclk control.

APQ8016 has 4 MI2S( Primary, Secondary, Tertiary, Quaternary) which can be routed
to internal wcd codec or external codecs. This routing is controlled by 2 mux
registers.

This patch series firstly re-organizes the lpass driver such that the SOC
specific bits are moved away from the driver. And secondly the SOC specifics
are now passed as lpass variant data which would include various register
offsets, dma channel allocations and SOC specific clock handling.

Finally the patchset add apq8016 lpass and machine driver.

All these patches are tested for HDMI audio via adv7533 bridge and Analog audio
on APQ8016-SBC and msm8916-mtp boards. I dont have access to ipq806x boards to
test these patches.

Thanks Kenneth for testing the RFC patches on Storm board.

--srini

Changes since RFC(https://lwn.net/Articles/642661/)
 - droped cleanup patches, as they are already applied by Mark.
 - prefixed shared functions with asoc_qcom_* as suggested by Kenneth
 - made LPASS driver depended on OF.
 - removed ipq806x specific bits from ipaif_reg.h
 - removed no_osr clk flag as suggested by Mark and Kenneth
 - fixed irq return values spotted by Kenneth
 - renamed the machine file to apq8016-sbc.c as suggested by Kenneth.
 - use dai->driver->id instead of dai->id as it breaks on Storm board.

Srinivas Kandagatla (13):
  ASoC: qcom: make lpass driver depend on OF
  ASoC: qcom: move ipq806x specific bits out of lpass driver.
  ASoC: qcom: remove hardcoded i2s port number
  ASoC: qcom: remove hardcoded dma channel
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
 sound/soc/qcom/Kconfig                             |  28 ++-
 sound/soc/qcom/Makefile                            |   6 +
 sound/soc/qcom/apq8016_sbc.c                       | 215 ++++++++++++++++++
 sound/soc/qcom/lpass-apq8016.c                     | 242 +++++++++++++++++++++
 sound/soc/qcom/lpass-cpu.c                         | 228 ++++++++++---------
 sound/soc/qcom/lpass-ipq806x.c                     | 109 ++++++++++
 sound/soc/qcom/lpass-lpaif-ipq806x.h               | 172 ---------------
 sound/soc/qcom/lpass-lpaif-reg.h                   | 126 +++++++++++
 sound/soc/qcom/lpass-platform.c                    | 196 +++++++++++------
 sound/soc/qcom/lpass.h                             |  51 ++++-
 13 files changed, 1109 insertions(+), 347 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/qcom,apq8016-sbc.txt
 create mode 100644 include/dt-bindings/sound/apq8016-lpass.h
 create mode 100644 sound/soc/qcom/apq8016_sbc.c
 create mode 100644 sound/soc/qcom/lpass-apq8016.c
 create mode 100644 sound/soc/qcom/lpass-ipq806x.c
 delete mode 100644 sound/soc/qcom/lpass-lpaif-ipq806x.h
 create mode 100644 sound/soc/qcom/lpass-lpaif-reg.h

-- 
1.9.1
