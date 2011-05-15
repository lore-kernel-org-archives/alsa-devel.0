From: Ricardo Neri <ricardo.neri@ti.com>
Subject: [PATCH v2 0/5] ASoC: OMAP4: Add support for HDMI audio
Date: Sun, 15 May 2011 04:36:30 -0500
Message-ID: <1305452195-19177-1-git-send-email-ricardo.neri@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from comal.ext.ti.com (comal.ext.ti.com [198.47.26.152])
	by alsa0.perex.cz (Postfix) with ESMTP id 61EFD103806
	for <alsa-devel@alsa-project.org>;
	Sun, 15 May 2011 11:38:11 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com, lrg@slimlogic.co.uk, lrg@ti.com, tomi.valkeinen@ti.com
Cc: Ricardo Neri <ricardo.neri@ti.com>
List-Id: alsa-devel@alsa-project.org

This is to add support for HDMI audio on OMAP4 chips. This work has two
parts: DSS implementation and ASoC implementation. This set of patches
presents the ASoC implementation. The approach is to utilize the DSS
HDMI driver to act as an ASoC codec. This set of patches adds the ASoC
CPU DAI and machine drivers. These drivers will utilize the ASoC HDMI
codec provided in the DSS HDMI driver. DSS part of the implementation 
is currently under review in the linux-omap list.

The DSS HDMI driver controls the availability of HDMI output and audio
can be played only when the HDMI video device is enabled and the video
timing in use is one of the CEA-861-D video timings supported by the
OMAP4 HDMI IP.

This implementation is for Basic Audio as defined in CEA-861-D: 16 bit/sample
linear PCM 2-channel audio with sample rates of 32, 44.1 and 48kHz. As
described in the HDMI specification, support for Basic Audio is mandatory
for HDMI sinks and does not require of EDID parsing.

Additionally, this implementation supports 24-bit samples in 32-bit words.
Further audio capabilities such as more sample rates and multichannel audio
will be added in the future when EDID parsing is available for HDMI driver.

This implementation is based on on:
* OMAP4: DSS2: Add dss_dss_clk opt clock for OMAP4, by Sumit Semwal
 (http://gitorious.org/linux-omap-dss2/linux/commit/0da5637569bb9bf93e6930cd1c3b452eede50ba2)
* Kernel 2.6.39-rc7
 (git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git v2.6.39-rc7)

* v1 of OMAP4: DSS2: HDMI: Add support for audio
 http://www.mail-archive.com/linux-omap@vger.kernel.org/msg49011.html
 
In order to validate functionality, it is necessary to utilize the DSS
HDMI ASoC codec. The complete implementation, DSS and ASoC parts, is available at:
 git://gitorious.org/omap-audio/linux-audio.git ricardon/topic/hdmi-audio-v2
 
Validation was performed on HDMI TV. Penguins were present on the display
and audio playback was performed with aplay at 32, 44.1 and 48kHz with S16_LE
and S24_LE sample formats. Validation was performed on SDP4430 ES2.1 and ES2.2
and Panda ES2.1 and ES2.0.


Changes from V1:
1. Moved check of HDMI power state from CPU DAI start-up to machine hw_params.
2. Improved error handling when checking HDMI power-state.
3. Removed build-time conditionals for HDMI devices.
4. Added MODULE_ALIASes to drivers.
5. Merged CPU DAI header patch with its driver patch.
6. Use dev_err to print error messages.
7. Removed unnecessary calls to set_drvdata.
8. Corrected e-mail addresses of authors.
9. Corrected indentation.


Ricardo Neri (5):
  OMAP4: HDMI: Add OMAP device for HDMI audio CPU DAI
  OMAP4: Add device for HDMI OMAP4 audio for ASoC machine driver
  ASoC: OMAP: Add CPU DAI driver for HDMI
  ASoC: OMAP4: Add HDMI Audio machine driver for OMAP4 boards
  ASoC: OMAP: Update Makefile and Kconfig for HDMI audio

 arch/arm/mach-omap2/devices.c    |   26 ++++++
 sound/soc/omap/Kconfig           |   11 +++
 sound/soc/omap/Makefile          |    4 +
 sound/soc/omap/omap-hdmi.c       |  158 ++++++++++++++++++++++++++++++++++++++
 sound/soc/omap/omap-hdmi.h       |   36 +++++++++
 sound/soc/omap/omap4-hdmi-card.c |  129 +++++++++++++++++++++++++++++++
 6 files changed, 364 insertions(+), 0 deletions(-)
 create mode 100644 sound/soc/omap/omap-hdmi.c
 create mode 100644 sound/soc/omap/omap-hdmi.h
 create mode 100644 sound/soc/omap/omap4-hdmi-card.c
