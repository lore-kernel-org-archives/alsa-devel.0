From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] ALSA: hda - Reduce verbs by node power-saves
Date: Wed, 20 May 2015 07:01:33 +0200
Message-ID: <1432098093-32057-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id DB4F9260462
 for <alsa-devel@alsa-project.org>; Wed, 20 May 2015 07:01:34 +0200 (CEST)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id AA026AC5D
 for <alsa-devel@alsa-project.org>; Wed, 20 May 2015 05:01:34 +0000 (UTC)
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

The widget (node) power-saves restore the widget states at each
transition from D3 to D0 on each node.  This was added in the commit
[d545a57c5f84:ALSA: hda - Sync node attributes at resume from widget
power saving].  However, the test was rater false-positive; this
wasn't needed for any codecs.

Since the resync may take significant number of additional verbs to be
executed, it's better to reduce it.  Let's disable it for now again.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/hda_generic.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/sound/pci/hda/hda_generic.c b/sound/pci/hda/hda_generic.c
index 788f969b1a68..1c8678775f40 100644
--- a/sound/pci/hda/hda_generic.c
+++ b/sound/pci/hda/hda_generic.c
@@ -844,8 +844,16 @@ static hda_nid_t path_power_update(struct hda_codec *codec,
 			snd_hda_codec_write(codec, nid, 0,
 					    AC_VERB_SET_POWER_STATE, state);
 			changed = nid;
+			/* all known codecs seem to be capable to handl
+			 * widgets state even in D3, so far.
+			 * if any new codecs need to restore the widget
+			 * states after D0 transition, call the function
+			 * below.
+			 */
+#if 0 /* disabled */
 			if (state == AC_PWRST_D0)
 				snd_hdac_regmap_sync_node(&codec->core, nid);
+#endif
 		}
 	}
 	return changed;
-- 
2.4.1
