From: David Henningsson <david.henningsson@canonical.com>
Subject: [PATCH] ALSA: hda - Fix headset mic input after muted
	internal mic (Dell/Realtek)
Date: Mon,  2 Dec 2013 18:06:20 +0800
Message-ID: <1385978780-15157-1-git-send-email-david.henningsson@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id 843A0261AF7
 for <alsa-devel@alsa-project.org>; Mon,  2 Dec 2013 11:06:32 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de, kailang@realtek.com, alsa-devel@alsa-project.org
Cc: David Henningsson <david.henningsson@canonical.com>, 1256840@bugs.launchpad.net
List-Id: alsa-devel@alsa-project.org

By trial and error, I found this patch could work around an issue
where the headset mic would stop working if you switch between the
internal mic and the headset mic, and the internal mic was muted.

It still takes a second or two before the headset mic actually starts
working, but still better than nothing.

I'd like to add stable to this patch, but I'd like Kailang's ack first
because I don't know what the verbs really do.

BugLink: https://bugs.launchpad.net/bugs/1256840
Signed-off-by: David Henningsson <david.henningsson@canonical.com>
---
 sound/pci/hda/patch_realtek.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 537991c..85d1c8b 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -3338,6 +3338,7 @@ static void alc_headset_mode_ctia(struct hda_codec *codec)
 		alc_write_coef_idx(codec, 0x18, 0x7388);
 		break;
 	case 0x10ec0668:
+		alc_write_coef_idx(codec, 0x11, 0x0001);
 		alc_write_coef_idx(codec, 0x15, 0x0d60);
 		alc_write_coef_idx(codec, 0xc3, 0x0000);
 		break;
@@ -3366,6 +3367,7 @@ static void alc_headset_mode_omtp(struct hda_codec *codec)
 		alc_write_coef_idx(codec, 0x18, 0x7388);
 		break;
 	case 0x10ec0668:
+		alc_write_coef_idx(codec, 0x11, 0x0001);
 		alc_write_coef_idx(codec, 0x15, 0x0d50);
 		alc_write_coef_idx(codec, 0xc3, 0x0000);
 		break;
-- 
1.7.9.5
