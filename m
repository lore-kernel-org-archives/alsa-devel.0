From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v2 00/10] ASoC: twl6040: Cleanups and fixes
Date: Thu, 22 Sep 2011 11:05:44 +0300
Message-ID: <1316678754-11935-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog109.obsmtp.com (na3sys009aog109.obsmtp.com
	[74.125.149.201])
	by alsa0.perex.cz (Postfix) with ESMTP id E3254103883
	for <alsa-devel@alsa-project.org>;
	Thu, 22 Sep 2011 10:06:23 +0200 (CEST)
Received: by mail-bw0-f53.google.com with SMTP id zt12so2728618bkb.26
	for <alsa-devel@alsa-project.org>; Thu, 22 Sep 2011 01:06:22 -0700 (PDT)
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

Changes since v1 [1]:
- Left out patches already applied by Mark
- Description on patch 01 changed to describe more precisely the need to lower
  the chip default gains after power on.
- Extended the commit message for patch 02 to explain the change.
- Added Acked-by from Liam to the patches.

Short summary for v2 series:
Code cleanup, and fixes for the twl6040 codec driver.
Main changes:
- codec initialization changes
- Correction for the Earphone path
- AUX L/R output support
- Headset/Handsfree control name changes
- Headset DC offset workaround

The series has been created on top of:
git://opensource.wolfsonmicro.com/linux-2.6-asoc
for-3.2 branch + OMAP McPDM changes [2]

[1] first series:
http://mailman.alsa-project.org/pipermail/alsa-devel/2011-September/043847.html

[2] OMAP McPDM changes:
http://mailman.alsa-project.org/pipermail/alsa-devel/2011-September/044172.html

Regards,
Peter
---
Peter Ujfalusi (10):
  ASoC: twl6040: Lower the power on gain values at startup
  ASoC: twl6040: Fix comments for register names
  ASoC: twl6040: Remove strings "NULL" from DAPM route
  ASoC: twl6040: Introduce SW only shadow register
  ASoC: twl6040: Earphone path correction
  ASoC: twl6040: Use consistent names for Handsfree path
  ASoC: twl6040: Use consistent names for Headset path
  ASoC: twl6040: Support for AUX L/R output
  ASoC: twl6040/sdp4430: Change legacy DAI name
  ASoC/MFD: twl6040: Combine bit definitions for Headset control
    registers

 include/linux/mfd/twl6040.h |   13 +--
 sound/soc/codecs/twl6040.c  |  223 ++++++++++++++++++++++++++-----------------
 sound/soc/omap/sdp4430.c    |    2 +-
 3 files changed, 140 insertions(+), 98 deletions(-)

-- 
1.7.6.1
