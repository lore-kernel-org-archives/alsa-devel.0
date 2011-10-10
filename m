From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v2 0/9] ASoC: OMAP machine driver cleanups
Date: Mon, 10 Oct 2011 15:34:07 +0300
Message-ID: <1318250056-26437-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog105.obsmtp.com (na3sys009aog105.obsmtp.com
	[74.125.149.75]) by alsa0.perex.cz (Postfix) with ESMTP id C816724516
	for <alsa-devel@alsa-project.org>;
	Mon, 10 Oct 2011 14:34:52 +0200 (CEST)
Received: by mail-yx0-f175.google.com with SMTP id 17so6750963yxj.34
	for <alsa-devel@alsa-project.org>; Mon, 10 Oct 2011 05:34:50 -0700 (PDT)
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

Hello,

Some cleanups for the OMAP ASoC machine drivers:
- do not call soc_dapm_sync from dai_link->init callback since it is useless
- Convert drivers to use table based DAPM initialization
- Remove dapm_enable_pin calls from dai_link->init callback since pins are
  enabled by default

Changelog since v1:
- Do not touch ams-delta just remove the dapm_sync call.
- Do not convert soc_dapm_sync calls to dapm_new_widgets call

Regards,
Peter
---
Peter Ujfalusi (9):
  ASoC: OMAP machines: Remove soc_dapm_sync() call from init
  ASoC: am3517evm: Let core to deal with the DAPM widgets
  ASoC: n810: Let the core to register DAPM widgets/routes and controls
  ASoC: osk5912: Let core to deal with the DAPM widgets
  ASoC: sdp3430: Let core to deal with the DAPM widgets
  ASoC: zoom2: Let core to deal with the DAPM widgets
  ASoC: zoom2: No need to call dapm_pin_enable at init time
  ASoC: sdp4430: Let core to deal with the DAPM widgets
  ASoC: sdp4430: No need to call dapm_pin_enable at init time

 sound/soc/omap/am3517evm.c    |   28 +++++-----------------------
 sound/soc/omap/ams-delta.c    |    1 -
 sound/soc/omap/n810.c         |   23 +++++++----------------
 sound/soc/omap/omap3pandora.c |    8 ++------
 sound/soc/omap/osk5912.c      |   27 +++++----------------------
 sound/soc/omap/rx51.c         |    2 --
 sound/soc/omap/sdp3430.c      |   18 +++++-------------
 sound/soc/omap/sdp4430.c      |   27 +++++----------------------
 sound/soc/omap/zoom2.c        |   26 ++++++--------------------
 9 files changed, 35 insertions(+), 125 deletions(-)

-- 
1.7.7
