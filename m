From: srinivas.kandagatla@linaro.org
Subject: [PATCH v4 00/14] ASoC: Add support to WCD9335 Audio
	Codec
Date: Sun, 16 Sep 2018 17:57:13 -0700
Message-ID: <20180917005727.32728-1-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-it0-f65.google.com (mail-it0-f65.google.com
 [209.85.214.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 7BEBA2676AA
 for <alsa-devel@alsa-project.org>; Mon, 17 Sep 2018 02:57:58 +0200 (CEST)
Received: by mail-it0-f65.google.com with SMTP id h23-v6so8894195ita.5
 for <alsa-devel@alsa-project.org>; Sun, 16 Sep 2018 17:57:58 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: lee.jones@linaro.org, robh+dt@kernel.org, broonie@kernel.org
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, bgoswami@codeaurora.org, lgirdwood@gmail.com, linux-kernel@vger.kernel.org, vkoul@kernel.org, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
List-Id: alsa-devel@alsa-project.org

From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

Thankyou for reviewing v3 patchset, here is v4 addressing comments from v3.

Qualcomm WCD9335 Codec is a standalone Hi-Fi audio codec IC.
It is integrated in multiple Qualcomm SoCs like: MSM8996, MSM8976,
and MSM8956 chipsets.

WCD9335 had multiple functional blocks, like: Soundwire controller,
interrupt mux, pin controller, Audio codec, MBHC, MAD(Mic activity Detection),
Ultrasonic proximity and pen detection, Battery-voltage monitoring and
Codec processing engine.

Currently this patchset has been only tested with SLIMbus interface due
to hardware avaiablity, but it can be easily made to work with both SLIMbus
and I2C/I2S.    

This patchset adds very basic playback and capture support witout much
fancy features. New features will be added once the basic support is in.
This patchset is tested on top of linux-next on DB820c for both playback
, capture paths and MBHC.

Some parts of the code has been inherited from Qualcomm andriod kernel,
so credits to various authors.

WCD9335 can be interfaced via I2S/I2C or SLIMbus. 

Here is my test branch incase someone want to try this out:
https://git.linaro.org/people/srinivas.kandagatla/linux.git/log/?h=wcd9335

Thanks,
Srini

Changes since v3 (https://lkml.org/lkml/2018/9/4/318/)
 - Updated mbhc dt bindings according to Robs Comments.
 - Added a cleanup patch to common up fixups.
 - Addressed various comments on mfd driver by Lee Jones.
 - Added acks on bindings and irq support.
 - fixed module loading

Srinivas Kandagatla (14):
  ASoC: dt-bindings: update wcd9335 bindings.
  mfd: wcd9335: add support to wcd9335 core
  mfd: wcd9335: add wcd irq support
  ASoC: wcd9335: add support to wcd9335 codec
  ASoC: wcd9335: add CLASS-H Controller support
  ASoC: wcd9335: add basic controls
  ASoC: wcd9335: add playback dapm widgets
  ASoC: wcd9335: add capture dapm widgets
  ASoC: wcd9335: add audio routings
  ASoC: dt-bindings: Add WCD9335 MBHC specific properties
  ASoC: wcd9335: add mbhc support
  ASoC: apq8096: add slim support
  ASoC: apq8096: add headset JACK support
  ASoC: qcom: common: move be_hw_fixup to common

 .../devicetree/bindings/sound/qcom,wcd9335.txt     |   30 +-
 drivers/mfd/Kconfig                                |   13 +
 drivers/mfd/Makefile                               |    4 +
 drivers/mfd/wcd9335-core.c                         |  394 ++
 include/linux/mfd/wcd9335/registers.h              |  640 +++
 include/linux/mfd/wcd9335/wcd9335.h                |   81 +
 sound/soc/codecs/Kconfig                           |    5 +
 sound/soc/codecs/Makefile                          |    2 +
 sound/soc/codecs/wcd-clsh-v2.c                     |  577 +++
 sound/soc/codecs/wcd-clsh-v2.h                     |   49 +
 sound/soc/codecs/wcd9335.c                         | 5241 ++++++++++++++++++++
 sound/soc/qcom/apq8096.c                           |  128 +-
 sound/soc/qcom/common.c                            |   17 +
 sound/soc/qcom/sdm845.c                            |   22 +-
 14 files changed, 7168 insertions(+), 35 deletions(-)
 create mode 100644 drivers/mfd/wcd9335-core.c
 create mode 100644 include/linux/mfd/wcd9335/registers.h
 create mode 100644 include/linux/mfd/wcd9335/wcd9335.h
 create mode 100644 sound/soc/codecs/wcd-clsh-v2.c
 create mode 100644 sound/soc/codecs/wcd-clsh-v2.h
 create mode 100644 sound/soc/codecs/wcd9335.c

-- 
2.9.3
