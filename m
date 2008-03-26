From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] soc - Include register in DAPM debug output
Date: Wed, 26 Mar 2008 16:12:19 +0000
Message-ID: <1206547939-22264-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 5C679245CE
	for <alsa-devel@alsa-project.org>; Wed, 26 Mar 2008 17:12:21 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

When logging register changes in DAPM debug output include the register
number.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/soc-dapm.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index abac684..e0637d8 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -226,7 +226,7 @@ static int dapm_update_bits(struct snd_soc_dapm_widget *widget)
 		snd_soc_write(codec, widget->reg, new);
 		pop_wait(POP_TIME);
 	}
-	dbg("reg old %x new %x change %d\n", old, new, change);
+	dbg("reg %x old %x new %x change %d\n", widget->reg, old, new, change);
 	return change;
 }
 
-- 
1.5.4.4
