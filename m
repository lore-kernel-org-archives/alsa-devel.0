From: David Henningsson <david.henningsson@canonical.com>
Subject: [PATCH] ALSA: hda - Enable power_save_node for CX20722
Date: Thu,  3 Dec 2015 15:46:57 +0100
Message-ID: <1449154017-5256-1-git-send-email-david.henningsson@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id 65E73260423
 for <alsa-devel@alsa-project.org>; Thu,  3 Dec 2015 15:46:58 +0100 (CET)
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
Cc: David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

I've tested it on one device and it works fine, no clicks.

Signed-off-by: David Henningsson <david.henningsson@canonical.com>
---

Alsa-info for this device is available here: https://launchpadlibrarian.net/228090406/AlsaInfo.txt

Possibly it works well for other chips too, but this is the only one
I have tested.

Btw; I noticed another thing which I wonder whether it's correct or not:
If I run "hda-emu AlsaInfo.txt", all nodes are in D3. But after running "P 0 p",
some nodes (e g the internal speaker pin) stays in D0. Is that expected?
I thought all pins would go down to D3 when playback closes.
Same behaviour is seen on the real hardware, too.

 sound/pci/hda/patch_conexant.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/pci/hda/patch_conexant.c b/sound/pci/hda/patch_conexant.c
index ef19890..6122b8c 100644
--- a/sound/pci/hda/patch_conexant.c
+++ b/sound/pci/hda/patch_conexant.c
@@ -901,6 +901,9 @@ static int patch_conexant_auto(struct hda_codec *codec)
 		snd_hda_pick_fixup(codec, cxt5051_fixup_models,
 				   cxt5051_fixups, cxt_fixups);
 		break;
+	case 0x14f150f2:
+		codec->power_save_node = 1;
+		/* Fall through */
 	default:
 		codec->pin_amp_workaround = 1;
 		snd_hda_pick_fixup(codec, cxt5066_fixup_models,
-- 
1.9.1
