From: Arnaud Pouliquen <arnaud.pouliquen@st.com>
Subject: [PATCH v3 0/4] add IEC958 channel status control helper
Date: Tue, 1 Mar 2016 09:19:13 +0100
Message-ID: <1456820357-2545-1-git-send-email-arnaud.pouliquen@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 by alsa0.perex.cz (Postfix) with ESMTP id AD7FD261504
 for <alsa-devel@alsa-project.org>; Tue,  1 Mar 2016 09:19:36 +0100 (CET)
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
Cc: Jean-Francois Moine <moinejf@free.fr>, Lars-Peter Clausen <lars@metafoo.de>, Russell King - ARM Linux <linux@arm.linux.org.uk>, David Airlie <airlied@linux.ie>, arnaud.pouliquen@st.com, Liam Girdwood <lgirdwood@gmail.com>, Jyri Sarha <jsarha@ti.com>, Takashi Iwai <tiwai@suse.de>, Mark Brown <broonie@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, Moise Gergaud <moise.gergaud@st.com>
List-Id: alsa-devel@alsa-project.org

- Define helpers function  to handle 'IEC958 Playback Default' control
- add "pcm_new" ops  for DAI initialisations that need pcm runtime context. 
	This patchset is needed to be able to associate control to the 
        PCM device. The iec control is linked to the DAI but also to the PCM device.
        Furthermore, some platforms like sti support both HDMI and SPDIF
        outputs in parallel. Logical way to differentiate them is to link them
        to pcm device index. 
V3:
This patchset is extracted from following RFC
http://permalink.gmane.org/gmane.linux.alsa.devel/149876 (sti: add audio interface to the hdmi driver)

Notice that "ASoC: hdmi-codec: add IEC control" patch depends on integration of the hdmi-codec driver

     Patches update:
     - ALSA: pcm: add IEC958 channel status control helper
          - make mutex usage mandatory.
          - Set control index to pcm device id ( needed to be supported by iecset)
     - ASoC: core: add code to complete dai init after pcm creation
          -  fix dai param of pcm_new  ops for cpu dai.
     - ASoC: sti: use iec channel status control helper
     		new patch: implementation of the helper for sti cpu-dai 

V2:
     - patch: ALSA: pcm: add IEC958 channel status control helper
          - Return 1 instead of 0 in snd_pcm_iec958_put
          - Add .access field in control structure
          - I have kept condition on mutex for flexibility 
            (but could be cleaned to force user to use a mutex)

V1:
This RFC is the implementation of audio HDMI on sti platform based on 
generic hdmi-codec driver:
	https://patchwork.kernel.org/patch/7215271/ ("ASoC: hdmi-codec: Add hdmi-codec for external HDMI-encoders")


Arnaud Pouliquen (4):
  ALSA: pcm: add IEC958 channel status control helper
  ASoC: core: add code to complete dai init after pcm creation
  ASoC: sti: use iec channel status control helper
  ASoC: hdmi-codec: add IEC control.

 include/sound/hdmi-codec.h      |   1 +
 include/sound/pcm_iec958.h      |  15 ++++++
 include/sound/soc-dai.h         |   7 +++
 sound/core/pcm_iec958.c         | 107 ++++++++++++++++++++++++++++++++++++++++
 sound/soc/codecs/hdmi-codec.c   |  59 ++++++++++++++++------
 sound/soc/soc-core.c            |  14 ++++++
 sound/soc/sti/Kconfig           |   1 +
 sound/soc/sti/uniperif_player.c |  79 ++++++++++++-----------------
 8 files changed, 219 insertions(+), 62 deletions(-)

-- 
1.9.1
