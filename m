From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] ALSA: hda/realtek - Avoid invalid COEFs for
	ALC271X
Date: Wed,  5 Feb 2014 07:19:00 +0100
Message-ID: <1391581140-3363-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id E7201261ACD
 for <alsa-devel@alsa-project.org>; Wed,  5 Feb 2014 07:19:00 +0100 (CET)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 0D3A2AAD1
 for <alsa-devel@alsa-project.org>; Wed,  5 Feb 2014 06:19:00 +0000 (UTC)
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

We've seen often problems after suspend/resume on Acer Aspire One
AO725 with ALC271X codec as reported in kernel bugzilla, and it turned
out that some COEFs doesn't work and triggers the codec communication
stall.

Since these magic COEF setups are specific to ALC269VB for some PLL
configurations, the machine works even without these manual
adjustment.  So, let's simply avoid applying them for ALC271X.

Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=52181
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/patch_realtek.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 56a8f1876603..e16a71e586f0 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -4427,6 +4427,9 @@ static void alc269_fill_coef(struct hda_codec *codec)
 
 	if (spec->codec_variant != ALC269_TYPE_ALC269VB)
 		return;
+	/* ALC271X doesn't seem to support these COEFs (bko#52181) */
+	if (!strcmp(codec->chip_name, "ALC271X"))
+		return;
 
 	if ((alc_get_coef0(codec) & 0x00ff) < 0x015) {
 		alc_write_coef_idx(codec, 0xf, 0x960b);
-- 
1.8.5.2
