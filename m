From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 09/10] ALSA: ice1724: Fix uninitialized
	variable access
Date: Tue, 29 Oct 2013 17:00:32 +0100
Message-ID: <1383062433-9388-10-git-send-email-tiwai@suse.de>
References: <1383062433-9388-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id F2F932615CC
 for <alsa-devel@alsa-project.org>; Tue, 29 Oct 2013 16:57:48 +0100 (CET)
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id A84BAA60D1
 for <alsa-devel@alsa-project.org>; Tue, 29 Oct 2013 16:57:48 +0100 (CET)
In-Reply-To: <1383062433-9388-1-git-send-email-tiwai@suse.de>
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

Spotted by coverity CIDs 751505 and 751506.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/ice1712/wm8766.c | 3 ++-
 sound/pci/ice1712/wm8776.c | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/sound/pci/ice1712/wm8766.c b/sound/pci/ice1712/wm8766.c
index e473f8a88f9c..21b373b2e260 100644
--- a/sound/pci/ice1712/wm8766.c
+++ b/sound/pci/ice1712/wm8766.c
@@ -253,7 +253,8 @@ static int snd_wm8766_ctl_get(struct snd_kcontrol *kcontrol,
 	}
 	if (wm->ctl[n].flags & WM8766_FLAG_INVERT) {
 		val1 = wm->ctl[n].max - (val1 - wm->ctl[n].min);
-		val2 = wm->ctl[n].max - (val2 - wm->ctl[n].min);
+		if (wm->ctl[n].flags & WM8766_FLAG_STEREO)
+			val2 = wm->ctl[n].max - (val2 - wm->ctl[n].min);
 	}
 	ucontrol->value.integer.value[0] = val1;
 	if (wm->ctl[n].flags & WM8766_FLAG_STEREO)
diff --git a/sound/pci/ice1712/wm8776.c b/sound/pci/ice1712/wm8776.c
index 5227cb08247f..e66c0da62014 100644
--- a/sound/pci/ice1712/wm8776.c
+++ b/sound/pci/ice1712/wm8776.c
@@ -526,7 +526,8 @@ static int snd_wm8776_ctl_get(struct snd_kcontrol *kcontrol,
 	}
 	if (wm->ctl[n].flags & WM8776_FLAG_INVERT) {
 		val1 = wm->ctl[n].max - (val1 - wm->ctl[n].min);
-		val2 = wm->ctl[n].max - (val2 - wm->ctl[n].min);
+		if (wm->ctl[n].flags & WM8776_FLAG_STEREO)
+			val2 = wm->ctl[n].max - (val2 - wm->ctl[n].min);
 	}
 	ucontrol->value.integer.value[0] = val1;
 	if (wm->ctl[n].flags & WM8776_FLAG_STEREO)
-- 
1.8.4.1
