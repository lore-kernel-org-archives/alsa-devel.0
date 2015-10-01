From: Arnaud Pouliquen <arnaud.pouliquen@st.com>
Subject: [PATCH RFC V2 0/5] another generic audio hdmi codec
	proposal
Date: Thu, 1 Oct 2015 18:50:16 +0200
Message-ID: <1443718221-5120-1-git-send-email-arnaud.pouliquen@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 by alsa0.perex.cz (Postfix) with ESMTP id B6E392667CF
 for <alsa-devel@alsa-project.org>; Thu,  1 Oct 2015 18:50:59 +0200 (CEST)
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
Cc: moinejf@free.fr, linux@arm.linux.org.uk, bcousson@baylibre.com, David Airlie <airlied@linux.ie>, tomi.valkeinen@ti.com, arnaud.pouliquen@st.com, lgirdwood@gmail.com, Jyri Sarha <jsarha@ti.com>, peter.ujfalusi@ti.com, Takashi Iwai <tiwai@suse.de>, tony@atomide.com, broonie@kernel.org, Benjamin Gaignard <benjamin.gaignard@linaro.org>
List-Id: alsa-devel@alsa-project.org


Version 2:
This version integrates missing features upgraded to be aligned when possible 
with patch set:
[PATCH RFC v4 0/8] Implement generic ASoC HDMI codec and use it in tda998x

It does not support the abort callback, the mute and syclk ops. 
This could be added in V3 or separate patch if justified.  

  [RFC 1/5]video: hdmi: add help function for N and CTS
	- Replace real frequency value by enum in switch case
	Notice that this patch is independant from the rest of the implentation
  [RFC 2/5]drm: add helper functions to add audio capabilities for bridge
	- extend audio bridge ops
  [RFC 3/5]ASoC: codec:  hdmi drm codec driver
	aligned when possible with hdmi-codec.c implementation
	. ELD management for alsa contraints
	. Support of SPDIF and I2S mode
	. hwparam ond set_fmt functions implemented
  [RFC 4/5]drm: sti: connect audio driver
	=> Implementation for STI platform
  [RFC 5/5]DT: sti: add audio HDMI dai link in audio card
	=> Devicetree example

Version 1:

This patch set is a tentative to implement a generic code for the HDMI audio.
Main concept are aligned with solution proposeded for TI platform. 
 -  ASoC codec driver registered by DRM driver
 -  ASOC driver is a generic driver.
 -  compatible with simple card
 
 Difference is that i propose a DRM generic interface based on bridge structure.
 Advantage is that all data exchanges are done through the DRM API.
 
 I think also that some helper functions could been used for N and CTS parameters calculation,
 as suggested by Russell King in a previous mail.
 
 I full aware that some features (like ELD and info frame) are partially or not implemented in my patches. 
 This patch set is more a skeleton than a full implementation...
 I just post it to suggest a possible DRM API.

Arnaud Pouliquen (5):
  video: hdmi: add helper function for N and CTS
  drm: add helper function to add audio capabilities for bridge
  ASoC: codec:  hdmi drm codec driver
  drm: sti: connect audio driver
  DT: sti: add audio HDMI dai link in audio card

 arch/arm/boot/dts/stih410.dtsi       |   6 +-
 arch/arm/boot/dts/stihxxx-b2120.dtsi |  21 ++
 drivers/gpu/drm/drm_bridge.c         | 137 +++++++++++++-
 drivers/gpu/drm/sti/sti_hdmi.c       | 184 ++++++++++++++++--
 drivers/gpu/drm/sti/sti_hdmi.h       |   3 +
 drivers/video/hdmi.c                 | 147 ++++++++++++++
 include/drm/drm_crtc.h               |  62 ++++++
 include/drm/drm_modes.h              |  12 ++
 include/linux/hdmi.h                 |  12 ++
 include/sound/hdmi_drm.h             |  15 ++
 sound/soc/codecs/Kconfig             |   8 +-
 sound/soc/codecs/Makefile            |   2 +
 sound/soc/codecs/hdmi_drm.c          | 358 +++++++++++++++++++++++++++++++++++
 13 files changed, 951 insertions(+), 16 deletions(-)
 create mode 100644 include/sound/hdmi_drm.h
 create mode 100644 sound/soc/codecs/hdmi_drm.c

-- 
1.9.1
