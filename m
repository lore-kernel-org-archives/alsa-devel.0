From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v2 0/4] ASoC: twl6040: Gain ramp code cleanups
Date: Wed, 28 Sep 2011 14:16:29 +0300
Message-ID: <1317208593-21142-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog106.obsmtp.com (na3sys009aob106.obsmtp.com
	[74.125.149.76]) by alsa0.perex.cz (Postfix) with ESMTP id 3FCB12433C
	for <alsa-devel@alsa-project.org>;
	Wed, 28 Sep 2011 13:17:04 +0200 (CEST)
Received: by mail-bw0-f49.google.com with SMTP id t2so9486840bka.36
	for <alsa-devel@alsa-project.org>; Wed, 28 Sep 2011 04:17:03 -0700 (PDT)
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

Changes since v1:
- Loop counters cleaned, commented in patch 2
- Use cancel_delayed_work_sync to make sure that we do not have pending work,
  or executing work when modifying the variables used by the ramp code.
- patches already taken left out.

Intro from v1:

the following series cleans up the gain ramp code found in the twl6040 codec
driver.
Main changes:
- use one workqueue for the twl6040 codec driver (instead of the original 3)
- Delays between the steps does not need to be different among the range.
  I assume, that the original code contained copy-paste snippets from wm8350
  for this part
- Cleanups for the DAPM_OUT_DRV_E event handler code.
- delayed_works moved within their corresponding struct.

The series has been generated on top of:
git://opensource.wolfsonmicro.com/linux-2.6-asoc,
for-3.2 branch + ASoC: omap-mcpdm/twl6040: Offset cancellation series.

Side note: I have done this to better understand (while cleaning up the
twl6040 driver) the requirements for the ramp code, and to study the
possibility of adding support in the core for this (to handle the wm8350, and
twl6040 in a generic way later).
I'm still looking at the optimal implementation without ending up with too
complicated code/structures...

Regards,
Peter
---
Peter Ujfalusi (4):
  ASoC: twl6040: One workqueue should be enough
  ASoC: twl6040: correct loop counters for HS/HF ramp code
  ASoC: twl6040: Shift 2 identifies the HS output in out_drv_event
  ASoC: twl6040: Simplify code in out_drv_event for pending work check

 sound/soc/codecs/twl6040.c |   68 +++++++++++++------------------------------
 1 files changed, 21 insertions(+), 47 deletions(-)

-- 
1.7.6.1
