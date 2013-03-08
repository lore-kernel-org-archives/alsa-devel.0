From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 1/2] ASoC: Drop unused "dapm" field form
	soc_enum struct
Date: Fri,  8 Mar 2013 13:44:26 +0100
Message-ID: <1362746667-8919-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-057.synserver.de (smtp-out-064.synserver.de
 [212.40.185.64])
 by alsa0.perex.cz (Postfix) with ESMTP id 8A9A226170F
 for <alsa-devel@alsa-project.org>; Fri,  8 Mar 2013 13:42:42 +0100 (CET)
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

This field was added in commit 2e72f8e ("ASoC: New enum type: value_enum"), but
has never been used since. Considering that the soc_enum struct is usually
shared between all instances of a CODEC, it also doesn't make much sense to have
a pointer to DAPM specific data in it.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 include/sound/soc.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index a6a059c..c84062b 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -1086,7 +1086,6 @@ struct soc_enum {
 	unsigned int mask;
 	const char * const *texts;
 	const unsigned int *values;
-	void *dapm;
 };
 
 /* codec IO */
-- 
1.8.0
