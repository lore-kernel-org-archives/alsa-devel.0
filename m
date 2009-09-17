From: Mike Frysinger <vapier@gentoo.org>
Subject: [PATCH 4/5] ASoC: Blackfin I2S: add lost
	platform_device parameter to resume function
Date: Wed, 16 Sep 2009 20:25:11 -0400
Message-ID: <1253147112-5801-4-git-send-email-vapier@gentoo.org>
References: <1253147112-5801-1-git-send-email-vapier@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.gentoo.org (smtp.gentoo.org [140.211.166.183])
	by alsa0.perex.cz (Postfix) with ESMTP id D227E103904
	for <alsa-devel@alsa-project.org>;
	Thu, 17 Sep 2009 02:25:16 +0200 (CEST)
In-Reply-To: <1253147112-5801-1-git-send-email-vapier@gentoo.org>
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
Cc: uclinux-dist-devel@blackfin.uclinux.org, Barry Song <barry.song@analog.com>
List-Id: alsa-devel@alsa-project.org

From: Barry Song <barry.song@analog.com>

Commit dc7d7b830ee1 trimmed the platform_device parameter from all of the
suspend functions, but it also accidentally removed it from the resume
function in the Blackfin I2S driver.  So restore it.

Signed-off-by: Barry Song <barry.song@analog.com>
Signed-off-by: Mike Frysinger <vapier@gentoo.org>
---
 sound/soc/blackfin/bf5xx-i2s.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/sound/soc/blackfin/bf5xx-i2s.c b/sound/soc/blackfin/bf5xx-i2s.c
index 876abad..19539c6 100644
--- a/sound/soc/blackfin/bf5xx-i2s.c
+++ b/sound/soc/blackfin/bf5xx-i2s.c
@@ -227,7 +227,8 @@ static int bf5xx_i2s_probe(struct platform_device *pdev,
 	return 0;
 }
 
-static void bf5xx_i2s_remove(struct snd_soc_dai *dai)
+static void bf5xx_i2s_remove(struct platform_device *pdev,
+			struct snd_soc_dai *dai)
 {
 	pr_debug("%s enter\n", __func__);
 	peripheral_free_list(&sport_req[sport_num][0]);
-- 
1.6.5.rc1
