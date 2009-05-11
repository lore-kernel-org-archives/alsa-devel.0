From: Mike Rapoport <mike@compulab.co.il>
Subject: [PATCH] pxa2xx-ac97: fix reset gpio mode setting
Date: Mon, 11 May 2009 13:11:38 +0300
Message-ID: <1242036698-29136-1-git-send-email-mike@compulab.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cathcart.site5.com (cathcart.site5.com [74.54.107.137])
	by alsa0.perex.cz (Postfix) with ESMTP id 04DDA2475B
	for <alsa-devel@alsa-project.org>;
	Mon, 11 May 2009 12:11:43 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: eric.miao@marvell.com
Cc: alsa-devel@alsa-project.org, linux-arm-kernel@lists.arm.linux.org.uk, Mike Rapoport <mike@compulab.co.il>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Mike Rapoport <mike@compulab.co.il>
---
 sound/arm/pxa2xx-ac97-lib.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/arm/pxa2xx-ac97-lib.c b/sound/arm/pxa2xx-ac97-lib.c
index a2c12d1..6fdca97 100644
--- a/sound/arm/pxa2xx-ac97-lib.c
+++ b/sound/arm/pxa2xx-ac97-lib.c
@@ -65,7 +65,7 @@ static void set_resetgpio_mode(int resetgpio_action)
 		switch (resetgpio_action) {
 		case RESETGPIO_NORMAL_ALTFUNC:
 			if (reset_gpio == 113)
-				mode = 113 | GPIO_OUT | GPIO_DFLT_LOW;
+				mode = 113 | GPIO_ALT_FN_2_OUT;
 			if (reset_gpio == 95)
 				mode = 95 | GPIO_ALT_FN_1_OUT;
 			break;
-- 
1.5.6.4
