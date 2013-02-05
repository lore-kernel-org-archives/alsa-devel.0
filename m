From: David Henningsson <david.henningsson@canonical.com>
Subject: [PATCH 2/2] ALSA: hda - detect jacks on VT1708 even
	when no streams are active
Date: Tue,  5 Feb 2013 12:06:03 +0100
Message-ID: <1360062363-10855-2-git-send-email-david.henningsson@canonical.com>
References: <1360062363-10855-1-git-send-email-david.henningsson@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id D90D5265134
 for <alsa-devel@alsa-project.org>; Tue,  5 Feb 2013 12:05:56 +0100 (CET)
In-Reply-To: <1360062363-10855-1-git-send-email-david.henningsson@canonical.com>
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

These days, GUIs such as Gnome sound settings want to be able to
show the correct jack status even when no streams are currently
running. I doubt this gives any measurable difference in power,
but if it does, the "Jack Detect" control can still be used to
turn polling off.

Signed-off-by: David Henningsson <david.henningsson@canonical.com>
---
 sound/pci/hda/patch_via.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/sound/pci/hda/patch_via.c b/sound/pci/hda/patch_via.c
index e934c49..ca7d962 100644
--- a/sound/pci/hda/patch_via.c
+++ b/sound/pci/hda/patch_via.c
@@ -217,8 +217,7 @@ static void vt1708_update_hp_work(struct hda_codec *codec)
 	struct via_spec *spec = codec->spec;
 	if (spec->codec_type != VT1708 || !spec->gen.autocfg.hp_outs)
 		return;
-	if (spec->vt1708_jack_detect &&
-	    (spec->gen.active_streams || hp_detect_with_aa(codec))) {
+	if (spec->vt1708_jack_detect) {
 		if (!spec->hp_work_active) {
 			codec->jackpoll_interval = msecs_to_jiffies(100);
 			snd_hda_codec_write(codec, 0x1, 0, 0xf81, 0);
-- 
1.7.9.5
