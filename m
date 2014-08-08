From: Gabriele Mazzotta <gabriele.mzt@gmail.com>
Subject: [PATCH 2/2] ALSA: hda - Fix pop noises on reboot for
	Dell XPS 13 9333
Date: Fri,  8 Aug 2014 19:34:41 +0200
Message-ID: <34179b6c336cb5837c0dc239a3b0daf6ac6384c3.1407518135.git.gabriele.mzt@gmail.com>
References: <cover.1407518135.git.gabriele.mzt@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-we0-f175.google.com (mail-we0-f175.google.com
 [74.125.82.175])
 by alsa0.perex.cz (Postfix) with ESMTP id 3AD6926555C
 for <alsa-devel@alsa-project.org>; Fri,  8 Aug 2014 19:35:18 +0200 (CEST)
Received: by mail-we0-f175.google.com with SMTP id t60so5808639wes.6
 for <alsa-devel@alsa-project.org>; Fri, 08 Aug 2014 10:35:17 -0700 (PDT)
In-Reply-To: <cover.1407518135.git.gabriele.mzt@gmail.com>
In-Reply-To: <cover.1407518135.git.gabriele.mzt@gmail.com>
References: <cover.1407518135.git.gabriele.mzt@gmail.com>
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
Cc: tiwai@suse.de, superquad.vortex2@gmail.com, Gabriele Mazzotta <gabriele.mzt@gmail.com>
List-Id: alsa-devel@alsa-project.org

If nid 0x15 (Headphone Playback Switch) is in D3 and headphones are
plugged in when the laptop reboots, a pop noise is generated.
Prevent this by keeping nid 0x15 in D0 when headphones are plugged in.

Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=76611
Signed-off-by: Gabriele Mazzotta <gabriele.mzt@gmail.com>
---
 sound/pci/hda/patch_realtek.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 85cd80c..12fc3e9a 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -4008,7 +4008,7 @@ static unsigned int alc_power_filter_xps13(struct hda_codec *codec,
 
 	/* Avoid pop noises when headphones are plugged in */
 	if (spec->gen.hp_jack_present)
-		if (nid == codec->afg || nid == 0x02)
+		if (nid == codec->afg || nid == 0x02 || nid == 0x15)
 			return AC_PWRST_D0;
 	return power_state;
 }
-- 
2.1.0.rc1
