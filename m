From: Arnaud Pouliquen <arnaud.pouliquen@st.com>
Subject: [RFC 0/6] sti: add audio interface to the hdmi driver
Date: Tue, 19 Jan 2016 14:40:30 +0100
Message-ID: <1453210836-16218-1-git-send-email-arnaud.pouliquen@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 395E6260536
 for <alsa-devel@alsa-project.org>; Tue, 19 Jan 2016 14:41:02 +0100 (CET)
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

This patch-set is implementation of audio HDMI on sti platform based on 
generic hdmi-codec driver proposed by Jyri Sarha.
	https://patchwork.kernel.org/patch/7215271/ ("ASoC: hdmi-codec: Add hdmi-codec for external HDMI-encoders")

hdmi-codec is compatible with STi implementation.

In addition i have listed below two features that seem missing:

1) IEC958 channel status control support.
If channel status is handled by HDMI codec, it needs also to support 
IEC61937 format for none PCM stream. In this case a control shall be
created to allows user to set the expected mode, and associated parameters.
Another constraint is that this control should be linked to PCM device to 
support as example a SPDIF and a HDMI out with 2 separate controls.

In this patch set I propose an implementation to support it:
	- ALSA: pcm: add IEC958 channel status control helper
		add generic function to control and handle IEC controls
		customer and professional mask controls could be added if
		needed...
	- ASoC: core: add code to complete dai init after pcm creation
		Add a callback in snd_soc_dai_ops to allow to link DAI controls
		to PCM device

2) HDMI Audio info frame speaker mapping.
To be HDMI 1.4b compliant AIF speaker channel allocation (byte 4) needs
to be set for PCM streams, that contain more than 2 channels.
omap2 driver set hard-coded value for stereo, 5.1 and 7.1. But This 
information should be provided by user that decodes the stream.
I did not implement it but what about a generic CEA861 control to support
the feature?

To finish I'm still interested in having your feed back on patch that propose
a generic implementation to compute N and CTS...

Arnaud Pouliquen (6):
  video: hdmi: add helper function for N and CTS
  ALSA: pcm: add IEC958 channel status control helper
  ASoC: core: add code to complete dai init after pcm creation
  drm: sti: Add ASoC generic hdmi codec support.
  ASoc: hdmi-codec: add IEC control.
  ARM: DT: b2120: add audio HDMI dai link in audio card


 arch/arm/boot/dts/stihxxx-b2120.dtsi |  15 ++-
 drivers/gpu/drm/sti/Kconfig          |   1 +
 drivers/gpu/drm/sti/sti_hdmi.c       | 253 ++++++++++++++++++++++++++++++++---
 drivers/gpu/drm/sti/sti_hdmi.h       |  10 ++
 drivers/video/hdmi.c                 | 146 ++++++++++++++++++++
 include/linux/hdmi.h                 |  11 ++
 include/sound/hdmi-codec.h           |   1 +
 include/sound/pcm_iec958.h           |  16 +++
 include/sound/soc-dai.h              |   7 +
 sound/core/pcm_iec958.c              |  90 +++++++++++++
 sound/soc/codecs/hdmi-codec.c        |  59 ++++++--
 sound/soc/soc-core.c                 |  14 ++
 12 files changed, 591 insertions(+), 32 deletions(-)

-- 
1.9.1
