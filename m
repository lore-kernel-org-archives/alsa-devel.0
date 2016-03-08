From: Arnaud Pouliquen <arnaud.pouliquen@st.com>
Subject: [PATCH v4 0/6] add IEC958 channel status control
	helpers
Date: Tue, 8 Mar 2016 13:53:55 +0100
Message-ID: <1457441641-7501-1-git-send-email-arnaud.pouliquen@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 by alsa0.perex.cz (Postfix) with ESMTP id A5C042614FF
 for <alsa-devel@alsa-project.org>; Tue,  8 Mar 2016 13:54:27 +0100 (CET)
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

V4
- Link pcm control, defined in dai, to PCM device:
	Discard solution based on  "pcm_new" ops  for DAI initialisations
        replace it by an helper function that registers pcm control and links
        it to pcm device.  
- Define helpers function to handle 'IEC958 Playback Default' control
	. add snd_pcm_iec958_ctl_new helper for compatibility with
        snd_soc_add_dai_pcm_controls implementation
        . add substream parameter for snd_pcm_create_iec958_ctl function
        . fixes based on Takashi remarks.

V3:
- Define helpers function  to handle 'IEC958 Playback Default' control
- add "pcm_new" ops  for DAI initialisations that need pcm runtime context. 
	This patchset is needed to be able to associate control to the 
        PCM device. The iec control is linked to the DAI but also to the PCM device.
        Furthermore, some platforms like sti support both HDMI and SPDIF
        outputs in parallel. Logical way to differentiate them is to link them
        to pcm device index. 

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

Arnaud Pouliquen (5):
  ASoC: core: add  snd_soc_add_dai_pcm_controls helper
  ASoC: sti: use snd_soc_add_dai_pcm_controls helper
  ALSA: pcm: add IEC958 channel status control helper
  ASoC: core: allow private data for snd_soc_add_dai_pcm_controls
  ASoC: sti: use iec channel status control helper

 include/sound/hdmi-codec.h    |  1 +
 include/sound/pcm_iec958.h      |  21 +++++
 include/sound/soc-dai.h         |   1 +
 include/sound/soc.h             |   3 +
 sound/core/pcm_iec958.c         | 125 ++++++++++++++++++++++++++++++
 sound/soc/codecs/hdmi-codec.c | 54 ++++++++++++++++++++++++++++++++-----------
 sound/soc/soc-core.c            | 168 +++++++++++++++++++++++++++++++++++-----
 sound/soc/sti/Kconfig           |   1 +
 sound/soc/sti/sti_uniperif.c    |  57 +++++++-------
 sound/soc/sti/uniperif.h        |   1 +
 sound/soc/sti/uniperif_player.c |  80 +++++--------------
 11 files changed, 386 insertions(+), 126 deletions(-)

-- 
1.9.1
