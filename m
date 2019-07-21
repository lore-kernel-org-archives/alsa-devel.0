From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] ALSA: line6: Fix a typo
Date: Sun, 21 Jul 2019 12:25:58 +0200
Message-ID: <20190721102558.16640-1-christophe.jaillet@wanadoo.fr>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: perex@perex.cz, tiwai@suse.com, tglx@linutronix.de
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org, Christophe JAILLET <christophe.jaillet@wanadoo.fr>
List-Id: alsa-devel@alsa-project.org

s/Vairax/Variax/

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 sound/usb/line6/variax.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/usb/line6/variax.c b/sound/usb/line6/variax.c
index 0d24c72c155f..ed158f04de80 100644
--- a/sound/usb/line6/variax.c
+++ b/sound/usb/line6/variax.c
@@ -244,5 +244,5 @@ static struct usb_driver variax_driver = {
 
 module_usb_driver(variax_driver);
 
-MODULE_DESCRIPTION("Vairax Workbench USB driver");
+MODULE_DESCRIPTION("Variax Workbench USB driver");
 MODULE_LICENSE("GPL");
-- 
2.20.1
