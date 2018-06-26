From: Fabio Estevam <festevam@gmail.com>
Subject: [PATCH] ASoC: soc-utils: Fix unregistration order
Date: Tue, 26 Jun 2018 08:58:35 -0300
Message-ID: <1530014315-17674-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qk0-f196.google.com (mail-qk0-f196.google.com
 [209.85.220.196])
 by alsa0.perex.cz (Postfix) with ESMTP id A08D22675C8
 for <alsa-devel@alsa-project.org>; Tue, 26 Jun 2018 13:58:17 +0200 (CEST)
Received: by mail-qk0-f196.google.com with SMTP id u62-v6so6763693qkf.9
 for <alsa-devel@alsa-project.org>; Tue, 26 Jun 2018 04:58:17 -0700 (PDT)
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
Cc: Fabio Estevam <fabio.estevam@nxp.com>, alsa-devel@alsa-project.org, lgirdwood@gmail.com, tiwai@suse.com
List-Id: alsa-devel@alsa-project.org

From: Fabio Estevam <fabio.estevam@nxp.com>

The unregistration should happen in the opposite order of
the registration, so change it accordingly.

No real issue has been noticed, but it is good practice to
keep the correct unregistration order.

Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
 sound/soc/soc-utils.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/soc-utils.c b/sound/soc/soc-utils.c
index 2d9e98b..a863bb3 100644
--- a/sound/soc/soc-utils.c
+++ b/sound/soc/soc-utils.c
@@ -381,6 +381,6 @@ int __init snd_soc_util_init(void)
 
 void __exit snd_soc_util_exit(void)
 {
-	platform_device_unregister(soc_dummy_dev);
 	platform_driver_unregister(&soc_dummy_driver);
+	platform_device_unregister(soc_dummy_dev);
 }
-- 
2.7.4
