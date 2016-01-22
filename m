From: Arnaud Pouliquen <arnaud.pouliquen@st.com>
Subject: [RFC v2 0/6] sti: add audio interface to the hdmi
	driver
Date: Fri, 22 Jan 2016 18:48:26 +0100
Message-ID: <1453484912-24547-1-git-send-email-arnaud.pouliquen@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 6CCD02604AF
 for <alsa-devel@alsa-project.org>; Fri, 22 Jan 2016 18:48:53 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Jean-Francois Moine <moinejf@free.fr>, Lars-Peter Clausen <lars@metafoo.de>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Philipp Zabel <p.zabel@pengutronix.de>, David Airlie <airlied@linux.ie>, arnaud.pouliquen@st.com, Liam Girdwood <lgirdwood@gmail.com>, Jyri Sarha <jsarha@ti.com>, Takashi Iwai <tiwai@suse.de>, Mark Brown <broonie@kernel.org>, Benjamin Gaignard <benjamin.gaignard@linaro.org>
List-Id: alsa-devel@alsa-project.org

V2:
     - patch: ALSA: pcm: add IEC958 channel status control helper
          - Return 1 instead of 0 in snd_pcm_iec958_put
          - Add .access field in control structure
          - I have kept condition on mutex for flexibility 
            (but could be cleaned to force user to use a mutex)
     - patch: video: hdmi: add helper function for N and CTS
         - Duplicate function to have a separte treatment for coherent and
           non-coherent clcocks
         - Add ratio fiel for alternate CTS value
         - Clock frequency in Hz for TMDS and audio clocks
         - Add information concerning clocks and CTS calculation. 

V1:
This RFC is the implementation of audio HDMI on sti platform based on 
generic hdmi-codec driver:
	https://patchwork.kernel.org/patch/7215271/ ("ASoC: hdmi-codec: Add hdmi-codec for external HDMI-encoders")

Arnaud Pouliquen (6):
  video: hdmi: add helper function for N and CTS
  ALSA: pcm: add IEC958 channel status control helper
  ASoC: core: add code to complete dai init after pcm creation
  drm: sti: Add ASoC generic hdmi codec support.
  ASoc: hdmi-codec: add IEC control.
  ARM: DT: b2120: add audio HDMI dai link in audio card


 arch/arm/boot/dts/stihxxx-b2120.dtsi |  15 ++-
 drivers/gpu/drm/sti/Kconfig          |   1 +
 drivers/gpu/drm/sti/sti_hdmi.c       | 248 ++++++++++++++++++++++++++++++++---
 drivers/gpu/drm/sti/sti_hdmi.h       |  10 ++
 drivers/video/hdmi.c                 | 222 +++++++++++++++++++++++++++++++
 include/linux/hdmi.h                 |  22 ++++
 include/sound/hdmi-codec.h           |   1 +
 include/sound/pcm_iec958.h           |  16 +++
 include/sound/soc-dai.h              |   7 +
 sound/core/pcm_iec958.c              |  99 ++++++++++++++
 sound/soc/codecs/hdmi-codec.c        |  59 +++++++--
 sound/soc/soc-core.c                 |  14 ++
 12 files changed, 682 insertions(+), 32 deletions(-)

-- 
1.9.1
