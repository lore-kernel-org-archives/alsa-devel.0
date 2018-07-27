From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v2 00/10] ASoC: Add support to WCD9335 Audio
	Codec
Date: Fri, 27 Jul 2018 13:17:56 +0100
Message-ID: <20180727121806.18209-1-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com
 [209.85.221.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 02C772677B0
 for <alsa-devel@alsa-project.org>; Fri, 27 Jul 2018 14:20:23 +0200 (CEST)
Received: by mail-wr1-f65.google.com with SMTP id h10-v6so4854580wre.6
 for <alsa-devel@alsa-project.org>; Fri, 27 Jul 2018 05:20:23 -0700 (PDT)
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
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, bgoswami@codeaurora.org, tiwai@suse.com, lgirdwood@gmail.com, linux-kernel@vger.kernel.org, vkoul@kernel.org, srinivas.kandagatla@linaro.org
List-Id: alsa-devel@alsa-project.org

Thankyou for reviewing v1 patchset, here is v2 addressing comments from v1.

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
and capture paths.

This patchset also depends on the SLIMbus Stream apis which is already merged
via char-misc tree for 4.19.

Some parts of the code has been inherited from Qualcomm andriod kernel,
so credits to various authors.

WCD9335 can be interfaced via I2S/I2C or SLIMbus. 

Here is my test branch incase someone want to try this out:
https://git.linaro.org/people/srinivas.kandagatla/linux.git/log/?h=wcd9335

Thanks,
Srini

Changes since v1 (https://lkml.org/lkml/2018/7/23/889)
	- Fixed dt bindings as suggested by Mark B.
	- cleanup CLASS-H code, remove un-used states.
	- Various cleanup suggested by Vinod.

Srinivas Kandagatla (10):
  ASoC: dt-bindings: add dt bindings for wcd9335 audio codec
  mfd: wcd9335: add support to wcd9335 core
  mfd: wcd9335: add wcd irq support
  ASoC: wcd9335: add support to wcd9335 codec
  ASoC: wcd9335: add CLASS-H Controller support
  ASoC: wcd9335: add basic controls
  ASoC: wcd9335: add playback dapm widgets
  ASoC: wcd9335: add capture dapm widgets
  ASoC: wcd9335: add audio routings
  ASoC: apq8096: add support to Analog audio via WCD9335 slim

 .../devicetree/bindings/sound/qcom,wcd9335.txt     |  123 +
 drivers/mfd/Kconfig                                |   18 +
 drivers/mfd/Makefile                               |    4 +
 drivers/mfd/wcd9335-core.c                         |  277 ++
 drivers/mfd/wcd9335-irq.c                          |  172 +
 include/dt-bindings/mfd/wcd9335.h                  |   43 +
 include/linux/mfd/wcd9335/registers.h              |  580 +++
 include/linux/mfd/wcd9335/wcd9335.h                |   45 +
 sound/soc/codecs/Kconfig                           |    5 +
 sound/soc/codecs/Makefile                          |    2 +
 sound/soc/codecs/wcd-clsh.c                        |  605 +++
 sound/soc/codecs/wcd-clsh.h                        |   49 +
 sound/soc/codecs/wcd9335.c                         | 4963 ++++++++++++++++++++
 sound/soc/qcom/apq8096.c                           |   68 +
 14 files changed, 6954 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/qcom,wcd9335.txt
 create mode 100644 drivers/mfd/wcd9335-core.c
 create mode 100644 drivers/mfd/wcd9335-irq.c
 create mode 100644 include/dt-bindings/mfd/wcd9335.h
 create mode 100644 include/linux/mfd/wcd9335/registers.h
 create mode 100644 include/linux/mfd/wcd9335/wcd9335.h
 create mode 100644 sound/soc/codecs/wcd-clsh.c
 create mode 100644 sound/soc/codecs/wcd-clsh.h
 create mode 100644 sound/soc/codecs/wcd9335.c

-- 
2.16.2
