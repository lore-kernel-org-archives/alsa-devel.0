From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 00/17] ASoC: twl6040: Cleanups and fixes
Date: Thu, 15 Sep 2011 15:39:22 +0300
Message-ID: <1316090379-30760-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog111.obsmtp.com (na3sys009aog111.obsmtp.com
	[74.125.149.205])
	by alsa0.perex.cz (Postfix) with ESMTP id 08411103819
	for <alsa-devel@alsa-project.org>;
	Thu, 15 Sep 2011 14:40:08 +0200 (CEST)
Received: by mail-bw0-f47.google.com with SMTP id 11so2675195bke.20
	for <alsa-devel@alsa-project.org>; Thu, 15 Sep 2011 05:40:07 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Samuel Ortiz <samuel.ortiz@intel.com>, Dmitry Torokhov <dtor@mail.ru>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Misael Lopez Cruz <misael.lopez@ti.com>
List-Id: alsa-devel@alsa-project.org

Hello,

The first four patch of this series (the MFD/Input patches) has been already
sent to upstream to the relevant lists, but I wanted to include here as well,
since I have dependency on that series later on.
If it is OK with you, it would be best to merge these MFD/Input changes through
the audio tree for 3.2.

Code cleanup, and fixes for the twl6040 codec driver.
Main changes:
- reg_cache has been rested to chip defaults
- codec initialization changes
- Correction for the Earphone path
- AUX L/R output support
- Headset/Handsfree control name changes
- Headset DC offset workaround

Regards,
Peter

I have excluded the linux-input list (but kept Dmitry) - to not spam them.

---
Peter Ujfalusi (17):
  MFD: twl6040: Remove global pointer for platform_device
  MFD: twl6040: Add accessor for revision ID
  Input: twl6040-vibra: Use accessor to get revision information
  MFD: twl6040: Fix power on GPIO handling
  ASoC: twl6040: Chip initialization cleanup
  ASoC: twl6040: Use chip defaults in the initial reg_cache
  ASoC: twl6040: Lower the initial gains
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
  ASoC: twl6040: Workaround for headset DC offset caused pop noise

 drivers/input/misc/twl6040-vibra.c |    2 +-
 drivers/mfd/twl6040-core.c         |   38 ++--
 include/linux/mfd/twl6040.h        |   22 +--
 sound/soc/codecs/twl6040.c         |  367 +++++++++++++++++++-----------------
 sound/soc/omap/sdp4430.c           |    2 +-
 5 files changed, 218 insertions(+), 213 deletions(-)

-- 
1.7.6.1
