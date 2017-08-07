From: Fabio Estevam <festevam@gmail.com>
Subject: [PATCH 2/2] ASoC: soc-core: Remove unneeded error check
Date: Mon,  7 Aug 2017 00:13:06 -0300
Message-ID: <1502075586-23581-2-git-send-email-festevam@gmail.com>
References: <1502075586-23581-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qk0-f196.google.com (mail-qk0-f196.google.com
 [209.85.220.196])
 by alsa0.perex.cz (Postfix) with ESMTP id 03AD8266F35
 for <alsa-devel@alsa-project.org>; Mon,  7 Aug 2017 05:13:10 +0200 (CEST)
Received: by mail-qk0-f196.google.com with SMTP id x77so6554856qka.4
 for <alsa-devel@alsa-project.org>; Sun, 06 Aug 2017 20:13:10 -0700 (PDT)
In-Reply-To: <1502075586-23581-1-git-send-email-festevam@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org
Cc: alsa-devel@alsa-project.org, Fabio Estevam <festevam@gmail.com>
List-Id: alsa-devel@alsa-project.org

debugfs_create_dir() only returns an error pointer when kernel has been
built without debugfs support.
Quoting Documentation/filesystems/debugfs.txt:

"A NULL return value indicates that something went
wrong.  If ERR_PTR(-ENODEV) is returned, that is an indication that the
kernel has been built without debugfs support and none of the functions
described below will work."

As snd_soc_debugfs_init() is only defined when CONFIG_DEBUG_FS=y,
there is no possibility for debugfs_create_dir() returning an error,
so remove the unneeded error check.

Signed-off-by: Fabio Estevam <festevam@gmail.com>
---
 sound/soc/soc-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index e93a72c..f1d2a38 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -495,7 +495,7 @@ static void soc_cleanup_card_debugfs(struct snd_soc_card *card)
 static void snd_soc_debugfs_init(void)
 {
 	snd_soc_debugfs_root = debugfs_create_dir("asoc", NULL);
-	if (IS_ERR(snd_soc_debugfs_root) || !snd_soc_debugfs_root) {
+	if (!snd_soc_debugfs_root) {
 		pr_warn("ASoC: Failed to create debugfs directory\n");
 		snd_soc_debugfs_root = NULL;
 		return;
-- 
2.7.4
