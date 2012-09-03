From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH] ASoC: Remove unused 'saved_value' field from
	snd_soc_dapm_widget struct
Date: Mon,  3 Sep 2012 10:34:26 +0200
Message-ID: <1346661266-21894-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-197.synserver.de (smtp-out-197.synserver.de
 [212.40.185.197])
 by alsa0.perex.cz (Postfix) with ESMTP id 4C821264FEC
 for <alsa-devel@alsa-project.org>; Mon,  3 Sep 2012 10:30:02 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

The only user was removed over two years ago in commit a6c65736 ("ASoC: Remove
current PGA control handling").

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 include/sound/soc-dapm.h |    1 -
 1 file changed, 1 deletion(-)

diff --git a/include/sound/soc-dapm.h b/include/sound/soc-dapm.h
index abe373d..0a15537 100644
--- a/include/sound/soc-dapm.h
+++ b/include/sound/soc-dapm.h
@@ -510,7 +510,6 @@ struct snd_soc_dapm_widget {
 	/* dapm control */
 	int reg;				/* negative reg = no direct dapm */
 	unsigned char shift;			/* bits to shift */
-	unsigned int saved_value;		/* widget saved value */
 	unsigned int value;				/* widget current value */
 	unsigned int mask;			/* non-shifted mask */
 	unsigned int on_val;			/* on state value */
-- 
1.7.10.4
