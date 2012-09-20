From: David Henningsson <david.henningsson@canonical.com>
Subject: [PATCH] ALSA: usb - disable broken hw volume for Tenx
	TP6911
Date: Thu, 20 Sep 2012 10:20:41 +0200
Message-ID: <1348129241-3507-1-git-send-email-david.henningsson@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id 70EBF264EBF
 for <alsa-devel@alsa-project.org>; Thu, 20 Sep 2012 10:20:44 +0200 (CEST)
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
Cc: tiwai@suse.de, 559939@bugs.launchpad.net, David Henningsson <david.henningsson@canonical.com>, zonque@gmail.com
List-Id: alsa-devel@alsa-project.org

While going through Ubuntu bugs, I discovered this patch being
posted and a confirmation that the patch works as expected.

Finding out how the hw volume really works would be preferrable
to just disabling the broken one, but this would be better than
nothing.

Credit: sndfnsdfin (qawsnews)
BugLink: https://bugs.launchpad.net/bugs/559939
Signed-off-by: David Henningsson <david.henningsson@canonical.com>
---
 sound/usb/mixer.c |    7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/sound/usb/mixer.c b/sound/usb/mixer.c
index 4f40ba8..fe56c9d 100644
--- a/sound/usb/mixer.c
+++ b/sound/usb/mixer.c
@@ -1267,6 +1267,13 @@ static int parse_audio_feature_unit(struct mixer_build *state, int unitid, void
 		/* disable non-functional volume control */
 		master_bits &= ~UAC_CONTROL_BIT(UAC_FU_VOLUME);
 		break;
+	case USB_ID(0x1130, 0xf211):
+		snd_printk(KERN_INFO
+			   "usbmixer: volume control quirk for Tenx TP6911 Audio Headset\n");
+		/* disable non-functional volume control */
+		channels = 0;
+		break;
+
 	}
 	if (channels > 0)
 		first_ch_bits = snd_usb_combine_bytes(bmaControls + csize, csize);
-- 
1.7.9.5
