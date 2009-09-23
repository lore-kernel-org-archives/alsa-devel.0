From: Mike Frysinger <vapier@gentoo.org>
Subject: [PATCH 2/2] ASoC: Blackfin: fix inverted handling of
	SPORT0 on PORT F/G
Date: Wed, 23 Sep 2009 11:51:05 -0400
Message-ID: <1253721065-2785-2-git-send-email-vapier@gentoo.org>
References: <1253721065-2785-1-git-send-email-vapier@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.gentoo.org (smtp.gentoo.org [140.211.166.183])
	by alsa0.perex.cz (Postfix) with ESMTP id D323810388B
	for <alsa-devel@alsa-project.org>;
	Wed, 23 Sep 2009 17:51:08 +0200 (CEST)
In-Reply-To: <1253721065-2785-1-git-send-email-vapier@gentoo.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: uclinux-dist-devel@blackfin.uclinux.org, Cliff Cai <cliff.cai@analog.com>, Barry Song <barry.song@analog.com>
List-Id: alsa-devel@alsa-project.org

From: Cliff Cai <cliff.cai@analog.com>

Signed-off-by: Cliff Cai <cliff.cai@analog.com>
Signed-off-by: Barry Song <barry.song@analog.com>
Signed-off-by: Mike Frysinger <vapier@gentoo.org>
---
 sound/soc/blackfin/bf5xx-i2s.c |    8 ++++----
 sound/soc/blackfin/bf5xx-tdm.c |    8 ++++----
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/sound/soc/blackfin/bf5xx-i2s.c b/sound/soc/blackfin/bf5xx-i2s.c
index 66e7333..43feac5 100644
--- a/sound/soc/blackfin/bf5xx-i2s.c
+++ b/sound/soc/blackfin/bf5xx-i2s.c
@@ -76,12 +76,12 @@ static struct sport_param sport_params[2] = {
  * TFS. When Port G is selected and EMAC then there is a conflict between
  * the PHY interrupt line and TFS.  Current settings prevent the conflict
  * by ignoring the TFS pin when Port G is selected. This allows both
- * ssm2602 using Port G and EMAC concurrently.
+ * codecs and EMAC using Port G concurrently.
  */
-#ifdef CONFIG_BF527_SPORT0_PORTF
-#define LOCAL_SPORT0_TFS (P_SPORT0_TFS)
-#else
+#ifdef CONFIG_BF527_SPORT0_PORTG
 #define LOCAL_SPORT0_TFS (0)
+#else
+#define LOCAL_SPORT0_TFS (P_SPORT0_TFS)
 #endif
 
 static u16 sport_req[][7] = { {P_SPORT0_DTPRI, P_SPORT0_TSCLK, P_SPORT0_RFS,
diff --git a/sound/soc/blackfin/bf5xx-tdm.c b/sound/soc/blackfin/bf5xx-tdm.c
index 3096bad..ff546e9 100644
--- a/sound/soc/blackfin/bf5xx-tdm.c
+++ b/sound/soc/blackfin/bf5xx-tdm.c
@@ -78,12 +78,12 @@ static struct sport_param sport_params[2] = {
  * TFS. When Port G is selected and EMAC then there is a conflict between
  * the PHY interrupt line and TFS.  Current settings prevent the conflict
  * by ignoring the TFS pin when Port G is selected. This allows both
- * ssm2602 using Port G and EMAC concurrently.
+ * codecs and EMAC using Port G concurrently.
  */
-#ifdef CONFIG_BF527_SPORT0_PORTF
-#define LOCAL_SPORT0_TFS (P_SPORT0_TFS)
-#else
+#ifdef CONFIG_BF527_SPORT0_PORTG
 #define LOCAL_SPORT0_TFS (0)
+#else
+#define LOCAL_SPORT0_TFS (P_SPORT0_TFS)
 #endif
 
 static u16 sport_req[][7] = { {P_SPORT0_DTPRI, P_SPORT0_TSCLK, P_SPORT0_RFS,
-- 
1.6.5.rc1
