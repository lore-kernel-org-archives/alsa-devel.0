From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: [PATCH] ASoC: Improve the debugfs hierarchy
Date: Fri,  2 Oct 2009 09:17:37 +0300
Message-ID: <1254464257-884-1-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx09.nokia.com (smtp.nokia.com [192.100.105.134])
	by alsa0.perex.cz (Postfix) with ESMTP id C6578243A9
	for <alsa-devel@alsa-project.org>;
	Fri,  2 Oct 2009 08:18:04 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: broonie@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

Change the way the debugfs entries are created:
If the codec->dev is valid, than use:
debugfs/asoc/{codec->name}.{dev_name(codec->dev)}/

if the codec->dev is NULL:
debugfs/asoc/{codec->name}/

as root for the debugfs entries.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>
---

The patch applies on top of sound-2.6 topic/asoc
commit 88439ac793934a47f47ad285656b63d09f5937c8
	ASoC: add support for multiple cards/codecs in debugfs

 sound/soc/soc-core.c |    8 ++++++--
 1 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index e4ab36d..1dec9d2 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -1256,8 +1256,12 @@ static void soc_init_codec_debugfs(struct snd_soc_codec *codec)
 {
 	char codec_root[128];

-	snprintf(codec_root, sizeof(codec_root),
-		 "%s-%s", dev_name(codec->socdev->dev), codec->name);
+	if (codec->dev)
+		snprintf(codec_root, sizeof(codec_root),
+			"%s.%s", codec->name, dev_name(codec->dev));
+	else
+		snprintf(codec_root, sizeof(codec_root),
+			"%s", codec->name);

 	codec->debugfs_codec_root = debugfs_create_dir(codec_root,
 						       debugfs_root);
--
1.6.5.rc2
