From: Arnaud Pouliquen <arnaud.pouliquen@st.com>
Subject: [PATCH v5 0/1] sti: add audio interface to the hdmi
	driver
Date: Mon, 30 May 2016 15:31:36 +0200
Message-ID: <1464615097-29446-1-git-send-email-arnaud.pouliquen@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [62.209.51.94]) by alsa0.perex.cz (Postfix) with ESMTP id CB12526073D
 for <alsa-devel@alsa-project.org>; Mon, 30 May 2016 15:32:12 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, dri-devel@lists.freedesktop.org
Cc: Jean-Francois Moine <moinejf@free.fr>, Lars-Peter Clausen <lars@metafoo.de>, Russell King - ARM Linux <linux@arm.linux.org.uk>, kernel@stlinux.com, David Airlie <airlied@linux.ie>, arnaud.pouliquen@st.com, Liam Girdwood <lgirdwood@gmail.com>, Jyri Sarha <jsarha@ti.com>, Takashi Iwai <tiwai@suse.de>, Mark Brown <broonie@kernel.org>, Benjamin Gaignard <benjamin.gaignard@linaro.org>, Daniel Vetter <daniel.vetter@intel.com>, Philipp Zabel <p.zabel@pengutronix.de>
List-Id: alsa-devel@alsa-project.org

This patchset implements audio interface in HDMI drm driver. Implementation is based on 
ASoC generic hdmi codec driver( https://patchwork.kernel.org/patch/8713141/). 

V5:
	Helper functions are suppressed, following dicussion on IRC with Daniel Vetter.
        request is that other drivers that can use helper are also updated
        helper function patch will be proposed  in a next, separed patchset.
        for this track, hdmi_audio_get_non_coherent_n is integrated in sti driver.
        
V4:
     fixes for "video: hdmi: add helper functions for N and CTS"
        - typo error and additional comments
        - cts_1_ratio computation
        - warning reported by kbuild test robot
        - add rounded value for 297/1.001 MHz

V3: 
     - video: hdmi: add helper function for N and CTS
     	  Also used on Mediatek platform (https://patchwork.kernel.org/patch/8887341)
	  delta vs V2:
          - typo fixes
          - if/else code optimisation
     - drm: sti: Add ASoC generic hdmi codec support.
	  - typo fixes
          - add audio registers in debugfs information
                
V2: RFC
https://patchwork.kernel.org/patch/8091531/("video: hdmi: add helper function for N and CTS")
https://patchwork.kernel.org/patch/8091561/("ASoC: hdmi-codec: Add hdmi-codec for external HDMI-encoders")
     - patch: video: hdmi: add helper function for N and CTS
         Fixes based on Russel King remarks
         - Duplicate function to have a separte treatment for coherent and
           non-coherent clocks
         - Add ratio field for alternate CTS value
         - Clock frequency in Hz for TMDS and audio clocks
         - Add information concerning clocks and CTS calculation. 

V1: 
This RFC is the implementation of audio HDMI on sti platform based on generic hdmi-codec driver:
	https://patchwork.kernel.org/patch/7215271/ ("ASoC: hdmi-codec: Add hdmi-codec for external HDMI-encoders")
	https://patchwork.kernel.org/patch/8062611/ ("video: hdmi: add helper function for N and CTS")

Arnaud Pouliquen (1):
  drm: sti: Add ASoC generic hdmi codec support.

 drivers/gpu/drm/sti/Kconfig    |   1 +
 drivers/gpu/drm/sti/sti_hdmi.c | 294 ++++++++++++++++++++++++++++++++++++++---
 drivers/gpu/drm/sti/sti_hdmi.h |  13 ++
 3 files changed, 291 insertions(+), 17 deletions(-)

-- 
1.9.1
