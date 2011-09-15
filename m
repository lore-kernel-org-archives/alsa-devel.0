From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 03/17] Input: twl6040-vibra: Use accessor to
	get revision information
Date: Thu, 15 Sep 2011 15:39:25 +0300
Message-ID: <1316090379-30760-4-git-send-email-peter.ujfalusi@ti.com>
References: <1316090379-30760-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog104.obsmtp.com (na3sys009aog104.obsmtp.com
	[74.125.149.73])
	by alsa0.perex.cz (Postfix) with ESMTP id 18C26103B64
	for <alsa-devel@alsa-project.org>;
	Thu, 15 Sep 2011 14:40:16 +0200 (CEST)
Received: by bkbzu17 with SMTP id zu17so2406997bkb.38
	for <alsa-devel@alsa-project.org>; Thu, 15 Sep 2011 05:40:14 -0700 (PDT)
In-Reply-To: <1316090379-30760-1-git-send-email-peter.ujfalusi@ti.com>
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

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Acked-by: Dmitry Torokhov <dtor@mail.ru>
---
 drivers/input/misc/twl6040-vibra.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/input/misc/twl6040-vibra.c b/drivers/input/misc/twl6040-vibra.c
index c43002e..154b7a3 100644
--- a/drivers/input/misc/twl6040-vibra.c
+++ b/drivers/input/misc/twl6040-vibra.c
@@ -97,7 +97,7 @@ static void twl6040_vibra_enable(struct vibra_info *info)
 	}
 
 	twl6040_power(info->twl6040, 1);
-	if (twl6040->rev <= TWL6040_REV_ES1_1) {
+	if (twl6040_get_revid(twl6040) <= TWL6040_REV_ES1_1) {
 		/*
 		 * ERRATA: Disable overcurrent protection for at least
 		 * 3ms when enabling vibrator drivers to avoid false
-- 
1.7.6.1
