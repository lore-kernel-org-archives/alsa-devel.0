From: Liam Girdwood <lrg@ti.com>
Subject: [PATCH 1/2] ASoC: core - Add platform component mutex.
Date: Tue,  6 Mar 2012 18:16:18 +0000
Message-ID: <1331057779-4630-1-git-send-email-lrg@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog112.obsmtp.com (na3sys009aog112.obsmtp.com
	[74.125.149.207])
	by alsa0.perex.cz (Postfix) with ESMTP id 810932415D
	for <alsa-devel@alsa-project.org>; Tue,  6 Mar 2012 19:16:32 +0100 (CET)
Received: by werc1 with SMTP id c1so4442254wer.35
	for <alsa-devel@alsa-project.org>; Tue, 06 Mar 2012 10:16:29 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

Add mutex support for platform IO operations. e.g. can be used
for platform DAPM widget IO ops.

Signed-off-by: Liam Girdwood <lrg@ti.com>
---
 include/sound/soc.h  |    1 +
 sound/soc/soc-core.c |    1 +
 2 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index 82bd773..2ebf787 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -718,6 +718,7 @@ struct snd_soc_platform {
 	int id;
 	struct device *dev;
 	struct snd_soc_platform_driver *driver;
+	struct mutex mutex;
 
 	unsigned int suspended:1; /* platform is suspended */
 	unsigned int probed:1;
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 7978f6c..c90bb01 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -3382,6 +3382,7 @@ int snd_soc_register_platform(struct device *dev,
 	platform->dapm.dev = dev;
 	platform->dapm.platform = platform;
 	platform->dapm.stream_event = platform_drv->stream_event;
+	mutex_init(&platform->mutex);
 
 	mutex_lock(&client_mutex);
 	list_add(&platform->list, &platform_list);
-- 
1.7.5.4
