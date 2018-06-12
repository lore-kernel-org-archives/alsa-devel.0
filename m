From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] ALSA: usb-audio: Disable the quirk for Nura
	headset
Date: Tue, 12 Jun 2018 08:26:07 +0200
Message-ID: <20180612062607.23017-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 38BEF2673CC
 for <alsa-devel@alsa-project.org>; Tue, 12 Jun 2018 08:26:13 +0200 (CEST)
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
Cc: Martin Peres <martin.peres@free.fr>
List-Id: alsa-devel@alsa-project.org

The commit 33193dca671c ("ALSA: usb-audio: Add a quirk for Nura's
first gen headset") added a quirk for Nura headset with USB ID
0a12:1243, with a hope that it doesn't conflict with others.
Unfortunately, other devices (e.g. Philips Wecall) with the very same
ID got broken by this change, spewing an error like:
  usb 2-1.8.2: 2:1: cannot set freq 48000 to ep 0x3

Until we find a proper solution, fix the regression at first by
disabling the added quirk entry.

Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=199905
Fixes: 33193dca671c ("ALSA: usb-audio: Add a quirk for Nura's first gen headset")
Reviewed-by: Martin Peres <martin.peres@free.fr>
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/usb/quirks-table.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/sound/usb/quirks-table.h b/sound/usb/quirks-table.h
index 0e37e358ca97..8aac48f9c322 100644
--- a/sound/usb/quirks-table.h
+++ b/sound/usb/quirks-table.h
@@ -3277,6 +3277,10 @@ AU0828_DEVICE(0x2040, 0x7270, "Hauppauge", "HVR-950Q"),
 	}
 },
 
+/* disabled due to regression for other devices;
+ * see https://bugzilla.kernel.org/show_bug.cgi?id=199905
+ */
+#if 0
 {
 	/*
 	 * Nura's first gen headphones use Cambridge Silicon Radio's vendor
@@ -3324,6 +3328,7 @@ AU0828_DEVICE(0x2040, 0x7270, "Hauppauge", "HVR-950Q"),
 		}
 	}
 },
+#endif /* disabled */
 
 {
 	/*
-- 
2.17.0
