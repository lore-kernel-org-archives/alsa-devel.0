From: David Henningsson <david.henningsson@canonical.com>
Subject: [PATCH] ALSA: hda - fix broken automute/autoswitch for
	Realtek
Date: Mon,  5 Mar 2012 11:38:46 +0100
Message-ID: <1330943926-5146-1-git-send-email-david.henningsson@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
	[91.189.89.112]) by alsa0.perex.cz (Postfix) with ESMTP id 66BBC24442
	for <alsa-devel@alsa-project.org>; Mon,  5 Mar 2012 11:38:52 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de, alsa-devel@alsa-project.org
Cc: David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

The recent addition of volume-knob widget in the auto-parser broke
automute/autoswitch for some Realtek devices.

Signed-off-by: David Henningsson <david.henningsson@canonical.com>
---
 sound/pci/hda/patch_realtek.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 01179d5..7e65168 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -686,7 +686,7 @@ static void alc_sku_unsol_event(struct hda_codec *codec, unsigned int res)
 	else
 		res >>= 26;
 	action = snd_hda_jack_get_action(codec, res);
-	if (res == ALC_DCVOL_EVENT) {
+	if (action == ALC_DCVOL_EVENT) {
 		/* Execute the dc-vol event here as it requires the NID
 		 * but we don't pass NID to alc_exec_unsol_event().
 		 * Once when we convert all static quirks to the auto-parser,
-- 
1.7.9
