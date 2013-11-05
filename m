From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 14/31] ASoC: mid-x86: Use WARN_ON() instead of
	BUG_ON()
Date: Tue,  5 Nov 2013 18:40:01 +0100
Message-ID: <1383673218-18405-15-git-send-email-tiwai@suse.de>
References: <1383673218-18405-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 773A2265279
 for <alsa-devel@alsa-project.org>; Tue,  5 Nov 2013 18:40:42 +0100 (CET)
In-Reply-To: <1383673218-18405-1-git-send-email-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: Vinod Koul <vinod.koul@intel.com>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

BUG_ON() is rather useless for debugging as it leads to panic().
Use WARN_ON() and handle the error cases accordingly.

Cc: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/soc/mid-x86/sst_platform.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/sound/soc/mid-x86/sst_platform.c b/sound/soc/mid-x86/sst_platform.c
index 392fc0b8f5b8..3e94660d452b 100644
--- a/sound/soc/mid-x86/sst_platform.c
+++ b/sound/soc/mid-x86/sst_platform.c
@@ -40,7 +40,8 @@ static DEFINE_MUTEX(sst_lock);
 
 int sst_register_dsp(struct sst_device *dev)
 {
-	BUG_ON(!dev);
+	if (WARN_ON(!dev))
+		return _EINVAL;
 	if (!try_module_get(dev->dev->driver->owner))
 		return -ENODEV;
 	mutex_lock(&sst_lock);
@@ -59,7 +60,8 @@ EXPORT_SYMBOL_GPL(sst_register_dsp);
 
 int sst_unregister_dsp(struct sst_device *dev)
 {
-	BUG_ON(!dev);
+	if (WARN_ON(!dev))
+		return -EINVAL;
 	if (dev != sst)
 		return -EINVAL;
 
-- 
1.8.4.2
