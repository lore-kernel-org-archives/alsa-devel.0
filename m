From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] ALSA: emux: Add support of loading GUS-patch
Date: Tue, 26 Mar 2019 17:36:01 +0100
Message-ID: <20190326163601.19261-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B40F5F801D8
 for <alsa-devel@alsa-project.org>; Tue, 26 Mar 2019 17:36:03 +0100 (CET)
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id 44972ABC1
 for <alsa-devel@alsa-project.org>; Tue, 26 Mar 2019 16:36:02 +0000 (UTC)
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

It's a feature request for the ancient sutff, but it's still valid;
the loading of a GUS-patch isn't available via hwdep device although
it's supported over OSS sequencer.  The only missing piece is the call
of snd_soundfont_load_guspatch() in synth emux hwdep code.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/synth/emux/emux_hwdep.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/sound/synth/emux/emux_hwdep.c b/sound/synth/emux/emux_hwdep.c
index d9fcae071b47..fae48d108b97 100644
--- a/sound/synth/emux/emux_hwdep.c
+++ b/sound/synth/emux/emux_hwdep.c
@@ -39,6 +39,11 @@ snd_emux_hwdep_load_patch(struct snd_emux *emu, void __user *arg)
 	if (copy_from_user(&patch, arg, sizeof(patch)))
 		return -EFAULT;
 
+	if (patch.key == GUS_PATCH)
+		return snd_soundfont_load_guspatch(emu->sflist, arg,
+						   patch.len + sizeof(patch),
+						   TMP_CLIENT_ID);
+
 	if (patch.type >= SNDRV_SFNT_LOAD_INFO &&
 	    patch.type <= SNDRV_SFNT_PROBE_DATA) {
 		err = snd_soundfont_load(emu->sflist, arg, patch.len + sizeof(patch), TMP_CLIENT_ID);
-- 
2.16.4
