From: Rajeev Kumar <rajeev-dlh.kumar@st.com>
Subject: [PATCH V3 0/5] Adding ASoC drivers for SPEAr13XX
	platform
Date: Mon, 11 Apr 2011 10:59:59 +0530
Message-ID: <1302499804-24386-1-git-send-email-rajeev-dlh.kumar@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from eu1sys200aog106.obsmtp.com (eu1sys200aog106.obsmtp.com
	[207.126.144.121])
	by alsa0.perex.cz (Postfix) with ESMTP id 8D04F103811
	for <alsa-devel@alsa-project.org>;
	Mon, 11 Apr 2011 07:31:23 +0200 (CEST)
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
Cc: alsa-devel@alsa-project.org, Rajeev Kumar <rajeev-dlh.kumar@st.com>, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

This patchset contains five patches which add support for ASoC sound
drivers on ST's SPEAr13XX platform. Details of the SPEAr13XX
platforms can be seen here:
http://www.st.com/internet/mcu/product/250658.jsp

The ARCH and PLATFORM specific code for SPEAr13XX are
already under review in Russell King's ARM mailing
list(Linux-kernel-version 2.6.38-rc4).

This patchset has been tested for linux-kernel-version 2.6.38-rc4 and
on ARM platform.

Please review the same and consider for mainline inclusion.

Changes in spear Kconfig and Makefile since V2:
1.giving all the the modules snd-soc- prefixes to their names
Changes in codec code since V2:
1. use SOC_DOUBLE for volume control
2. remove default configuration for codec .offer them as runtime controls.
3. restore the register cache in resume
changes in platform code since V1:
1. Spilt machine driver from platform driver.
2. Updated rate supported.
3. Moved clock specific part from "spear13xx_i2s_set_dai_sysclk".
   function to platform code. This function is removed now.
4. Function "spear13xx_i2s_startup" removed.
5. Function "spear13xx_i2s_shutdown" removed.

Changes in codec code since V1:
1. Removed sta529 version number.
2. Removed "sta529_read_reg_cache".
3. Removed function "sta529_write_reg_cache".
4. Removed function "sta529_write".
5. Moved sta529.h file contents to sta529.c file.
6. Move clock specific part from "spear_sta_set_dai_sysclk".
   function to platform code. This function is removed now.
7. Renamed function names from spear_sta_* to sta_*.
8. Modified probe() function to avoid rewriting default chip values to hardware.

Rajeev Kumar (5):
  sound: asoc: Adding support for STA529 Audio Codec
  sound: asoc: Adding support for SPEAr13XX ASoC platform driver
  sound: asoc: Adding support for SPEAr13XX ASoC machine driver
  sound: asoc: Adding Kconfig and Makefile to support SPEAr13XX ASoC
    driver
  sound: asoc: Adding support for SPEAr13XX in soc

 sound/soc/Kconfig               |    1 +
 sound/soc/Makefile              |    1 +
 sound/soc/codecs/Kconfig        |    5 +
 sound/soc/codecs/Makefile       |    2 +
 sound/soc/codecs/sta529.c       |  383 ++++++++++++++++++++++++++++
 sound/soc/spear/Kconfig         |   19 ++
 sound/soc/spear/Makefile        |   12 +
 sound/soc/spear/evb_sta529.c    |  103 ++++++++
 sound/soc/spear/spear13xx-i2s.c |  523 +++++++++++++++++++++++++++++++++++++++
 sound/soc/spear/spear13xx-i2s.h |   19 ++
 sound/soc/spear/spear13xx-pcm.c |  500 +++++++++++++++++++++++++++++++++++++
 sound/soc/spear/spear13xx-pcm.h |   50 ++++
 12 files changed, 1618 insertions(+), 0 deletions(-)
 create mode 100644 sound/soc/codecs/sta529.c
 create mode 100644 sound/soc/spear/Kconfig
 create mode 100644 sound/soc/spear/Makefile
 create mode 100644 sound/soc/spear/evb_sta529.c
 create mode 100644 sound/soc/spear/spear13xx-i2s.c
 create mode 100644 sound/soc/spear/spear13xx-i2s.h
 create mode 100644 sound/soc/spear/spear13xx-pcm.c
 create mode 100644 sound/soc/spear/spear13xx-pcm.h
