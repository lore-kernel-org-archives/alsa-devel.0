From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v4 0/3] ASoC: qcom: add support to apq8016 audio
Date: Fri, 22 May 2015 16:52:36 +0100
Message-ID: <1432309956-5228-1-git-send-email-srinivas.kandagatla@linaro.org>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Patrick Lai <plai@codeaurora.org>, Mark Brown <broonie@kernel.org>
Cc: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Banajit Goswami <bgoswami@codeaurora.org>, Kenneth Westfield <kwestfie@codeaurora.org>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, linux-arm-msm@vger.kernel.org, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
List-Id: alsa-devel@alsa-project.org

Hi Mark, 

Thanks for applying the patches.

Am resending the leftover patches rebased on top of topic/qcom branch.
I have funtionally tested these patches on AP8016-SBC board and also
 compile tested them without CONFIG_OF on x86 to make sure nothing breaks.
All these patches are tested and Acked.

I Also included Arnd's Patch to fix Kconfig dependency on STORM board.

APQ8016 has 4 MI2S( Primary, Secondary, Tertiary, Quaternary) which can be routed
to internal wcd codec or external codecs. This routing is controlled by 2 mux
registers.

Changes since v3
 - dropped OF dependency patch
 - dropped 6 patches which are already applied by Mark.
 - fixed Kconfig as suggested by Arnd.

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
Arnd Bergmann (1):
  ASoC: qcom: fix STORM board Kconfig

Srinivas Kandagatla (2):
  ASoC: qcom: Add apq8016 lpass driver support
  ASoC: qcom: add apq8016 sound card support

 include/dt-bindings/sound/apq8016-lpass.h |   9 ++
 sound/soc/qcom/Kconfig                    |  17 ++-
 sound/soc/qcom/Makefile                   |   4 +
 sound/soc/qcom/apq8016_sbc.c              | 215 ++++++++++++++++++++++++++
 sound/soc/qcom/lpass-apq8016.c            | 242 ++++++++++++++++++++++++++++++
 sound/soc/qcom/lpass.h                    |   4 +
 6 files changed, 490 insertions(+), 1 deletion(-)
 create mode 100644 include/dt-bindings/sound/apq8016-lpass.h
 create mode 100644 sound/soc/qcom/apq8016_sbc.c
 create mode 100644 sound/soc/qcom/lpass-apq8016.c

-- 
1.9.1
