From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 3/3] ASoC: Remove unused sysfs_registered field
	from snd_soc_codec struct
Date: Sat, 31 Aug 2013 11:02:19 +0200
Message-ID: <1377939739-14246-3-git-send-email-lars@metafoo.de>
References: <1377939739-14246-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-153.synserver.de (smtp-out-153.synserver.de
 [212.40.185.153])
 by alsa0.perex.cz (Postfix) with ESMTP id D384A2619EF
 for <alsa-devel@alsa-project.org>; Sat, 31 Aug 2013 11:00:53 +0200 (CEST)
In-Reply-To: <1377939739-14246-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

The sysfs_registered field was added to the snd_soc_codec struct in commit
f0fba2ad ("ASoC: multi-component - ASoC Multi-Component Support"), but has never
been used.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 include/sound/soc.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index 79b305d..7184805 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -697,7 +697,6 @@ struct snd_soc_codec {
 	unsigned int probed:1; /* Codec has been probed */
 	unsigned int ac97_registered:1; /* Codec has been AC97 registered */
 	unsigned int ac97_created:1; /* Codec has been created by SoC */
-	unsigned int sysfs_registered:1; /* codec has been sysfs registered */
 	unsigned int cache_init:1; /* codec cache has been initialized */
 	unsigned int using_regmap:1; /* using regmap access */
 	u32 cache_only;  /* Suppress writes to hardware */
-- 
1.8.0
