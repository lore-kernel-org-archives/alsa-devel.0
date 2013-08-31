From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 2/3] ASoC: Remove unused debugfs_dapm field
	from snd_soc_{platform, codec} struct
Date: Sat, 31 Aug 2013 11:02:18 +0200
Message-ID: <1377939739-14246-2-git-send-email-lars@metafoo.de>
References: <1377939739-14246-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-153.synserver.de (smtp-out-153.synserver.de
 [212.40.185.153])
 by alsa0.perex.cz (Postfix) with ESMTP id BAD9E2619EB
 for <alsa-devel@alsa-project.org>; Sat, 31 Aug 2013 11:00:52 +0200 (CEST)
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

The DAPM context struct has its own field where it stores the pointer to the
DAPM debugfs entry. The debugfs_dapm field in the snd_soc_platform and
snd_soc_codec structs are completely unused and can be removed.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 include/sound/soc.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index 9d4c2ab..79b305d 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -723,7 +723,6 @@ struct snd_soc_codec {
 #ifdef CONFIG_DEBUG_FS
 	struct dentry *debugfs_codec_root;
 	struct dentry *debugfs_reg;
-	struct dentry *debugfs_dapm;
 #endif
 };
 
@@ -848,7 +847,6 @@ struct snd_soc_platform {
 
 #ifdef CONFIG_DEBUG_FS
 	struct dentry *debugfs_platform_root;
-	struct dentry *debugfs_dapm;
 #endif
 };
 
-- 
1.8.0
