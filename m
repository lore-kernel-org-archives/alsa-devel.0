From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 0/6] ASoC: Add support to WCD9340/WCD9341 codec
Date: Tue,  2 Jul 2019 09:09:14 +0100
Message-ID: <20190702080920.22623-1-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com
 [IPv6:2a00:1450:4864:20::441])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 046A4F800C5
 for <alsa-devel@alsa-project.org>; Tue,  2 Jul 2019 10:10:31 +0200 (CEST)
Received: by mail-wr1-x441.google.com with SMTP id c27so8946417wrb.2
 for <alsa-devel@alsa-project.org>; Tue, 02 Jul 2019 01:10:31 -0700 (PDT)
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: robh+dt@kernel.org, broonie@kernel.org
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, bgoswami@codeaurora.org, lgirdwood@gmail.com, vkoul@kernel.org, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, srini@kernel.org
List-Id: alsa-devel@alsa-project.org

This patchset adds support to Qualcomm WCD9340/WCD9341 Codec which
is a standalone Hi-Fi audio codec IC.
This codec supports both I2S/I2C and SLIMbus audio interfaces.
On slimbus interface it supports two data lanes; 16 Tx ports
and 8 Rx ports. It has Five DACs and seven dedicated interpolators,
Multibutton headset control (MBHC), Active noise cancellation,
Sidetone paths, MAD (mic activity detection) and codec processing engine.
It supports Class-H differential earpiece out and stereo single
ended headphones out.
This codec also has integrated SoundWire controller.
Patchset for this is already sent for review at
https://lwn.net/Articles/790651/
    
This patchset has been tested on SDM845 based DragonBoard DB845c with WSA881x
smart speaker amplifiers via soundwire and 4 DMICs.

Thanks,
srini

Srinivas Kandagatla (6):
  ASoC: dt-bindings: add dt bindings for WCD9340/WCD9341 audio codec
  ASoC: wcd934x: add support to wcd9340/wcd9341 codec
  ASoC: wcd934x: add basic controls
  ASoC: wcd934x: add playback dapm widgets
  ASoC: wcd934x: add capture dapm widgets
  ASoC: wcd934x: add audio routings

 .../bindings/sound/qcom,wcd934x.txt           |  188 +
 sound/soc/codecs/Kconfig                      |   10 +
 sound/soc/codecs/Makefile                     |    2 +
 sound/soc/codecs/wcd934x.c                    | 5979 +++++++++++++++++
 sound/soc/codecs/wcd934x.h                    |  426 ++
 5 files changed, 6605 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/qcom,wcd934x.txt
 create mode 100644 sound/soc/codecs/wcd934x.c
 create mode 100644 sound/soc/codecs/wcd934x.h

-- 
2.21.0
