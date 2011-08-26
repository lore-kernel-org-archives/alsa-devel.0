From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v3 0/3] ASoC: omap-mcpdm: New McPDM driver
Date: Fri, 26 Aug 2011 16:33:20 +0300
Message-ID: <1314365603-8947-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bear.ext.ti.com (bear.ext.ti.com [192.94.94.41])
	by alsa0.perex.cz (Postfix) with ESMTP id D5E8224621
	for <alsa-devel@alsa-project.org>;
	Fri, 26 Aug 2011 15:33:25 +0200 (CEST)
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

Hello,

Changes since v2 [1]:
- Code for the DAPM_SUPPLY widget attach has been moved to core (Request from
  Mark, if I understood correctly).
 - Makes it reusable in other drivers
 - Additional code still needed in DAI (event handler, selection of the dai),
   and machine drivers (DAPM routing)
 - Should work even if we have multiple instances of the DAI (coment from
   Lars-Peter Clausen)

[1]
http://mailman.alsa-project.org/pipermail/alsa-devel/2011-August/042923.html

Regards,
Peter

---
Misael Lopez Cruz (1):
  ASoC: omap-mcpdm: Replace legacy driver

Peter Ujfalusi (2):
  ASoC: DAPM: Add private data pointer for DAPM widget
  ASoC: soc-dapm: API to attach DAPM_SUPPLY to be used for dai

 include/sound/soc-dapm.h    |   18 +
 sound/soc/omap/Makefile     |    2 +-
 sound/soc/omap/mcpdm.c      |  474 -------------------------
 sound/soc/omap/mcpdm.h      |  152 --------
 sound/soc/omap/omap-mcpdm.c |  813 ++++++++++++++++++++++++++++---------------
 sound/soc/omap/omap-mcpdm.h |   97 +++++
 sound/soc/omap/sdp4430.c    |   14 +-
 sound/soc/soc-dapm.c        |   27 ++
 8 files changed, 690 insertions(+), 907 deletions(-)
 delete mode 100644 sound/soc/omap/mcpdm.c
 delete mode 100644 sound/soc/omap/mcpdm.h
 rewrite sound/soc/omap/omap-mcpdm.c (46%)
 create mode 100644 sound/soc/omap/omap-mcpdm.h

-- 
1.7.6.1
