From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 0/4] ASoC: omap-mcpdm/twl6040: Offset
	cancellation
Date: Thu, 15 Sep 2011 15:45:14 +0300
Message-ID: <1316090718-30822-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog124.obsmtp.com (na3sys009aog124.obsmtp.com
	[74.125.149.151])
	by alsa0.perex.cz (Postfix) with ESMTP id 15757103B57
	for <alsa-devel@alsa-project.org>;
	Thu, 15 Sep 2011 14:45:52 +0200 (CEST)
Received: by mail-bw0-f50.google.com with SMTP id zt19so2901256bkb.37
	for <alsa-devel@alsa-project.org>; Thu, 15 Sep 2011 05:45:44 -0700 (PDT)
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

The following series adds support for the McPDM offset cancellation feature.
It provides the needed functionality to:
- read the HSTRIM values from the twl6040 codec
- configure the offset cancellation registers in OMAP-McPDM

Regards,
Peter
---
Peter Ujfalusi (4):
  ASoC: twl6040: Read the TRIM values from the chip
  ASoC: twl6040: Function to fetch the TRIM values
  ASoC: omap-mcpdm: API to configure offset cancellation
  ASoC: sdp4430: Configure McPDM offset cancellation

 sound/soc/codecs/twl6040.c  |   16 ++++++++++++++++
 sound/soc/codecs/twl6040.h  |   13 +++++++++++++
 sound/soc/omap/omap-mcpdm.c |   25 +++++++++++++++++++++++++
 sound/soc/omap/omap-mcpdm.h |   12 ++++++++++++
 sound/soc/omap/sdp4430.c    |   10 +++++++++-
 5 files changed, 75 insertions(+), 1 deletions(-)

-- 
1.7.6.1
