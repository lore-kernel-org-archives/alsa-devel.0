From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] ALSA: hda - Fix memory leak at error path
Date: Mon,  4 Sep 2017 17:41:59 +0200
Message-ID: <20170904154159.29073-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 37056266F9D
 for <alsa-devel@alsa-project.org>; Mon,  4 Sep 2017 17:42:09 +0200 (CEST)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id 89EA4AB1E
 for <alsa-devel@alsa-project.org>; Mon,  4 Sep 2017 15:42:09 +0000 (UTC)
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

The CA0132 codec driver doesn't call the free function at its error
path of the probe, which leaves the allocated memory.  Call
ca0132_free() properly at the error handling.

Fixes: a73d511c4867 ("ALSA: hda/ca0132: Add unsol handler for DSP and jack detection")
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/patch_ca0132.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/sound/pci/hda/patch_ca0132.c b/sound/pci/hda/patch_ca0132.c
index a148176c16a9..3e73d5c6ccfc 100644
--- a/sound/pci/hda/patch_ca0132.c
+++ b/sound/pci/hda/patch_ca0132.c
@@ -4774,13 +4774,17 @@ static int patch_ca0132(struct hda_codec *codec)
 
 	err = ca0132_prepare_verbs(codec);
 	if (err < 0)
-		return err;
+		goto error;
 
 	err = snd_hda_parse_pin_def_config(codec, &spec->autocfg, NULL);
 	if (err < 0)
-		return err;
+		goto error;
 
 	return 0;
+
+ error:
+	ca0132_free(codec);
+	return err;
 }
 
 /*
-- 
2.14.1
