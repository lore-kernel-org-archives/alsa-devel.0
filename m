From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: pcm: Fix DPCM for aux_devs
Date: Tue,  8 May 2012 10:34:09 +0100
Message-ID: <1336469650-12524-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 83CB110406B
	for <alsa-devel@alsa-project.org>;
	Tue,  8 May 2012 11:34:13 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

When we instantiate an aux_dev we use a fake rtd as part of the process
which doesn't have a dai_link associated with it. Fix the dpcm startup
code to cope with this.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/soc-pcm.c |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
index a94512c..a3ea8a7 100644
--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -2332,6 +2332,9 @@ static const struct file_operations dpcm_state_fops = {
 
 int soc_dpcm_debugfs_add(struct snd_soc_pcm_runtime *rtd)
 {
+	if (!rtd->dai_link)
+		return 0;
+
 	rtd->debugfs_dpcm_root = debugfs_create_dir(rtd->dai_link->name,
 			rtd->card->debugfs_card_root);
 	if (!rtd->debugfs_dpcm_root) {
-- 
1.7.10
