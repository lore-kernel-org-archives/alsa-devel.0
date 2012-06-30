From: Fabio Estevam <festevam@gmail.com>
Subject: [PATCH] ASoC: soc-dapm: Use ASYNC_DOMAIN_EXCLUSIVE
Date: Sat, 30 Jun 2012 16:39:35 -0300
Message-ID: <1341085175-20599-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yw0-f50.google.com (mail-yw0-f50.google.com
	[209.85.213.50]) by alsa0.perex.cz (Postfix) with ESMTP id D991B24563
	for <alsa-devel@alsa-project.org>;
	Sat, 30 Jun 2012 21:39:46 +0200 (CEST)
Received: by yhjj63 with SMTP id j63so4562793yhj.23
	for <alsa-devel@alsa-project.org>; Sat, 30 Jun 2012 12:39:43 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: broonie@opensource.wolfsonmicro.com
Cc: Fabio Estevam <fabio.estevam@freescale.com>, dan.j.williams@intel.com, lrg@ti.com, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

From: Fabio Estevam <fabio.estevam@freescale.com>

commit e895407d (async: introduce 'async_domain' type)
changed the parameter types of async_schedule_domain() and async_synchronize_full_domain().

Use ASYNC_DOMAIN_EXCLUSIVE and fix the following build warnings:

sound/soc/soc-dapm.c:1646:6: warning: passing argument 3 of 'async_schedule_domain' from incompatible pointer type
sound/soc/soc-dapm.c:1647:2: warning: passing argument 1 of 'async_synchronize_full_domain' from incompatible pointer type
sound/soc/soc-dapm.c:1660:6: warning: passing argument 3 of 'async_schedule_domain' from incompatible pointer type
sound/soc/soc-dapm.c:1661:2: warning: passing argument 1 of 'async_synchronize_full_domain' from incompatible pointer type

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
Build tested only.

 sound/soc/soc-dapm.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 9670668..c93e832 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -1572,7 +1572,7 @@ static int dapm_power_widgets(struct snd_soc_dapm_context *dapm, int event)
 	struct snd_soc_dapm_context *d;
 	LIST_HEAD(up_list);
 	LIST_HEAD(down_list);
-	LIST_HEAD(async_domain);
+	ASYNC_DOMAIN_EXCLUSIVE(async_domain);
 	enum snd_soc_bias_level bias;
 
 	trace_snd_soc_dapm_start(card);
-- 
1.7.1
