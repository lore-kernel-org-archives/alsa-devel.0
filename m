From: Brian Austin <brian.austin@cirrus.com>
Subject: [PATCH 2/3] ASoC: cs42l73: Remove Chip ID's from
	reg_default
Date: Wed, 9 May 2012 12:14:03 -0500
Message-ID: <1336583644-12349-2-git-send-email-brian.austin@cirrus.com>
References: <1336583644-12349-1-git-send-email-brian.austin@cirrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from am1outboundpool.messaging.microsoft.com
	(am1ehsobe002.messaging.microsoft.com [213.199.154.205])
	by alsa0.perex.cz (Postfix) with ESMTP id 2C4DA1046E5
	for <alsa-devel@alsa-project.org>;
	Wed,  9 May 2012 19:17:05 +0200 (CEST)
In-Reply-To: <1336583644-12349-1-git-send-email-brian.austin@cirrus.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Brian Austin <brian.austin@cirrus.com>, broonie@opensource.wolfsonmicro.com, lrg@ti.com
List-Id: alsa-devel@alsa-project.org

We need to read the real register values

Signed-off-by: Brian Austin <brian.austin@cirrus.com>
---
 sound/soc/codecs/cs42l73.c |    3 ---
 1 file changed, 3 deletions(-)

diff --git a/sound/soc/codecs/cs42l73.c b/sound/soc/codecs/cs42l73.c
index 60b7f53..1cf2206 100644
--- a/sound/soc/codecs/cs42l73.c
+++ b/sound/soc/codecs/cs42l73.c
@@ -43,9 +43,6 @@ struct  cs42l73_private {
 };
 
 static const struct reg_default cs42l73_reg_defaults[] = {
-	{ 1, 0x42 },	/* r01	- Device ID A&B */
-	{ 2, 0xA7 },	/* r02	- Device ID C&D */
-	{ 3, 0x30 },	/* r03	- Device ID E */
 	{ 6, 0xF1 },	/* r06	- Power Ctl 1 */
 	{ 7, 0xDF },	/* r07	- Power Ctl 2 */
 	{ 8, 0x3F },	/* r08	- Power Ctl 3 */
-- 
1.7.10
