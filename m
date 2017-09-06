From: Helge Deller <deller@gmx.de>
Subject: [PATCH 14/14] sound/core: Use %pS printk format for direct addresses
Date: Wed,  6 Sep 2017 22:28:01 +0200
Message-ID: <1504729681-3504-15-git-send-email-deller@gmx.de>
References: <1504729681-3504-1-git-send-email-deller@gmx.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1504729681-3504-1-git-send-email-deller@gmx.de>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Petr Mladek <pmladek@suse.com>, Andrew Morton <akpm@linux-foundation.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The debug functions uses wrongly the %pF instead of the %pS printk format
specifier for printing symbols for the address returned by
_builtin_return_address(0). Fix it for the ia64, ppc64 and parisc64
architectures.

Signed-off-by: Helge Deller <deller@gmx.de>
Cc: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.com>
Cc: alsa-devel@alsa-project.org
---
 sound/core/device.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/core/device.c b/sound/core/device.c
index 8918838..cb0e46f 100644
--- a/sound/core/device.c
+++ b/sound/core/device.c
@@ -128,7 +128,7 @@ void snd_device_disconnect(struct snd_card *card, void *device_data)
 	if (dev)
 		__snd_device_disconnect(dev);
 	else
-		dev_dbg(card->dev, "device disconnect %p (from %pF), not found\n",
+		dev_dbg(card->dev, "device disconnect %p (from %pS), not found\n",
 			device_data, __builtin_return_address(0));
 }
 EXPORT_SYMBOL_GPL(snd_device_disconnect);
@@ -152,7 +152,7 @@ void snd_device_free(struct snd_card *card, void *device_data)
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
