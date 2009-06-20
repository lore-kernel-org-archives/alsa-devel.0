From: Mike Frysinger <vapier@gentoo.org>
Subject: [PATCH] ASoC: Blackfin: update the bf5xx_i2s_resume
	parameters
Date: Sat, 20 Jun 2009 11:29:57 -0400
Message-ID: <1245511797-19460-2-git-send-email-vapier@gentoo.org>
References: <1245511797-19460-1-git-send-email-vapier@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.gentoo.org (smtp.gentoo.org [140.211.166.183])
	by alsa0.perex.cz (Postfix) with ESMTP id 50DB624478
	for <alsa-devel@alsa-project.org>;
	Sat, 20 Jun 2009 17:30:11 +0200 (CEST)
In-Reply-To: <1245511797-19460-1-git-send-email-vapier@gentoo.org>
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
Cc: uclinux-dist-devel@blackfin.uclinux.org, Barry Song <barry.song@analog.com>
List-Id: alsa-devel@alsa-project.org

From: Barry Song <barry.song@analog.com>

Latest ASoC only passes snd_soc_dai to the resume function.

Signed-off-by: Barry Song <barry.song@analog.com>
Signed-off-by: Mike Frysinger <vapier@gentoo.org>
---
 sound/soc/blackfin/bf5xx-i2s.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/sound/soc/blackfin/bf5xx-i2s.c b/sound/soc/blackfin/bf5xx-i2s.c
index 0e8af48..af06904 100644
--- a/sound/soc/blackfin/bf5xx-i2s.c
+++ b/sound/soc/blackfin/bf5xx-i2s.c
@@ -249,8 +249,7 @@ static int bf5xx_i2s_suspend(struct snd_soc_dai *dai)
 	return 0;
 }
 
-static int bf5xx_i2s_resume(struct platform_device *pdev,
-			    struct snd_soc_dai *dai)
+static int bf5xx_i2s_resume(struct snd_soc_dai *dai)
 {
 	int ret;
 	struct sport_device *sport =
-- 
1.6.3.1
