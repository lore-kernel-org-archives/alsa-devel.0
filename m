From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH RFC 3/3] ALSA: doc: Update option descriptions
	for snd-usb-audio
Date: Mon, 11 Jan 2016 17:59:16 +0100
Message-ID: <1452531556-32622-4-git-send-email-tiwai@suse.de>
References: <1452531556-32622-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id EA7EB265015
 for <alsa-devel@alsa-project.org>; Mon, 11 Jan 2016 17:59:22 +0100 (CET)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 86EA2AAB2
 for <alsa-devel@alsa-project.org>; Mon, 11 Jan 2016 16:59:21 +0000 (UTC)
In-Reply-To: <1452531556-32622-1-git-send-email-tiwai@suse.de>
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

The autoclock and quirk_alias options have been added.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 Documentation/sound/alsa/ALSA-Configuration.txt | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/Documentation/sound/alsa/ALSA-Configuration.txt b/Documentation/sound/alsa/ALSA-Configuration.txt
index 48148d6d9307..fc53ccd9a629 100644
--- a/Documentation/sound/alsa/ALSA-Configuration.txt
+++ b/Documentation/sound/alsa/ALSA-Configuration.txt
@@ -1910,6 +1910,12 @@ Prior to version 0.9.0rc4 options had a 'snd_' prefix. This was removed.
                     - Default: 0x0000 
     ignore_ctl_error - Ignore any USB-controller regarding mixer
     		       interface (default: no)
+    autoclock	    - Enable auto-clock selection for UAC2 devices
+		      (default: yes)
+    quirk_alias	    - Quirk alias list, pass strings like
+		      "0123abcd:5678beef", which applies the existing
+		      quirk for the device 5678:beef to a new device
+		      0123:abcd.
 
     This module supports multiple devices, autoprobe and hotplugging.
 
@@ -1919,6 +1925,9 @@ Prior to version 0.9.0rc4 options had a 'snd_' prefix. This was removed.
     NB: ignore_ctl_error=1 may help when you get an error at accessing
         the mixer element such as URB error -22.  This happens on some
         buggy USB device or the controller.
+    NB: quirk_alias option is provided only for testing / development.
+        If you want to have a proper support, contact to upstream for
+	adding the matching quirk in the driver code statically.
 
   Module snd-usb-caiaq
   --------------------
-- 
2.7.0
