From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v7 00/24] ASoC: qcom: Add support to QDSP based
	Audio
Date: Tue,  1 May 2018 13:07:56 +0100
Message-ID: <20180501120820.11016-1-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f68.google.com (mail-wm0-f68.google.com [74.125.82.68])
 by alsa0.perex.cz (Postfix) with ESMTP id 8F87F26735E
 for <alsa-devel@alsa-project.org>; Tue,  1 May 2018 14:10:25 +0200 (CEST)
Received: by mail-wm0-f68.google.com with SMTP id t11so17521260wmt.0
 for <alsa-devel@alsa-project.org>; Tue, 01 May 2018 05:10:25 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: andy.gross@linaro.org, broonie@kernel.org, linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org, robh+dt@kernel.org, bgoswami@codeaurora.org
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, rohkumar@qti.qualcomm.com, gregkh@linuxfoundation.org, plai@codeaurora.org, tiwai@suse.com, lgirdwood@gmail.com, david.brown@linaro.org, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, linux-arm-kernel@lists.infradead.org, spatakok@qti.qualcomm.com, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Thankyou everyone for providing feedback and testing v6 patchset.
This patchset aims to provide a basic version of QCOM DSP based
audio support which is available in downstream andriod kernels.
This patchset support audio playback on HDMI-RX, MI2S, SLIMBus and
will add support to other features as we move on.

QDSP has both static and dynamic modules. static modules like AFE
(Audio FrontEnd), ADM (Audio Device Manager), ASM(Audio Stream Manager)
and CORE to provide this audio services.
All these services use APR (Asynchronous Packet Router) protocol
via smd/glink transport to communicate with Application processor.
More details on each module is availble in there respective patch.

This patchset is tested on DB820c, with HDMI audio playback, MI2S on
DB410c on top of mainline, Also tested SLIMBus analog audio using
wcd9355 with an additional patches. Patches are also tested on
SDM845 by Rohit.

Here is my test branch incase someone want to try these patches
https://git.linaro.org/people/srinivas.kandagatla/linux.git/log/?h=v4.17-qdsp6

Here is block diagram to give a quick overview of the components


  +---------+          +---------+         +---------+   
  |  q6asm  |          |q6routing|         | q6afe   | 
  |   dais  | <------> |  mixers | <-----> |  dais   |  
  +---------+          +---------+         +---------+   
      ^                     ^                   ^
      |                     |                   |
      |  +------------------+----------------+  |       
      |  |                  |                |  |       
      v  v                  v                v  v       
  +---------+          +---------+         +---------+ 
  |   q6ASM |          |  q6ADM  |         |   q6AFE |  
  +---------+          +---------+         +---------+  
      ^                     ^                   ^          ^
      |                     |                   | CPU Side |
------+---------------------+-------------------+--------
      |                     |                   |
      |                     |APR(smd/glink)     | 
      |                     |                   |
      |  +------------------+----------------+  |
      |  |                  |                |  |
+-----+--+-----------------------------------+--+-------
      |  |                  |                |  | QDSP Side |
      v  v                  v                v  v           v
 +---------+          +---------+         +---------+
 |   ASM   | <------> |   ADM   | <-----> |   AFE   |
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


Changes since v6 (https://lkml.org/lkml/2018/4/26/264)
- Added relevant acks and reviewed-by tags.
- Update apr_pkt_send and callbacks to take structures
 instead of void * suggested by Bjorn
- Updated q6afe bindings to explain clearly on grandchild
 dai node bindings, suggested by Rob H.
- Fixed few typos in APR commit msg spotted by Mark B.
- rebased patchset on top of
https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git/?h=for-next

Srinivas Kandagatla (24):
  soc: qcom dt-bindings: Add APR bus bindings
  soc: qcom: Add APR bus driver
  ASoC: qdsp6: dt-bindings: Add q6core dt bindings
  ASoC: qdsp6: dt-bindings: Add q6afe dt bindings
  ASoC: qdsp6: dt-bindings: Add q6adm dt bindings
  ASoC: qdsp6: dt-bindings: Add q6asm dt bindings
  ASoC: qdsp6: q6common: Add qdsp6 helper functions
  ASoC: qdsp6: q6core: Add q6core driver
  ASoC: qdsp6: q6afe: Add q6afe driver
  ASoC: qdsp6: qdafe: Add SLIMBus port Support
  ASoC: qdsp6: q6afe: Add support to MI2S ports
  ASoC: qdsp6: q6afe: Add support to MI2S sysclks
  ASoC: qdsp6: q6adm: Add q6adm driver
  ASoC: qdsp6: q6asm: Add q6asm driver
  ASoC: qdsp6: q6asm: Add support to memory map and unmap
  ASoC: qdsp6: q6asm: Add support to audio stream apis
  ASoC: qdsp6: q6routing: Add q6routing driver
  ASoC: qdsp6: q6routing: Add support to all SLIMBus Mixers
  ASoC: qdsp6: q6routing: Add support to MI2S Mixers
  ASoC: qdsp6: q6afe: Add q6afe dai driver
  ASoC: qdsp6: q6asm: Add q6asm dai driver
  ASoC: qdsp6: dt-bindings: Add apq8096 machine bindings
  ASoC: qcom: apq8096: Add db820c machine driver
  MAINTAINERS: Add myself as co-maintainer of qcom audio

 .../devicetree/bindings/soc/qcom/qcom,apr.txt      |   84 ++
 .../devicetree/bindings/sound/qcom,apq8096.txt     |  109 ++
 .../devicetree/bindings/sound/qcom,q6adm.txt       |   33 +
 .../devicetree/bindings/sound/qcom,q6afe.txt       |  104 ++
 .../devicetree/bindings/sound/qcom,q6asm.txt       |   33 +
 .../devicetree/bindings/sound/qcom,q6core.txt      |   21 +
 MAINTAINERS                                        |    1 +
 drivers/soc/qcom/Kconfig                           |    9 +
 drivers/soc/qcom/Makefile                          |    1 +
 drivers/soc/qcom/apr.c                             |  378 ++++++
 include/dt-bindings/soc/qcom,apr.h                 |   28 +
 include/dt-bindings/sound/qcom,q6afe.h             |   31 +
 include/dt-bindings/sound/qcom,q6asm.h             |   22 +
 include/linux/mod_devicetable.h                    |   11 +
 include/linux/soc/qcom/apr.h                       |  128 ++
 sound/soc/qcom/Kconfig                             |   50 +
 sound/soc/qcom/Makefile                            |    5 +
 sound/soc/qcom/apq8096.c                           |  238 ++++
 sound/soc/qcom/qdsp6/Makefile                      |    8 +
 sound/soc/qcom/qdsp6/q6adm.c                       |  636 +++++++++
 sound/soc/qcom/qdsp6/q6adm.h                       |   25 +
 sound/soc/qcom/qdsp6/q6afe-dai.c                   |  752 +++++++++++
 sound/soc/qcom/qdsp6/q6afe.c                       | 1046 +++++++++++++++
 sound/soc/qcom/qdsp6/q6afe.h                       |  193 +++
 sound/soc/qcom/qdsp6/q6asm-dai.c                   |  628 +++++++++
 sound/soc/qcom/qdsp6/q6asm.c                       | 1401 ++++++++++++++++++++
 sound/soc/qcom/qdsp6/q6asm.h                       |   69 +
 sound/soc/qcom/qdsp6/q6core.c                      |  380 ++++++
 sound/soc/qcom/qdsp6/q6core.h                      |   15 +
 sound/soc/qcom/qdsp6/q6dsp-common.c                |   66 +
 sound/soc/qcom/qdsp6/q6dsp-common.h                |   24 +
 sound/soc/qcom/qdsp6/q6dsp-errno.h                 |   51 +
 sound/soc/qcom/qdsp6/q6routing.c                   |  983 ++++++++++++++
 sound/soc/qcom/qdsp6/q6routing.h                   |    9 +
 34 files changed, 7572 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/qcom/qcom,apr.txt
 create mode 100644 Documentation/devicetree/bindings/sound/qcom,apq8096.txt
 create mode 100644 Documentation/devicetree/bindings/sound/qcom,q6adm.txt
 create mode 100644 Documentation/devicetree/bindings/sound/qcom,q6afe.txt
 create mode 100644 Documentation/devicetree/bindings/sound/qcom,q6asm.txt
 create mode 100644 Documentation/devicetree/bindings/sound/qcom,q6core.txt
 create mode 100644 drivers/soc/qcom/apr.c
 create mode 100644 include/dt-bindings/soc/qcom,apr.h
 create mode 100644 include/dt-bindings/sound/qcom,q6afe.h
 create mode 100644 include/dt-bindings/sound/qcom,q6asm.h
 create mode 100644 include/linux/soc/qcom/apr.h
 create mode 100644 sound/soc/qcom/apq8096.c
 create mode 100644 sound/soc/qcom/qdsp6/Makefile
 create mode 100644 sound/soc/qcom/qdsp6/q6adm.c
 create mode 100644 sound/soc/qcom/qdsp6/q6adm.h
 create mode 100644 sound/soc/qcom/qdsp6/q6afe-dai.c
 create mode 100644 sound/soc/qcom/qdsp6/q6afe.c
 create mode 100644 sound/soc/qcom/qdsp6/q6afe.h
 create mode 100644 sound/soc/qcom/qdsp6/q6asm-dai.c
 create mode 100644 sound/soc/qcom/qdsp6/q6asm.c
 create mode 100644 sound/soc/qcom/qdsp6/q6asm.h
 create mode 100644 sound/soc/qcom/qdsp6/q6core.c
 create mode 100644 sound/soc/qcom/qdsp6/q6core.h
 create mode 100644 sound/soc/qcom/qdsp6/q6dsp-common.c
 create mode 100644 sound/soc/qcom/qdsp6/q6dsp-common.h
 create mode 100644 sound/soc/qcom/qdsp6/q6dsp-errno.h
 create mode 100644 sound/soc/qcom/qdsp6/q6routing.c
 create mode 100644 sound/soc/qcom/qdsp6/q6routing.h

-- 
2.16.2
