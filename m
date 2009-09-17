From: Mike Frysinger <vapier@gentoo.org>
Subject: [PATCH 2/5] ASoC: bf5xx-sport: the irq save/restore
	funcs take an unsigned long
Date: Wed, 16 Sep 2009 20:25:09 -0400
Message-ID: <1253147112-5801-2-git-send-email-vapier@gentoo.org>
References: <1253147112-5801-1-git-send-email-vapier@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.gentoo.org (smtp.gentoo.org [140.211.166.183])
	by alsa0.perex.cz (Postfix) with ESMTP id 8D9801038FC
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
Cc: uclinux-dist-devel@blackfin.uclinux.org
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Mike Frysinger <vapier@gentoo.org>
---
 sound/soc/blackfin/bf5xx-sport.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/soc/blackfin/bf5xx-sport.c b/sound/soc/blackfin/bf5xx-sport.c
index 469ce7f..99051ff 100644
--- a/sound/soc/blackfin/bf5xx-sport.c
+++ b/sound/soc/blackfin/bf5xx-sport.c
@@ -326,7 +326,7 @@ static inline int sport_hook_tx_dummy(struct sport_device *sport)
 
 int sport_tx_start(struct sport_device *sport)
 {
-	unsigned flags;
+	unsigned long flags;
 	pr_debug("%s: tx_run:%d, rx_run:%d\n", __func__,
 			sport->tx_run, sport->rx_run);
 	if (sport->tx_run)
-- 
1.6.5.rc1
