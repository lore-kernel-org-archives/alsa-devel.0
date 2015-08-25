From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 2/2] ALSA: hda - Fix path power activation
Date: Tue, 25 Aug 2015 07:59:42 +0200
Message-ID: <1440482382-1967-2-git-send-email-tiwai@suse.de>
References: <1440482382-1967-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 53C83264F31
 for <alsa-devel@alsa-project.org>; Tue, 25 Aug 2015 07:59:53 +0200 (CEST)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 1FC65ACD4
 for <alsa-devel@alsa-project.org>; Tue, 25 Aug 2015 05:59:53 +0000 (UTC)
In-Reply-To: <1440482382-1967-1-git-send-email-tiwai@suse.de>
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

The widget power-saving code tries to turn up/down the power of each
widget in the I/O paths that are modified at each jack plug/unplug.
The recent report revealed that the power activation leaves some
widgets unpowered after plugging.  This is because
snd_hda_activate_path() turns on path->active flag at the end of the
function while the path power management is done before that.  Then
it's regarded as if nothing is active, and the driver turns off the
power.

The fix is simply to set the flag at the beginning of the function,
before trying to power up.

Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=102521
Cc: <stable@vger.kernel.org> [v4.1+]
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/hda_generic.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/sound/pci/hda/hda_generic.c b/sound/pci/hda/hda_generic.c
index 368181d8b0ce..24f91114a32c 100644
--- a/sound/pci/hda/hda_generic.c
+++ b/sound/pci/hda/hda_generic.c
@@ -884,8 +884,7 @@ void snd_hda_activate_path(struct hda_codec *codec, struct nid_path *path,
 	struct hda_gen_spec *spec = codec->spec;
 	int i;
 
-	if (!enable)
-		path->active = false;
+	path->active = enable;
 
 	/* make sure the widget is powered up */
 	if (enable && (spec->power_down_unused || codec->power_save_node))
@@ -903,9 +902,6 @@ void snd_hda_activate_path(struct hda_codec *codec, struct nid_path *path,
 		if (has_amp_out(codec, path, i))
 			activate_amp_out(codec, path, i, enable);
 	}
-
-	if (enable)
-		path->active = true;
 }
 EXPORT_SYMBOL_GPL(snd_hda_activate_path);
 
-- 
2.5.0
