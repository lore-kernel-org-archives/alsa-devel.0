From: Fabio Estevam <festevam@gmail.com>
Subject: [PATCH] ASoC: soc-core: Remove unused 'ret' variable
Date: Sat, 22 Dec 2012 10:38:14 -0200
Message-ID: <1356179894-8489-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ye0-f176.google.com (mail-ye0-f176.google.com
 [209.85.213.176])
 by alsa0.perex.cz (Postfix) with ESMTP id D92712615B6
 for <alsa-devel@alsa-project.org>; Sat, 22 Dec 2012 13:38:25 +0100 (CET)
Received: by mail-ye0-f176.google.com with SMTP id m1so1072637yen.35
 for <alsa-devel@alsa-project.org>; Sat, 22 Dec 2012 04:38:25 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@opensource.wolfsonmicro.com
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

From: Fabio Estevam <fabio.estevam@freescale.com>

commit 9bde4f0b1c (ASoC: core: Fix SOC_DOUBLE_RANGE() macros) introduced
the following build warning:

sound/soc/soc-core.c:2999:6: warning: unused variable 'ret' [-Wunused-variable]

Remove the unused 'ret' variable.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 sound/soc/soc-core.c |    1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index e0d4630..29046e7 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -2996,7 +2996,6 @@ int snd_soc_get_volsw_range(struct snd_kcontrol *kcontrol,
 	int max = mc->max;
 	unsigned int mask = (1 << fls(max)) - 1;
 	unsigned int invert = mc->invert;
-	int ret;
 
 	ucontrol->value.integer.value[0] =
 		(snd_soc_read(codec, reg) >> shift) & mask;
-- 
1.7.9.5
