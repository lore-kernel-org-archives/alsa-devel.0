From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 084/112] ALSA: hda - Don't skip amp init for
	activated paths
Date: Tue,  8 Jan 2013 12:39:17 +0100
Message-ID: <1357645185-7645-85-git-send-email-tiwai@suse.de>
References: <1357645185-7645-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id B5ED3265217
 for <alsa-devel@alsa-project.org>; Tue,  8 Jan 2013 12:40:26 +0100 (CET)
Received: from relay2.suse.de (unknown [195.135.220.254])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx2.suse.de (Postfix) with ESMTP id 9B269A5359
 for <alsa-devel@alsa-project.org>; Tue,  8 Jan 2013 12:40:23 +0100 (CET)
In-Reply-To: <1357645185-7645-1-git-send-email-tiwai@suse.de>
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

activate_amp() in the generic parser checks whether the given NID is
included in any active paths and skips it if found.  This was a
workaround for avoiding disabling the widgets in the active paths when
one path is disabled, thus it shouldn't be applied to the case for
path activation.  Due to this wrong check, some analog loopback paths
haven't been initialized correctly.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/hda_generic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/pci/hda/hda_generic.c b/sound/pci/hda/hda_generic.c
index c5a9b84..08eced0 100644
--- a/sound/pci/hda/hda_generic.c
+++ b/sound/pci/hda/hda_generic.c
@@ -463,7 +463,7 @@ static void activate_amp(struct hda_codec *codec, hda_nid_t nid, int dir,
 {
 	int val;
 	if (is_ctl_associated(codec, nid, dir, idx) ||
-	    is_active_nid(codec, nid, dir, idx))
+	    (!enable && is_active_nid(codec, nid, dir, idx)))
 		return;
 	val = get_amp_val_to_activate(codec, nid, dir, enable);
 	snd_hda_codec_amp_stereo(codec, nid, dir, idx, 0xff, val);
-- 
1.8.0.1
