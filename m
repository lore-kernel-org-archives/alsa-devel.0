From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 2/2] ASoC: Remove redundant device name from
	debugfs directory
Date: Thu, 12 Aug 2010 15:50:32 +0100
Message-ID: <1281624632-17992-2-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1281624632-17992-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 16F331038CF
	for <alsa-devel@alsa-project.org>;
	Thu, 12 Aug 2010 16:50:37 +0200 (CEST)
In-Reply-To: <1281624632-17992-1-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@slimlogic.co.uk>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Since the core now includes deduplication in the name of CODEC
devices there's no need to add extra for the debugfs directory name.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/soc-core.c |   11 +----------
 1 files changed, 1 insertions(+), 10 deletions(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index ac0fa22..cea0fe4 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -234,16 +234,7 @@ static const struct file_operations codec_reg_fops = {
 
 static void soc_init_codec_debugfs(struct snd_soc_codec *codec)
 {
-	char codec_root[128];
-
-	if (codec->dev)
-		snprintf(codec_root, sizeof(codec_root),
-			"%s.%s", codec->name, dev_name(codec->dev));
-	else
-		snprintf(codec_root, sizeof(codec_root),
-			"%s", codec->name);
-
-	codec->debugfs_codec_root = debugfs_create_dir(codec_root,
+	codec->debugfs_codec_root = debugfs_create_dir(codec->name ,
 						       debugfs_root);
 	if (!codec->debugfs_codec_root) {
 		printk(KERN_WARNING
-- 
1.7.1
