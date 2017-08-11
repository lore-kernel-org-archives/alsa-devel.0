From: srinivas.kandagatla@linaro.org
Subject: [RFC PATCH 0/9] ASoC: qcom: Add support to QDSP based
	HDMI audio
Date: Fri, 11 Aug 2017 15:29:43 +0200
Message-ID: <20170811132952.32572-1-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-io0-f176.google.com (mail-io0-f176.google.com
 [209.85.223.176])
 by alsa0.perex.cz (Postfix) with ESMTP id 4828926762D
 for <alsa-devel@alsa-project.org>; Fri, 11 Aug 2017 15:30:02 +0200 (CEST)
Received: by mail-io0-f176.google.com with SMTP id j32so20182866iod.0
 for <alsa-devel@alsa-project.org>; Fri, 11 Aug 2017 06:30:02 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Banajit Goswami <bgoswami@codeaurora.org>, alsa-devel@alsa-project.org
Cc: kwestfie@codeaurora.org, linux-arm-msm@vger.kernel.org, Patrick Lai <plai@codeaurora.org>, sboyd@codeaurora.org, Takashi Iwai <tiwai@suse.com>, linux-kernel@vger.kernel.org, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, lkasam@qti.qualcomm.com
List-Id: alsa-devel@alsa-project.org

From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

This patchset aims to provide a very basic version of QCOM DSP based
audio support which is available in downstream andriod kernels.
This patchset only support Digital audio based for HDMI-TX and will
add support to other features as we move on.

Why do we need this now:
On All Qualcomm SOCs the audio services are usually provided by
an on chip DSP using LPASS, however LPASS is mostly tied with
a Q6DSP on most of the SOCs. So Bypassing the DSP is becoming almost
impossible with new generation of QCOM SOCs.

QDSP has 3 modules AFE (Audio FrontEnd), ADM (Audio Device Manager),
and ASM(Audio Stream Manager) to provide this audio services.
All these services use APR (Asynchronous Packet Router) protocol
via smd/glink transport to communicate with Application processor.
More details on each module is availble in there respective patch.

This patchset is tested on DB820c, with HDMI audio playback
on top of mainline with few additional patches.

Here is block diagram to give a quick overview of the components

  +---------+          +---------+         +---------+
  |  q6pcm  |          |q6routing|         | q6hdmi  |
  | ASoC(FE | <------> | ASoC(BE | <-----> | ASoC(BE |
  | cpu dai)|          |Platform)|         | cpu dai)| 
  |         |          |         |         |         |
  +---------+          +---------+         +---------+
      ^                     ^                   ^
      |                     |                   |  
      |  +------------------+----------------+  |       
      |  |                  |                |  |       
      v  v                  v                v  v       
  +---------+          +---------+         +---------+
  |         |          |         |         |         |
  |   q6ASM |          |  q6ADM  |         |   q6AFE |
  |         |          |         |         |         |
  |         |          |         |         |         |
  +---------+          +---------+         +---------+
      ^                     ^                   ^          ^
      |                     |                   | CPU Side |
------+---------------------+-------------------+--------
      |                     |                   |
      |                     |APR(smd/glink)     | 
      |                     |                   |
      |                     |                   |  
      |  +------------------+----------------+  |       
      |  |                                   |  |       
+-----+--+-----------------------------------+--+-------
      |  |                                   |  | QDSP Side |     
      v  v                                   v  v           v
 +---------+          +---------+         +---------+  
 |         |          |         |         |         |  
 |   ASM   | <------> |   ADM   | <-----> |   AFE   |  
 |         |          |         |         |         |  
 |         |          |         |         |         |  
 +---------+          +---------+         +---------+  
                                               ^       
                                               |       
                           +-------------------+
                           |
---------------------------+--------------------------
                           |            Audio I/O |
                           v                      v
    +--------------------------------------------------+
    |                Audio devices                     |
    | CODEC | HDMI-TX | PCM  | SLIMBUS | I2S |MI2S |...|
    |                                                  | 
    +--------------------------------------------------+


Srinivas Kandagatla (9):
  soc: qcom: add support APR driver
  ASoC: qcom: qdsp6v2: Add support to Q6AFE
  ASoC: qcom: qdsp6v2: Add support to Q6ADM
  ASoC: qcom: qdsp6v2: Add support to Q6ASM
  ASoC: qcom: qdsp6v2: Add support to q6 routing driver
  ASoC: qcom: qdsp6v2: Add support to q6 HDMI dai driver
  ASoC: qcom: qdsp6v2: Add support to q6 pcm driver
  ASoC: qcom: apq8096: Add db820c machine driver
  arm64: dts: msm8996: db820c: Add sound card support

 .../devicetree/bindings/soc/qcom/qcom,apr.txt      |   66 ++
 .../devicetree/bindings/sound/qcom,apq8096.txt     |   85 ++
 .../devicetree/bindings/sound/qcom,q6adm.txt       |   15 +
 .../devicetree/bindings/sound/qcom,q6afe.txt       |   15 +
 .../devicetree/bindings/sound/qcom,q6asm.txt       |   15 +
 .../devicetree/bindings/sound/qcom,q6hdmi.txt      |   27 +
 .../bindings/sound/qcom,q6pcm-routing.txt          |   21 +
 .../devicetree/bindings/sound/qcom,q6pcm.txt       |   21 +
 arch/arm64/boot/dts/qcom/apq8096-db820c.dtsi       |   37 +
 arch/arm64/boot/dts/qcom/msm8996.dtsi              |   67 ++
 drivers/soc/qcom/Kconfig                           |    8 +
 drivers/soc/qcom/Makefile                          |    1 +
 drivers/soc/qcom/apr.c                             |  406 ++++++++
 include/dt-bindings/sound/qcom,afe.h               |    8 +
 include/dt-bindings/sound/qcom,asm.h               |   13 +
 include/linux/soc/qcom/apr.h                       |  163 ++++
 sound/soc/qcom/Kconfig                             |   46 +
 sound/soc/qcom/Makefile                            |    5 +
 sound/soc/qcom/apq8096.c                           |  174 ++++
 sound/soc/qcom/qdsp6v2/Makefile                    |    6 +
 sound/soc/qcom/qdsp6v2/common.h                    |  225 +++++
 sound/soc/qcom/qdsp6v2/q6adm-v2.h                  |   76 ++
 sound/soc/qcom/qdsp6v2/q6adm.c                     |  603 ++++++++++++
 sound/soc/qcom/qdsp6v2/q6afe-v2.h                  |   62 ++
 sound/soc/qcom/qdsp6v2/q6afe.c                     |  499 ++++++++++
 sound/soc/qcom/qdsp6v2/q6asm-v2.h                  |  176 ++++
 sound/soc/qcom/qdsp6v2/q6asm.c                     | 1008 ++++++++++++++++++++
 sound/soc/qcom/qdsp6v2/q6hdmi.c                    |  258 +++++
 sound/soc/qcom/qdsp6v2/q6pcm.c                     |  558 +++++++++++
 sound/soc/qcom/qdsp6v2/q6routing-v2.h              |    8 +
 sound/soc/qcom/qdsp6v2/q6routing.c                 |  403 ++++++++
 31 files changed, 5075 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/qcom/qcom,apr.txt
 create mode 100644 Documentation/devicetree/bindings/sound/qcom,apq8096.txt
 create mode 100644 Documentation/devicetree/bindings/sound/qcom,q6adm.txt
 create mode 100644 Documentation/devicetree/bindings/sound/qcom,q6afe.txt
 create mode 100644 Documentation/devicetree/bindings/sound/qcom,q6asm.txt
 create mode 100644 Documentation/devicetree/bindings/sound/qcom,q6hdmi.txt
 create mode 100644 Documentation/devicetree/bindings/sound/qcom,q6pcm-routing.txt
 create mode 100644 Documentation/devicetree/bindings/sound/qcom,q6pcm.txt
 create mode 100644 drivers/soc/qcom/apr.c
 create mode 100644 include/dt-bindings/sound/qcom,afe.h
 create mode 100644 include/dt-bindings/sound/qcom,asm.h
 create mode 100644 include/linux/soc/qcom/apr.h
 create mode 100644 sound/soc/qcom/apq8096.c
 create mode 100644 sound/soc/qcom/qdsp6v2/Makefile
 create mode 100644 sound/soc/qcom/qdsp6v2/common.h
 create mode 100644 sound/soc/qcom/qdsp6v2/q6adm-v2.h
 create mode 100644 sound/soc/qcom/qdsp6v2/q6adm.c
 create mode 100644 sound/soc/qcom/qdsp6v2/q6afe-v2.h
 create mode 100644 sound/soc/qcom/qdsp6v2/q6afe.c
 create mode 100644 sound/soc/qcom/qdsp6v2/q6asm-v2.h
 create mode 100644 sound/soc/qcom/qdsp6v2/q6asm.c
 create mode 100644 sound/soc/qcom/qdsp6v2/q6hdmi.c
 create mode 100644 sound/soc/qcom/qdsp6v2/q6pcm.c
 create mode 100644 sound/soc/qcom/qdsp6v2/q6routing-v2.h
 create mode 100644 sound/soc/qcom/qdsp6v2/q6routing.c

-- 
2.9.3
