From: David Henningsson <david.henningsson@canonical.com>
Subject: [PATCH] ALSA: hda - Fix subsystem ID read regression
Date: Wed,  1 Apr 2015 12:43:00 +0200
Message-ID: <1427884980-18548-1-git-send-email-david.henningsson@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id AF82426087E
 for <alsa-devel@alsa-project.org>; Wed,  1 Apr 2015 12:43:02 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de, alsa-devel@alsa-project.org
Cc: tienfu.chen@canonical.com, David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

A regression was introduced in 7639a06c23c7d4cda3: if AC_PAR_SUBSYSTEM_ID
reads as zero, one should retry using AC_VERB_GET_SUBSYSTEM_ID.

This seems to hit many codecs (my own laptop included), and causes
quirks for some machines not to apply correctly.

Reported-by: TienFu Chen <tienfu.chen@canonical.com>
Signed-off-by: David Henningsson <david.henningsson@canonical.com>
---
 sound/hda/hdac_device.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/hda/hdac_device.c b/sound/hda/hdac_device.c
index 6e8ee1d..53b6b95 100644
--- a/sound/hda/hdac_device.c
+++ b/sound/hda/hdac_device.c
@@ -91,7 +91,7 @@ int snd_hdac_device_init(struct hdac_device *codec, struct hdac_bus *bus,
 
 	codec->power_caps = snd_hdac_read_parm(codec, fg, AC_PAR_POWER_STATE);
 	/* reread ssid if not set by parameter */
-	if (codec->subsystem_id == -1)
+	if (codec->subsystem_id == -1 || codec->subsystem_id == 0)
 		snd_hdac_read(codec, fg, AC_VERB_GET_SUBSYSTEM_ID, 0,
 			      &codec->subsystem_id);
 
-- 
1.9.1
