From: Fabio Estevam <festevam@gmail.com>
Subject: [PATCH] ASoC: atmel: ac97c: Remove unused variable
Date: Thu,  2 Apr 2015 09:42:06 -0300
Message-ID: <1427978526-17604-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qc0-f178.google.com (mail-qc0-f178.google.com
 [209.85.216.178])
 by alsa0.perex.cz (Postfix) with ESMTP id AB23F2604CA
 for <alsa-devel@alsa-project.org>; Thu,  2 Apr 2015 14:42:43 +0200 (CEST)
Received: by qcgx3 with SMTP id x3so65799194qcg.3
 for <alsa-devel@alsa-project.org>; Thu, 02 Apr 2015 05:42:40 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de
Cc: alexanders83@web.de, Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

From: Fabio Estevam <fabio.estevam@freescale.com>

Remove the unused 'match' variable to fix the following build warning:

sound/atmel/ac97c.c:919:29: warning: unused variable 'match' [-Wunused-variable]

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 sound/atmel/ac97c.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/atmel/ac97c.c b/sound/atmel/ac97c.c
index cf4cedf..6dad042 100644
--- a/sound/atmel/ac97c.c
+++ b/sound/atmel/ac97c.c
@@ -916,7 +916,6 @@ static struct ac97c_platform_data *atmel_ac97c_probe_dt(struct device *dev)
 {
 	struct ac97c_platform_data *pdata;
 	struct device_node *node = dev->of_node;
-	const struct of_device_id *match;
 
 	if (!node) {
 		dev_err(dev, "Device does not have associated DT data\n");
-- 
1.9.1
