From: Rajeev Kumar <rajeev-dlh.kumar@st.com>
Subject: [PATCH 0/8] Add ASoC drivers for SPEAr platform
Date: Tue, 20 Mar 2012 17:03:44 +0530
Message-ID: <cover.1332242166.git.rajeev-dlh.kumar@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from eu1sys200aog108.obsmtp.com (eu1sys200aog108.obsmtp.com
	[207.126.144.125])
	by alsa0.perex.cz (Postfix) with ESMTP id D6516104235
	for <alsa-devel@alsa-project.org>; Tue, 20 Mar 2012 12:34:49 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de, broonie@opensource.wolfsonmicro.com, perex@perex.cz
Cc: alsa-devel@alsa-project.org, spear-devel@list.st.com, Rajeev Kumar <rajeev-dlh.kumar@st.com>, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

This patch set adds support for ASoC sound drivers on ST's SPEAr
platforms. Details of the SPEAr platforms can be seen here:

http://www.st.com/internet/mcu/product/250658.jsp

This patch set supports the following modules:

1. Audio codec sta529 (connected to I2S controller).
2. SPDIF IN dummy Codec.
3. Synopsys Designware I2S controller.
4. ST SPDIF IN controller.
5. ST SPDIF OUT controller.

This patch set has been tested for linux-kernel-version 3.3-rc3 on SPEAr
platform.

In past, I had circulated the patch for the same and got some review
comments. I have incorporate those commnets also. Please find the link
below.
http://mailman.alsa-project.org/pipermail/alsa-devel/2011-April/038738.html

Rajeev Kumar (6):
  sound:asoc: Add support for STA529 Audio Codec
  sound:asoc: Add support for synopsys i2s controller as per ASoC
    framework.
  sound:asoc: Add support for SPEAr ASoC pcm layer.
  sound:asoc: Add support for SPEAr ASoC machine driver.
  sound:asoc: Add Kconfig and Makefile to support SPEAr audio driver
  sound:asoc: Update Kconfig and Makefile(sound/soc/) to support SPEAr
    audio

Vipin Kumar (2):
  sound:asoc:spdif_in: Add spdif IN support
  sound:asoc:spdif_out: Add spdif out support

 include/linux/designware_i2s.h   |   63 ++++
 sound/soc/Kconfig                |    1 +
 sound/soc/Makefile               |    1 +
 sound/soc/codecs/Kconfig         |    5 +
 sound/soc/codecs/Makefile        |    2 +
 sound/soc/codecs/sta529.c        |  414 ++++++++++++++++++++++++++
 sound/soc/spear/Kconfig          |   46 +++
 sound/soc/spear/Makefile         |   16 +
 sound/soc/spear/designware_i2s.c |  610 ++++++++++++++++++++++++++++++++++++++
 sound/soc/spear/spdif_in.c       |  304 +++++++++++++++++++
 sound/soc/spear/spdif_in_regs.h  |   60 ++++
 sound/soc/spear/spdif_out.c      |  397 +++++++++++++++++++++++++
 sound/soc/spear/spdif_out_regs.h |   79 +++++
 sound/soc/spear/spear_evb.c      |  278 +++++++++++++++++
 sound/soc/spear/spear_pcm.c      |  460 ++++++++++++++++++++++++++++
 sound/soc/spear/spear_pcm.h      |   33 ++
 16 files changed, 2769 insertions(+), 0 deletions(-)
 create mode 100644 include/linux/designware_i2s.h
 create mode 100644 sound/soc/codecs/sta529.c
 create mode 100644 sound/soc/spear/Kconfig
 create mode 100644 sound/soc/spear/Makefile
 create mode 100644 sound/soc/spear/designware_i2s.c
 create mode 100644 sound/soc/spear/spdif_in.c
 create mode 100644 sound/soc/spear/spdif_in_regs.h
 create mode 100644 sound/soc/spear/spdif_out.c
 create mode 100644 sound/soc/spear/spdif_out_regs.h
 create mode 100644 sound/soc/spear/spear_evb.c
 create mode 100644 sound/soc/spear/spear_pcm.c
 create mode 100644 sound/soc/spear/spear_pcm.h

-- 
1.7.2.2
