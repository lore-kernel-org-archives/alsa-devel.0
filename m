From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 0/4] ASoC: Do not use core to handle msbits
	constraint for TI drivers
Date: Thu, 19 Jan 2012 19:24:12 +0100
Message-ID: <1326997456-16296-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog109.obsmtp.com (na3sys009aog109.obsmtp.com
	[74.125.149.201])
	by alsa0.perex.cz (Postfix) with ESMTP id 1F1CB24386
	for <alsa-devel@alsa-project.org>; Thu, 19 Jan 2012 19:24:32 +0100 (CET)
Received: by mail-gy0-f182.google.com with SMTP id 10so200514ghy.13
	for <alsa-devel@alsa-project.org>; Thu, 19 Jan 2012 10:24:31 -0800 (PST)
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

The implementation in the core applies the msbits constraint to all sample size.
These codecs, and cpu dai drivers only have msbits constraint when they are
configured with 32 bit sample size.
Apply the msbits constraint in the drivers for 32 bit samples only.

Regards,
Peter
---
Peter Ujfalusi (4):
  Revert "ASoC: tlv320dac33: Use core to set the msbits constraint"
  Revert "ASoC: twl4030: Use core to set the msbits constraint"
  Revert "ASoC: omap-dmic: Use core to set the msbits constraint"
  ASoC: omap-mcpdm: Do not use core to set msbit constraint

 sound/soc/codecs/tlv320dac33.c |    3 ++-
 sound/soc/codecs/twl4030.c     |    7 +++----
 sound/soc/omap/omap-dmic.c     |    7 ++++---
 sound/soc/omap/omap-mcpdm.c    |    4 ++--
 4 files changed, 11 insertions(+), 10 deletions(-)

-- 
1.7.8.3
