From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v6 0/8] ASoC: Add support to WCD9335 Audio Codec
Date: Mon, 28 Jan 2019 14:27:45 +0000
Message-ID: <20190128142753.22396-1-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com
 [209.85.221.68])
 by alsa0.perex.cz (Postfix) with ESMTP id 14D1C267456
 for <alsa-devel@alsa-project.org>; Mon, 28 Jan 2019 15:28:30 +0100 (CET)
Received: by mail-wr1-f68.google.com with SMTP id v13so18249537wrw.5
 for <alsa-devel@alsa-project.org>; Mon, 28 Jan 2019 06:28:30 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org
Cc: alsa-devel@alsa-project.org, bgoswami@codeaurora.org, lgirdwood@gmail.com, vkoul@kernel.org, robh+dt@kernel.org, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
List-Id: alsa-devel@alsa-project.org

Thankyou for reviewing v5 patchset, here is v6 addressing comments from v5.

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

This patchset adds very basic playback and capture support without much
fancy features. New features will be added once the basic support is in.
This patchset is tested on top of linux-next on DB820c for both playback
, capture paths and MBHC.

Some parts of the code has been inherited from Qualcomm andriod kernel,
so credits to various authors.

WCD9335 can be interfaced via I2S/I2C or SLIMbus. 

Here is our integration branch incase someone want to try this out:
https://git.linaro.org/landing-teams/working/qualcomm/kernel.git/log/?h=integration-linux-qcomlt

Thanks,
Srini

Changes since v5 (https://patchwork.kernel.org/cover/10756015/)
 - Added codec to SND_SOC_ALL_CODECS, also fixed irq return as suggested by Mark.
 - converted ear_pa gain to proper tlv as suggested by Mark.
 - converted rx_hph_mode_mux_text to more human readable strings as suggested by Mark.

Srinivas Kandagatla (8):
  ASoC: dt-bindings: update wcd9335 bindings.
  ASoC: wcd9335: add support to wcd9335 codec
  ASoC: wcd9335: add CLASS-H Controller support
  ASoC: wcd9335: add basic controls
  ASoC: wcd9335: add playback dapm widgets
  ASoC: wcd9335: add capture dapm widgets
  ASoC: wcd9335: add audio routings
  ASoC: apq8096: add slim support

 .../bindings/sound/qcom,wcd9335.txt           |   10 +-
 sound/soc/codecs/Kconfig                      |    9 +
 sound/soc/codecs/Makefile                     |    2 +
 sound/soc/codecs/wcd-clsh-v2.c                |  576 ++
 sound/soc/codecs/wcd-clsh-v2.h                |   49 +
 sound/soc/codecs/wcd9335.c                    | 5248 +++++++++++++++++
 sound/soc/codecs/wcd9335.h                    |  640 ++
 sound/soc/qcom/apq8096.c                      |   71 +-
 8 files changed, 6599 insertions(+), 6 deletions(-)
 create mode 100644 sound/soc/codecs/wcd-clsh-v2.c
 create mode 100644 sound/soc/codecs/wcd-clsh-v2.h
 create mode 100644 sound/soc/codecs/wcd9335.c
 create mode 100644 sound/soc/codecs/wcd9335.h

-- 
2.20.1
