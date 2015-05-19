From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] ALSA: sound/atmel/ac97c.c: remove unused
	variable
Date: Tue, 19 May 2015 17:20:36 +0200
Message-ID: <14010746.Ukv1maRMaG@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 9DA832604AF
 for <alsa-devel@alsa-project.org>; Tue, 19 May 2015 17:20:47 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>
Cc: Alexander Stein <alexanders83@web.de>, Nicolas Ferre <nicolas.ferre@atmel.com>, broonie@kernel.org, Alexandre Belloni <alexandre.belloni@free-electrons.com>
List-Id: alsa-devel@alsa-project.org

The recently added DT support for the ac97 driver is causing
a gcc warning:

sound/atmel/ac97c.c: In function 'atmel_ac97c_probe_dt':
sound/atmel/ac97c.c:919:29: warning: unused variable 'match' [-Wunused-variable]
  const struct of_device_id *match;

The variable is clearly unused, so we can remove it.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>

diff --git a/sound/atmel/ac97c.c b/sound/atmel/ac97c.c
index cf4cedf2b420..6dad042630d8 100644
--- a/sound/atmel/ac97c.c
+++ b/sound/atmel/ac97c.c
@@ -916,7 +916,6 @@ static struct ac97c_platform_data *atmel_ac97c_probe_dt(struct device *dev)
 {
 	struct ac97c_platform_data *pdata;
 	struct device_node *node = dev->of_node;
-	const struct of_device_id *match;
 
 	if (!node) {
 		dev_err(dev, "Device does not have associated DT data\n");
