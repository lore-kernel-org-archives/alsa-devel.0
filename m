From: Scott Wood <scottwood@freescale.com>
Subject: [PATCH 03/22] sound: %pF is only for function pointers
Date: Wed, 11 Mar 2015 22:13:38 -0500
Message-ID: <1426130037-17956-3-git-send-email-scottwood@freescale.com>
References: <1426130037-17956-1-git-send-email-scottwood@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2on0107.outbound.protection.outlook.com [207.46.100.107])
 by alsa0.perex.cz (Postfix) with ESMTP id 64B0E2654D9
 for <alsa-devel@alsa-project.org>; Thu, 12 Mar 2015 04:14:26 +0100 (CET)
In-Reply-To: <1426130037-17956-1-git-send-email-scottwood@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: trivial@kernel.org, linux-kernel@vger.kernel.org
Cc: Scott Wood <scottwood@freescale.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Use %pS for actual addresses, otherwise you'll get bad output
on arches like ppc64 where %pF expects a function descriptor.

Signed-off-by: Scott Wood <scottwood@freescale.com>
Cc: alsa-devel@alsa-project.org
---
 sound/core/device.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/core/device.c b/sound/core/device.c
index 41bec30..4879711 100644
--- a/sound/core/device.c
+++ b/sound/core/device.c
@@ -127,7 +127,7 @@ void snd_device_free(struct snd_card *card, void *device_data)
 	if (dev)
 		__snd_device_free(dev);
 	else
-		dev_dbg(card->dev, "device free %p (from %pF), not found\n",
+		dev_dbg(card->dev, "device free %p (from %pS), not found\n",
 			device_data, __builtin_return_address(0));
 }
 EXPORT_SYMBOL(snd_device_free);
-- 
2.1.0
