From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] ALSA: hda - Fix jack detection at resume with
	VT codecs
Date: Sun, 31 May 2015 09:33:07 +0200
Message-ID: <1433057587-31787-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 531002606AC
 for <alsa-devel@alsa-project.org>; Sun, 31 May 2015 09:33:10 +0200 (CEST)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 0EBB9AC73
 for <alsa-devel@alsa-project.org>; Sun, 31 May 2015 07:33:10 +0000 (UTC)
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

VT202x codecs seem requiring some delay after the resume D0 power
transition for making the jack detection working again.  Without the
delay soon after D0, the jack is always detected as unplugged.

Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=98921
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/patch_via.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/sound/pci/hda/patch_via.c b/sound/pci/hda/patch_via.c
index 31a95cca015d..bab6c04932aa 100644
--- a/sound/pci/hda/patch_via.c
+++ b/sound/pci/hda/patch_via.c
@@ -449,6 +449,15 @@ static int via_suspend(struct hda_codec *codec)
 
 	return 0;
 }
+
+static int via_resume(struct hda_codec *codec)
+{
+	/* some delay here to make jack detection working (bko#98921) */
+	msleep(10);
+	codec->patch_ops.init(codec);
+	regcache_sync(codec->core.regmap);
+	return 0;
+}
 #endif
 
 #ifdef CONFIG_PM
@@ -475,6 +484,7 @@ static const struct hda_codec_ops via_patch_ops = {
 	.stream_pm = snd_hda_gen_stream_pm,
 #ifdef CONFIG_PM
 	.suspend = via_suspend,
+	.resume = via_resume,
 	.check_power_status = via_check_power_status,
 #endif
 };
-- 
2.4.2
