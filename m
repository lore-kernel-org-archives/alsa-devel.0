From: David Henningsson <david.henningsson@canonical.com>
Subject: [PATCH] ALSA: hda - Remove speaker clicks on CX20549
Date: Thu, 14 Feb 2013 11:36:39 +0100
Message-ID: <1360838199-3906-1-git-send-email-david.henningsson@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id 548C52652E8
 for <alsa-devel@alsa-project.org>; Thu, 14 Feb 2013 11:36:40 +0100 (CET)
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
Cc: 886975@bugs.launchpad.net, David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

This chip needs the speaker pin to go to D3 to avoid clicks,
so default_power_filter does not work here.

This was found on Thinkpad R61i/T61i but I guess it applies to
the entire chip. If not, quirks should be set for at least
PCI SSID 17aa:20ac.

Thanks to c4pp4 for testing.

BugLink: https://bugs.launchpad.net/bugs/886975
Signed-off-by: David Henningsson <david.henningsson@canonical.com>
---
 sound/pci/hda/patch_conexant.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/pci/hda/patch_conexant.c b/sound/pci/hda/patch_conexant.c
index 7d941ef..941bf6c 100644
--- a/sound/pci/hda/patch_conexant.c
+++ b/sound/pci/hda/patch_conexant.c
@@ -3350,6 +3350,7 @@ static int patch_conexant_auto(struct hda_codec *codec)
 	switch (codec->vendor_id) {
 	case 0x14f15045:
 		codec->single_adc_amp = 1;
+		codec->power_filter = NULL; /* Needs speaker amp to D3 to avoid click */
 		break;
 	case 0x14f15047:
 		codec->pin_amp_workaround = 1;
-- 
1.7.9.5
