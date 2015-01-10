From: David Henningsson <david.henningsson@canonical.com>
Subject: [PATCH] ALSA: hda - fixup input_free_device called
	after input_unregister_device
Date: Sat, 10 Jan 2015 13:02:22 +0100
Message-ID: <1420891342-14225-1-git-send-email-david.henningsson@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id B50762606A8
 for <alsa-devel@alsa-project.org>; Sat, 10 Jan 2015 13:02:15 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, tiwai@suse.de
Cc: David Henningsson <david.henningsson@canonical.com>, dan.carpenter@oracle.com
List-Id: alsa-devel@alsa-project.org

Input_unregister_device will internally free the device, so
input_free_device should not be called.

Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: David Henningsson <david.henningsson@canonical.com>
---
 sound/pci/hda/patch_realtek.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 09d2131..a50e15e 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -3548,7 +3548,6 @@ static void alc280_fixup_hp_gpio2_mic_hotkey(struct hda_codec *codec,
 		break;
 	case HDA_FIXUP_ACT_FREE:
 		input_unregister_device(spec->kb_dev);
-		input_free_device(spec->kb_dev);
 		spec->kb_dev = NULL;
 	}
 #endif
-- 
1.9.1
