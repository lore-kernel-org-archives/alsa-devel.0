From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 0/6] ASoC/MFD: twl6040: PLL handling changes
Date: Mon, 4 Jul 2011 13:05:52 +0300
Message-ID: <1309773958-14608-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from devils.ext.ti.com (devils.ext.ti.com [198.47.26.153])
	by alsa0.perex.cz (Postfix) with ESMTP id 1D5B51037FC
	for <alsa-devel@alsa-project.org>;
	Mon,  4 Jul 2011 12:05:57 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>, Tony Lindgren <tony@atomide.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Samuel Ortiz <sameo@linux.intel.com>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Misael Lopez Cruz <misael.lopez@ti.com>
List-Id: alsa-devel@alsa-project.org

Hello,

The following series depends on the v6 of twl6040 MFD series.

The aim is to simplify the PLL handling for twl6040:
- Move the PLL selection control to the codec driver from machine driver
- Sample rate constraint simplification for selected PLL
- Avoid multiple, duplicated PLL configuration, which can slow down the audio
  startup.
- Harmonize the PLL ID usage among the drivers, so we avoid redundancy.

I have generated this series on top of l-o/devel-cleanup branch + my previous
twl6040 MFD/Input/ASoC v6 series, since it depends on the changes introduced
there.
Is it OK, if Tony will be taking this as well to avoid cross tree merge issues?
I can put the series on top of my previous series, and offer Tony a pull link.

Regards,
Peter

---
Peter Ujfalusi (6):
  ASoC: twl6040: Use neutral name for power mode text/enum
  ASoC: twl6040: Move PLL selection to codec driver
  ASoC: twl6040: Simplify sample rate constraint handling
  ASoC: twl6040: Configure PLL only once
  MFD: twl6040: Remove enum for PLL tracking
  ASoC: twl6040: No need to convert the PLL ID

 drivers/mfd/twl6040-core.c  |   26 +++---
 include/linux/mfd/twl6040.h |   17 ++---
 sound/soc/codecs/twl6040.c  |  182 ++++++++++++++++++++++---------------------
 sound/soc/codecs/twl6040.h  |    1 +
 sound/soc/omap/sdp4430.c    |   47 +----------
 5 files changed, 118 insertions(+), 155 deletions(-)

-- 
1.7.6
