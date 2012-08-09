From: David Henningsson <david.henningsson@canonical.com>
Subject: [PATCH] ALSA: hda - Fix pop noise in headphones on S3
	for Asus X55A, X55V
Date: Thu,  9 Aug 2012 10:56:12 +0200
Message-ID: <1344502572-7215-1-git-send-email-david.henningsson@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id BAF542661DD
 for <alsa-devel@alsa-project.org>; Thu,  9 Aug 2012 10:26:25 +0200 (CEST)
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
Cc: 1034779@bugs.launchpad.net, David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

To turn off pin control for the pin was tested, and helped against
this issue.

BugLink: https://bugs.launchpad.net/bugs/1034779
Tested-by: Chih-Hsyuan Ho <chih.ho@canonical.com>
Signed-off-by: David Henningsson <david.henningsson@canonical.com>
---
 sound/pci/hda/patch_via.c |    8 ++++++++
 1 file changed, 8 insertions(+)

Alsa-info at: https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1034779/+attachment/3254105/+files/asus-x55a-alsa-info.log

diff --git a/sound/pci/hda/patch_via.c b/sound/pci/hda/patch_via.c
index 80d90cb..c9484fe 100644
--- a/sound/pci/hda/patch_via.c
+++ b/sound/pci/hda/patch_via.c
@@ -1752,6 +1752,14 @@ static int via_suspend(struct hda_codec *codec)
 {
 	struct via_spec *spec = codec->spec;
 	vt1708_stop_hp_work(spec);
+
+	if (spec->codec_type == VT1802) {
+		/* Fix pop noise on headphones */
+		int i;
+		for (i = 0; i < spec->autocfg.hp_outs; i++)
+			snd_hda_set_pin_ctl(codec, spec->autocfg.hp_pins[i], 0);
+	}
+
 	return 0;
 }
 #endif
-- 
1.7.9.5
