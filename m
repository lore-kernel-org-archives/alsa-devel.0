From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 3/5] ASoC: Make DAPM sysfs entries non-optional
Date: Mon, 18 May 2009 16:05:56 +0100
Message-ID: <1242659158-1701-3-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1242659158-1701-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 72C7324467
	for <alsa-devel@alsa-project.org>;
	Mon, 18 May 2009 17:06:09 +0200 (CEST)
In-Reply-To: <1242659158-1701-1-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

sysfs is so standard these days there's no point.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/soc-dapm.c |   10 +---------
 1 files changed, 1 insertions(+), 9 deletions(-)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 04ef841..d130602 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -67,10 +67,6 @@ static int dapm_down_seq[] = {
 	snd_soc_dapm_post
 };
 
-static int dapm_status = 1;
-module_param(dapm_status, int, 0);
-MODULE_PARM_DESC(dapm_status, "enable DPM sysfs entries");
-
 static void pop_wait(u32 pop_time)
 {
 	if (pop_time)
@@ -974,16 +970,12 @@ static DEVICE_ATTR(dapm_widget, 0444, dapm_widget_show, NULL);
 
 int snd_soc_dapm_sys_add(struct device *dev)
 {
-	if (!dapm_status)
-		return 0;
 	return device_create_file(dev, &dev_attr_dapm_widget);
 }
 
 static void snd_soc_dapm_sys_remove(struct device *dev)
 {
-	if (dapm_status) {
-		device_remove_file(dev, &dev_attr_dapm_widget);
-	}
+	device_remove_file(dev, &dev_attr_dapm_widget);
 }
 
 /* free all dapm widgets and resources */
-- 
1.6.3.1
