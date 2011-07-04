From: Liam Girdwood <lrg@ti.com>
Subject: [GIT PULL] ASoC updates for 3.1
Date: Mon, 4 Jul 2011 22:10:25 +0100
Message-ID: <4E122C41.5060307@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from arroyo.ext.ti.com (arroyo.ext.ti.com [192.94.94.40])
	by alsa0.perex.cz (Postfix) with ESMTP id 182B4103896
	for <alsa-devel@alsa-project.org>;
	Mon,  4 Jul 2011 23:10:30 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

The following changes since commit d21685ec258f803d3badae5eae821383a34815a9:

  Merge branch 'for-2.6.40' into for-2.6.41 (2011-05-30 10:54:18 +0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/lrg/asoc-2.6.git for-3.1

Jarkko Nikula (1):
      ASoC: tlv320aic3x: Add correct hw registers to Line1 cross connect muxes

Ricardo Neri (4):
      ASoC: OMAP: Add CPU DAI driver for HDMI
      ASoC: OMAP4: Add HDMI Audio machine driver for OMAP4 boards
      ASoC: OMAP: Update Makefile and Kconfig for HDMI audio
      ASoC: twl6040 - According to TWL6040 specification, gain start at 6dB and not -6dB.

 sound/soc/codecs/tlv320aic3x.c   |   34 +++++---
 sound/soc/codecs/twl6040.c       |    4 +-
 sound/soc/omap/Kconfig           |   11 +++
 sound/soc/omap/Makefile          |    4 +
 sound/soc/omap/omap-hdmi.c       |  158 ++++++++++++++++++++++++++++++++++++++
 sound/soc/omap/omap-hdmi.h       |   36 +++++++++
 sound/soc/omap/omap4-hdmi-card.c |  129 +++++++++++++++++++++++++++++++
 7 files changed, 361 insertions(+), 15 deletions(-)
 create mode 100644 sound/soc/omap/omap-hdmi.c
 create mode 100644 sound/soc/omap/omap-hdmi.h
 create mode 100644 sound/soc/omap/omap4-hdmi-card.c
