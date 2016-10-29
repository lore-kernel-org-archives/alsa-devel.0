From: Nicolas Iooss <nicolas.iooss_linux@m4x.org>
Subject: [PATCH 1/1] ALSA: bebob: use the right string length in check_audiophile_booted()
Date: Sat, 29 Oct 2016 13:41:25 +0200
Message-ID: <20161029114125.20481-1-nicolas.iooss_linux@m4x.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Clemens Ladisch <clemens@ladisch.de>, Takashi Sakamoto <o-takashi@sakamocchi.jp>, alsa-devel@alsa-project.org
Cc: linux-kernel@vger.kernel.org, Nicolas Iooss <nicolas.iooss_linux@m4x.org>
List-Id: alsa-devel@alsa-project.org

Function check_audiophile_booted() only compares 15 characters of the
24-character-long string "FW Audiophile Bootloader" with the firmware
model name. As this seems to be incorrect and because there is no
comment explaining this "15", fix the length which is used in strncmp().

This patch has only been compile-tested.

Fixes: 9076c22ddd9d ("ALSA: bebob: Add support for M-Audio usual
Firewire series")
Signed-off-by: Nicolas Iooss <nicolas.iooss_linux@m4x.org>
---
 sound/firewire/bebob/bebob.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/firewire/bebob/bebob.c b/sound/firewire/bebob/bebob.c
index 3469ac14c89c..b23cd0901553 100644
--- a/sound/firewire/bebob/bebob.c
+++ b/sound/firewire/bebob/bebob.c
@@ -177,7 +177,7 @@ check_audiophile_booted(struct fw_unit *unit)
 	if (fw_csr_string(unit->directory, CSR_MODEL, name, sizeof(name)) < 0)
 		return false;
 
-	return strncmp(name, "FW Audiophile Bootloader", 15) != 0;
+	return strncmp(name, "FW Audiophile Bootloader", 24) != 0;
 }
 
 static void
-- 
2.10.1
