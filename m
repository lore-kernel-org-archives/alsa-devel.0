From: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: arizona: Fix typo - Swap value in
	48k_rates[] and 44k1_rates[]
Date: Thu, 15 Nov 2012 11:41:30 +0000
Message-ID: <1352979690-25117-1-git-send-email-dp@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id DD1C02615DF
 for <alsa-devel@alsa-project.org>; Thu, 15 Nov 2012 12:43:23 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/arizona.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/arizona.c b/sound/soc/codecs/arizona.c
index c03b65a..054967d 100644
--- a/sound/soc/codecs/arizona.c
+++ b/sound/soc/codecs/arizona.c
@@ -268,7 +268,7 @@ EXPORT_SYMBOL_GPL(arizona_out_ev);
 static unsigned int arizona_sysclk_48k_rates[] = {
 	6144000,
 	12288000,
-	22579200,
+	24576000,
 	49152000,
 	73728000,
 	98304000,
@@ -278,7 +278,7 @@ static unsigned int arizona_sysclk_48k_rates[] = {
 static unsigned int arizona_sysclk_44k1_rates[] = {
 	5644800,
 	11289600,
-	24576000,
+	22579200,
 	45158400,
 	67737600,
 	90316800,
-- 
1.8.0
