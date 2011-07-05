From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v3 0/5] MFD/input/ASoC: twl6040: irq
	registration changes
Date: Tue, 5 Jul 2011 22:49:31 +0300
Message-ID: <1309895376-17446-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from devils.ext.ti.com (devils.ext.ti.com [198.47.26.153])
	by alsa0.perex.cz (Postfix) with ESMTP id 847D310384A
	for <alsa-devel@alsa-project.org>;
	Tue,  5 Jul 2011 21:49:47 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>, Tony Lindgren <tony@atomide.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Samuel Ortiz <sameo@linux.intel.com>, Dmitry Torokhov <dmitry.torokhov@>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Felipe Balbi <balbi@ti.com>, Misael Lopez Cruz <misael.lopez@ti.com>
List-Id: alsa-devel@alsa-project.org

Hello,

Changes since v2:
- Fix the check in the slaves driver for the validity of the received irq
- Mark Brown's ack added to patch 3

Intro mail froim v1:
As Samuel, and Felipe requested for the twl6040 MFD series:
http://marc.info/?l=linux-kernel&m=130978512225430&w=2
http://marc.info/?l=linux-omap&m=130978403224218&w=2

This is the update to remove the obfuscation around the threaded irq request
in the twl6040 driver and it's slaves.

With this change the slaves uses directly the threaded irq request, and the
core driver passes the irq number for the slaves to use (configured runtime, so
machine drivers do not need to be updated).

Regards,
Peter

PS: for the remaining comments from Samuel I have changed the series, since the
requested change was small.
I'm not intended to send the series again, unless it is requested (again the
change from v6 is minimal - few lines has been removed/replaced).

---
Peter Ujfalusi (5):
  MFD: twl6040: Use resource to provide irq number for slaves
  input: twl6040-vibra: Do not use wrapper for irq request
  ASoC: twl6040: Do not use wrapper for irq request
  MFD: twl6040: Demand valid interrupt configuration
  MFD: twl6040: Remove wrapper for threaded irq request

 drivers/input/misc/twl6040-vibra.c |   17 ++++++---
 drivers/mfd/twl6040-core.c         |   69 ++++++++++++++++++++++++-----------
 drivers/mfd/twl6040-irq.c          |   16 +--------
 include/linux/mfd/twl6040.h        |   22 -----------
 sound/soc/codecs/twl6040.c         |   19 +++++++---
 5 files changed, 74 insertions(+), 69 deletions(-)

-- 
1.7.6
