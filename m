From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 01/11] ASoC: Remove unused 'reg2' field from
	soc_enum struct
Date: Sun, 23 Feb 2014 16:10:11 +0100
Message-ID: <1393168221-23018-2-git-send-email-lars@metafoo.de>
References: <1393168221-23018-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-167.synserver.de (smtp-out-249.synserver.de
 [212.40.185.249])
 by alsa0.perex.cz (Postfix) with ESMTP id ECDF726513D
 for <alsa-devel@alsa-project.org>; Sun, 23 Feb 2014 16:10:05 +0100 (CET)
In-Reply-To: <1393168221-23018-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, patches@opensource.wolfsonmicro.com, =?UTF-8?q?Philippe=20R=C3=A9tornaz?= <philippe.retornaz@epfl.ch>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, Steffen Trumtrar <s.trumtrar@pengutronix.de>, Jerry Wong <jerry.wong@maximintegrated.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 include/sound/soc.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index d350519..8ffaa46 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -1099,7 +1099,6 @@ struct soc_mreg_control {
 /* enumerated kcontrol */
 struct soc_enum {
 	unsigned short reg;
-	unsigned short reg2;
 	unsigned char shift_l;
 	unsigned char shift_r;
 	unsigned int items;
-- 
1.8.0
