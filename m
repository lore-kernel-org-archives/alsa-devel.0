From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 6/6] ALSA: usb-audio: Give proper
	vendor/product name for Dell WD15 Dock
Date: Wed,  2 May 2018 16:11:16 +0200
Message-ID: <20180502141116.31966-7-tiwai@suse.de>
References: <20180502141116.31966-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 51AB0266F50
 for <alsa-devel@alsa-project.org>; Wed,  2 May 2018 16:11:20 +0200 (CEST)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 839B3AF0A
 for <alsa-devel@alsa-project.org>; Wed,  2 May 2018 14:11:19 +0000 (UTC)
In-Reply-To: <20180502141116.31966-1-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Dell WD15 Dock with 0bda:4014 doesn't give any useful strings for the
vendor and the product names.  Name them more specifically via quirk,
as well as the UCM profile name.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/usb/quirks-table.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/sound/usb/quirks-table.h b/sound/usb/quirks-table.h
index 754e632a27bd..0e37e358ca97 100644
--- a/sound/usb/quirks-table.h
+++ b/sound/usb/quirks-table.h
@@ -3371,5 +3371,15 @@ AU0828_DEVICE(0x2040, 0x7270, "Hauppauge", "HVR-950Q"),
 		}
 	}
 },
+/* Dell WD15 Dock */
+{
+	USB_DEVICE(0x0bda, 0x4014),
+	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
+		.vendor_name = "Dell",
+		.product_name = "WD15 Dock",
+		.profile_name = "Dell-WD15-Dock",
+		.ifnum = QUIRK_NO_INTERFACE
+	}
+},
 
 #undef USB_DEVICE_VENDOR_SPEC
-- 
2.16.3
