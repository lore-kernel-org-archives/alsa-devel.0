From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 04/12] ALSA: hda/ca0132 - Use NULL instead of 0
Date: Wed, 25 Jul 2018 23:00:49 +0200
Message-ID: <20180725210057.18017-5-tiwai@suse.de>
References: <20180725210057.18017-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 848F726775C
 for <alsa-devel@alsa-project.org>; Wed, 25 Jul 2018 23:01:04 +0200 (CEST)
Received: from relay1.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id 8E909B068
 for <alsa-devel@alsa-project.org>; Wed, 25 Jul 2018 21:01:03 +0000 (UTC)
In-Reply-To: <20180725210057.18017-1-tiwai@suse.de>
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

Use NULL for initializing the snd_kcontrol_new.tlv field, instead of
0, as warned by sparse:
  sound/pci/hda/patch_ca0132.c:5519:22: warning: Using plain integer as NULL pointer

Also, the driver does the same initialization twice, once for
knew.tlv.c and another for knew.tlv.p while both point to the same
address (these are union).  Drop the latter superfluous one.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/patch_ca0132.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/sound/pci/hda/patch_ca0132.c b/sound/pci/hda/patch_ca0132.c
index 321e95c409c1..27d3388cd2a2 100644
--- a/sound/pci/hda/patch_ca0132.c
+++ b/sound/pci/hda/patch_ca0132.c
@@ -5516,8 +5516,7 @@ static int ca0132_alt_add_effect_slider(struct hda_codec *codec, hda_nid_t nid,
 
 	sprintf(namestr, "FX: %s %s Volume", pfx, dirstr[dir]);
 
-	knew.tlv.c = 0;
-	knew.tlv.p = 0;
+	knew.tlv.c = NULL;
 
 	switch (nid) {
 	case XBASS_XOVER:
-- 
2.18.0
