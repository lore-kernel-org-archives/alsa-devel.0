From: Arnaud Pouliquen <arnaud.pouliquen@st.com>
Subject: [RFC 0/5] another generic audio hdmi codec proposal
Date: Mon, 21 Sep 2015 15:19:51 +0200
Message-ID: <1442841596-1323-1-git-send-email-arnaud.pouliquen@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [62.209.51.94]) by alsa0.perex.cz (Postfix) with ESMTP id 86F4226128B
 for <alsa-devel@alsa-project.org>; Mon, 21 Sep 2015 15:21:16 +0200 (CEST)
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
Cc: moinejf@free.fr, linux@arm.linux.org.uk, Takashi Iwai <tiwai@suse.de>, tomi.valkeinen@ti.com, arnaud.pouliquen@st.com, lgirdwood@gmail.com, Jyri Sarha <jsarha@ti.com>, peter.ujfalusi@ti.com, airlied@linux.ie, tony@atomide.com, broonie@kernel.org, bcousson@baylibre.com
List-Id: alsa-devel@alsa-project.org

I 'm working on HDMI implementation for sti platform. 
As some discussions are on going for audio on HDMI. Here is the begin of my work...

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
  video: hdmi: add help function for N and cts
  drm: add helper functionto add audio capabilities for bridge
  ASoC: codec:  hdmi drm codec driver
  drm: sti: connect audio driver
  DT: sti: add audio HDMI dai link in audio card

 arch/arm/boot/dts/stih410.dtsi       |   4 +-
 arch/arm/boot/dts/stihxxx-b2120.dtsi |  21 +++++
 arch/arm/configs/multi_v7_defconfig  |   1 +
 drivers/gpu/drm/drm_bridge.c         | 114 +++++++++++++++++++++++++++
 drivers/gpu/drm/sti/sti_hdmi.c       | 146 +++++++++++++++++++++++++++++++---
 drivers/gpu/drm/sti/sti_hdmi.h       |   3 +
 drivers/video/hdmi.c                 | 148 +++++++++++++++++++++++++++++++++++
 include/drm/drm_crtc.h               |  31 ++++++++
 include/linux/hdmi.h                 |  24 ++++++
 include/sound/hdmi_drm.h             |  16 ++++
 sound/soc/codecs/Kconfig             |   4 +
 sound/soc/codecs/Makefile            |   2 +
 sound/soc/codecs/hdmi_drm.c          | 125 +++++++++++++++++++++++++++++
 13 files changed, 625 insertions(+), 14 deletions(-)
 create mode 100644 include/sound/hdmi_drm.h
 create mode 100644 sound/soc/codecs/hdmi_drm.c

-- 
1.9.1
