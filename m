From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v2 0/2] ASoC: omap-mcpdm: New McPDM driver
Date: Fri, 19 Aug 2011 10:41:17 +0300
Message-ID: <1313739679-8975-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from comal.ext.ti.com (comal.ext.ti.com [198.47.26.152])
	by alsa0.perex.cz (Postfix) with ESMTP id 97E2C10390A
	for <alsa-devel@alsa-project.org>;
	Fri, 19 Aug 2011 09:41:28 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, Misael Lopez Cruz <misael.lopez@ti.com>
List-Id: alsa-devel@alsa-project.org

Hello Mark, Liam,

I tried to address the comments regarding to version 1 of the new McPDM driver:
http://mailman.alsa-project.org/pipermail/alsa-devel/2011-July/041690.html

The omap hwmod conversion part of the v1 series has been sent as part of the
fixup series for 3.1 to make basic audio work out of box.

This series is aimed for 3.2 due to the scale of the change.
I tried to split patch 2, but I did not managed to find an incremental path from
the old driver to the new one.

I have updated the commit message for patch 2 to explain the reasoning behind
the rewritten driver, so it can be easily looked up.

Notable changes since v1:
- delayed_work from the new driver has been removed, and replaced with a
  DAPM_SUPPLY widget. This widget need to be connected to DAC/ADC of the codec
  by the machine driver in order to have the correct sequence for power off.
The first patch adds private_data pointer for dapm widgets. This private_data
can be used to add widget specific data to any widget. I think this can be handy
for others as well in the future.

- Full duplex audio in legacy mode has been fixed, so we can run arecord | aplay

This series depends on the McPDM fixup patches:
http://mailman.alsa-project.org/pipermail/alsa-devel/2011-August/042401.html

Peter

PS: to make the review easier, I have asked git format-patch to treat the change
as rewrite.

---
Misael Lopez Cruz (1):
  ASoC: omap-mcpdm: Replace legacy driver

Peter Ujfalusi (1):
  ASoC: DAPM: Add private data pointer for DAPM widget

 include/sound/soc-dapm.h    |    1 +
 sound/soc/omap/Makefile     |    2 +-
 sound/soc/omap/mcpdm.c      |  472 -------------------------
 sound/soc/omap/mcpdm.h      |  152 --------
 sound/soc/omap/omap-mcpdm.c |  823 ++++++++++++++++++++++++++++---------------
 sound/soc/omap/omap-mcpdm.h |   97 +++++
 sound/soc/omap/sdp4430.c    |   14 +-
 7 files changed, 656 insertions(+), 905 deletions(-)
 delete mode 100644 sound/soc/omap/mcpdm.c
 delete mode 100644 sound/soc/omap/mcpdm.h
 rewrite sound/soc/omap/omap-mcpdm.c (46%)
 create mode 100644 sound/soc/omap/omap-mcpdm.h

-- 
1.7.6
