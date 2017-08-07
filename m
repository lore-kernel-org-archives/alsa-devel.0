From: Fabio Estevam <festevam@gmail.com>
Subject: [PATCH v3 2/2] ASoC: soc-core: Use IS_ERR_OR_NULL()
Date: Mon,  7 Aug 2017 09:08:53 -0300
Message-ID: <1502107733-29628-2-git-send-email-festevam@gmail.com>
References: <1502107733-29628-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qk0-f195.google.com (mail-qk0-f195.google.com
 [209.85.220.195])
 by alsa0.perex.cz (Postfix) with ESMTP id 704322671E0
 for <alsa-devel@alsa-project.org>; Mon,  7 Aug 2017 14:09:03 +0200 (CEST)
Received: by mail-qk0-f195.google.com with SMTP id d145so220241qkc.0
 for <alsa-devel@alsa-project.org>; Mon, 07 Aug 2017 05:09:03 -0700 (PDT)
In-Reply-To: <1502107733-29628-1-git-send-email-festevam@gmail.com>
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

The check of IS_ERR or NULL pointer can be replaced by IS_ERR_OR_NULL(),
which helps readability.

Signed-off-by: Fabio Estevam <festevam@gmail.com>
---
Changes since v2:
- Keep the error checking and use IS_ERR_OR_NULL() instead.

 sound/soc/soc-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index e93a72c..0026eff 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -495,7 +495,7 @@ static void soc_cleanup_card_debugfs(struct snd_soc_card *card)
 static void snd_soc_debugfs_init(void)
 {
 	snd_soc_debugfs_root = debugfs_create_dir("asoc", NULL);
-	if (IS_ERR(snd_soc_debugfs_root) || !snd_soc_debugfs_root) {
+	if (IS_ERR_OR_NULL(snd_soc_debugfs_root)) {
 		pr_warn("ASoC: Failed to create debugfs directory\n");
 		snd_soc_debugfs_root = NULL;
 		return;
-- 
2.7.4
