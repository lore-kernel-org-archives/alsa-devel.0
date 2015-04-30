From: Srinivas Kandagatla <srinivas.kandagatla-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: [RFC PATCH 00/14] ASoC: qcom: add support to apq8016 audio
Date: Thu, 30 Apr 2015 18:15:48 +0100
Message-ID: <1430414148-10869-1-git-send-email-srinivas.kandagatla@linaro.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Patrick Lai <plai-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Banajit Goswami <bgoswami-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Kenneth Westfield <kwestfie-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, Takashi Iwai <tiwai-l3A5Bk7waGM@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Srinivas Kandagatla <srinivas.kandagatla-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

Hi All,

This patchset adds apq8016 audio support into lpass driver. Existing Lpass
driver can not be used as-it-is for apq8016 as it contains code specific to
ipq806x. Also the driver only supports single i2s port, single dma channel and
single bitclk control.

APQ8016 has 4 MI2S( Primary, Secondary, Tertiary, Quaternary) which can be routed
to internal wcd codec or external codecs. This routing is controlled by 2 mux
registers.

This patch series firstly re-organizes the lpass driver such that the SOC
specific bits are moved away from the driver. And secondly the SOC specifics
are now passed as lpass variant data which would include various register
offsets, dma channel allocations and SOC specific clock handling.

Finally the patchset add apq8016 lpass and machine driver.

This patchset also has two trivial cleanup patches which are to do with
redundant checks and removing unnecessary header files.

All these patches are tested for HDMI audio via adv7533 bridge and Analog audio
on APQ8016-SBC and msm8916-mtp boards. I dont have access to ipq806x boards to
test these patches.

This is very first version of the patches which was developed with very
mimimal/no access to IP documentation. I would like to get your opinon on the
over all approch.


Kenneth/Patrick,
	Could you please try these patches on storm board?

Thanks,
srini


Srinivas Kandagatla (14):
  ASoC: qcom: Remove redundant error check.
  ASoC: qcom: remove unnecessary header files
  ASoC: qcom: move ipq806x specific bits out of lpass driver.
  ASoC: qcom: remove hardcoded i2s port number
  ASoC: qcom: remove hardcoded dma channel
  ASoC: qcom: support bitclk and osrclk per i2s port
  ASoC: qcom: add no osr clk flag to lpass variant
  ASoC: qcom: add dma channel control offset to variant data
  ASoC: qcom: Add ability to handle interrupts per dma channel
  ASoC: qcom: add bit map to track static dma channel allocations
  ASoC: qcom: Add apq8016 lpass driver support
  ASoC: qcom: add apq8016 sound card support
  ASoC: qcom: Document apq8016 bindings.
  ASoC: qcom: document apq8016 machine driver bindings

 .../bindings/sound/qcom,apq8016-machine.txt        |  61 ++++++
 .../devicetree/bindings/sound/qcom,lpass-cpu.txt   |  13 +-
 sound/soc/qcom/Kconfig                             |  25 ++-
 sound/soc/qcom/Makefile                            |   5 +
 sound/soc/qcom/apq8016.c                           | 214 ++++++++++++++++++
 sound/soc/qcom/lpass-apq8016.c                     | 243 +++++++++++++++++++++
 sound/soc/qcom/lpass-cpu.c                         | 234 ++++++++++----------
 sound/soc/qcom/lpass-ipq806x.c                     |  95 ++++++++
 sound/soc/qcom/lpass-lpaif-ipq806x.h               | 172 ---------------
 sound/soc/qcom/lpass-lpaif-reg.h                   | 167 ++++++++++++++
 sound/soc/qcom/lpass-platform.c                    | 197 +++++++++++------
 sound/soc/qcom/lpass.h                             |  54 ++++-
 12 files changed, 1121 insertions(+), 359 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/qcom,apq8016-machine.txt
 create mode 100644 sound/soc/qcom/apq8016.c
 create mode 100644 sound/soc/qcom/lpass-apq8016.c
 create mode 100644 sound/soc/qcom/lpass-ipq806x.c
 delete mode 100644 sound/soc/qcom/lpass-lpaif-ipq806x.h
 create mode 100644 sound/soc/qcom/lpass-lpaif-reg.h

-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
