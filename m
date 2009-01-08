From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: [PATCH 3/3] ASoC: TWL4030: Module unloading fix
Date: Thu,  8 Jan 2009 15:52:43 +0200
Message-ID: <1231422763-13659-1-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx06.nokia.com (smtp.nokia.com [192.100.122.233])
	by alsa0.perex.cz (Postfix) with ESMTP id DC7732443E
	for <alsa-devel@alsa-project.org>; Thu,  8 Jan 2009 14:52:49 +0100 (CET)
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
Cc: sakoman@gmail.com, Peter Ujfalusi <peter.ujfalusi@nokia.com>
List-Id: alsa-devel@alsa-project.org

Call the snd_soc_free_pcm and snd_soc_dapm_free when the
codec driver is unloaded.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>
---
 sound/soc/codecs/twl4030.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/sound/soc/codecs/twl4030.c b/sound/soc/codecs/twl4030.c
index db24f83..ea370a4 100644
--- a/sound/soc/codecs/twl4030.c
+++ b/sound/soc/codecs/twl4030.c
@@ -1280,6 +1280,8 @@ static int twl4030_remove(struct platform_device *pdev)
 	struct snd_soc_codec *codec = socdev->codec;
 
 	printk(KERN_INFO "TWL4030 Audio Codec remove\n");
+	snd_soc_free_pcms(socdev);
+	snd_soc_dapm_free(socdev);
 	kfree(codec);
 
 	return 0;
-- 
1.6.1
