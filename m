From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [RFC v1 0/9] ASoC: Add support to Qualcomm msm8x16-wcd
	codec
Date: Tue, 16 Feb 2016 17:31:20 +0000
Message-ID: <1455643880-1611-1-git-send-email-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f43.google.com (mail-wm0-f43.google.com [74.125.82.43])
 by alsa0.perex.cz (Postfix) with ESMTP id 43B4B26057F
 for <alsa-devel@alsa-project.org>; Tue, 16 Feb 2016 18:32:12 +0100 (CET)
Received: by mail-wm0-f43.google.com with SMTP id a4so111072504wme.1
 for <alsa-devel@alsa-project.org>; Tue, 16 Feb 2016 09:32:12 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>, kwestfie@codeaurora.org, Pawel Moll <pawel.moll@arm.com>, linux-kernel@vger.kernel.org, Patrick Lai <plai@codeaurora.org>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, linux-arm-msm@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

This patchset aims at adding msm8x16-wcd codec support.
msm8x16-wcd codec is found in Qualcomm msm8916 and apq8016 processors.
This codec IP is split in to two parts(Digital & Analog), Analog part
is integrated in to PMIC PM8916 and the digital part is integrated into
Application processor. Register access to the analog part is done via
SPMI interface to PMIC, and registers on the Application processor are
memory mapped. Data transfer between Analog and Digital Die is done via
a internal bus called PDM.

I did split the driver into sensible patches to easy the review process.
Most of this driver is ported from downstream Andriod v3.10 kernel.
Jack support and Headset button detection code is not added in to this series.

This codec support:
 -  3 Microphones: Primary Mic(Handset mic), Headset Mic and Secondary Mic.
 - 2 Digital Microphones.
 - 2 Mic Bias Circuits.
 - Earpiece
 - Headset
 - Loud Speaker.
 - Jack Detect.
 - Headset Button detection circuit.

Tested this code on v4.5-rc4 with lpass driver capture support patches for
Headset (Mic and speakers), Secondary Mic and Loudspeaker on DB410C.
DMIC should work too.

Thanks,
srini


Srinivas Kandagatla (9):
  ASoC: msm8x176: Add Device Tree bindings.
  ASoC: msm8x16: add driver structure
  ASoC: msm8x16: add codec registers definitions
  ASoC: msm8x16: add ranges for default, readonly
  ASoC: msm8x16: add codec intialization setup
  ASoC: msm8x16: add codec dais
  ASoC: msm8x16: Add sound mixer controls.
  ASoC: msm8x16: add dapm widgets
  ASoC: msm8x16: add dapm routes

 .../devicetree/bindings/sound/qcom,msm8x16-wcd.txt |   91 +
 include/dt-bindings/sound/msm8x16-wcd.h            |    7 +
 sound/soc/codecs/Kconfig                           |    4 +
 sound/soc/codecs/Makefile                          |    3 +-
 sound/soc/codecs/msm8x16-wcd-registers.h           |  518 +++++
 sound/soc/codecs/msm8x16-wcd.c                     | 2132 ++++++++++++++++++++
 sound/soc/codecs/msm8x16-wcd.h                     |  764 +++++++
 7 files changed, 3518 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/sound/qcom,msm8x16-wcd.txt
 create mode 100644 include/dt-bindings/sound/msm8x16-wcd.h
 create mode 100644 sound/soc/codecs/msm8x16-wcd-registers.h
 create mode 100644 sound/soc/codecs/msm8x16-wcd.c
 create mode 100644 sound/soc/codecs/msm8x16-wcd.h

-- 
1.9.1
