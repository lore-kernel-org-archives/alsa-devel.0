From: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
Subject: [PATCH 1/7] ASoC: Add control_type in snd_soc_codec
Date: Tue, 22 Mar 2011 10:36:57 +0000
Message-ID: <1300790223-13308-1-git-send-email-dp@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id A50D3103865
	for <alsa-devel@alsa-project.org>; Tue, 22 Mar 2011 11:37:05 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

This is mainly used by the soc-cache code to easily determine the
currently used underlying serial bus.  Set SND_SOC_CUSTOM to 1 so we
can distinguish it if it is not initialized or set.

Signed-off-by: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
---
 include/sound/soc.h |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index bfa4836..abb56ef 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -248,7 +248,7 @@ typedef int (*hw_write_t)(void *,const char* ,int);
 extern struct snd_ac97_bus_ops soc_ac97_ops;
 
 enum snd_soc_control_type {
-	SND_SOC_CUSTOM,
+	SND_SOC_CUSTOM = 1,
 	SND_SOC_I2C,
 	SND_SOC_SPI,
 };
@@ -539,6 +539,7 @@ struct snd_soc_codec {
 
 	/* codec IO */
 	void *control_data; /* codec control (i2c/3wire) data */
+	enum snd_soc_control_type control_type;
 	hw_write_t hw_write;
 	unsigned int (*hw_read)(struct snd_soc_codec *, unsigned int);
 	unsigned int (*read)(struct snd_soc_codec *, unsigned int);
-- 
1.7.4.1
