From: Jon Smirl <jonsmirl@gmail.com>
Subject: [PATCH V2 1/9] Register the wm9712 DAIs on module load
Date: Sat, 23 May 2009 19:12:57 -0400
Message-ID: <20090523231257.17919.4483.stgit@terra>
References: <20090523231148.17919.46103.stgit@terra>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from yw-out-1718.google.com (yw-out-1718.google.com [74.125.46.152])
	by alsa0.perex.cz (Postfix) with ESMTP id 448E62442F
	for <alsa-devel@alsa-project.org>;
	Sun, 24 May 2009 01:12:58 +0200 (CEST)
Received: by yw-out-1718.google.com with SMTP id 4so1843079ywq.2
	for <alsa-devel@alsa-project.org>; Sat, 23 May 2009 16:12:58 -0700 (PDT)
In-Reply-To: <20090523231148.17919.46103.stgit@terra>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: grant.likely@secretlab.ca, linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org, broonie@sirena.org.uk
List-Id: alsa-devel@alsa-project.org

Register the wm9712 DAIs on module load

Signed-off-by: Jon Smirl <jonsmirl@gmail.com>
---
 0 files changed, 0 insertions(+), 0 deletions(-)

diff --git a/sound/soc/codecs/wm9712.c b/sound/soc/codecs/wm9712.c
index 1fd4e88..49ad987 100644
--- a/sound/soc/codecs/wm9712.c
+++ b/sound/soc/codecs/wm9712.c
@@ -742,6 +742,18 @@ struct snd_soc_codec_device soc_codec_dev_wm9712 = {
 };
 EXPORT_SYMBOL_GPL(soc_codec_dev_wm9712);
 
+static int __init wm9712_modinit(void)
+{
+	return snd_soc_register_dais(wm9712_dai, ARRAY_SIZE(wm9712_dai));
+}
+module_init(wm9712_modinit);
+
+static void __exit wm9712_exit(void)
+{
+	snd_soc_unregister_dais(wm9712_dai, ARRAY_SIZE(wm9712_dai));
+}
+module_exit(wm9712_exit);
+
 MODULE_DESCRIPTION("ASoC WM9711/WM9712 driver");
 MODULE_AUTHOR("Liam Girdwood");
 MODULE_LICENSE("GPL");
