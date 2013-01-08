From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 065/112] ALSA: hda - Increase the max depth of
	widget connections
Date: Tue,  8 Jan 2013 12:38:58 +0100
Message-ID: <1357645185-7645-66-git-send-email-tiwai@suse.de>
References: <1357645185-7645-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 349332651FC
 for <alsa-devel@alsa-project.org>; Tue,  8 Jan 2013 12:40:26 +0100 (CET)
Received: from relay1.suse.de (unknown [195.135.220.254])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx2.suse.de (Postfix) with ESMTP id 5770EA52F3
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

Old codecs like AD1986A tend to have long paths as they were just made
to be the way like AC97.  The current max depth 5 can be too short for
such devices.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/hda_codec.c   | 2 +-
 sound/pci/hda/hda_generic.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/pci/hda/hda_codec.c b/sound/pci/hda/hda_codec.c
index 9eb73b0..380c9ed 100644
--- a/sound/pci/hda/hda_codec.c
+++ b/sound/pci/hda/hda_codec.c
@@ -591,7 +591,7 @@ int snd_hda_get_conn_index(struct hda_codec *codec, hda_nid_t mux,
 			return i;
 	if (!recursive)
 		return -1;
-	if (recursive > 5) {
+	if (recursive > 10) {
 		snd_printd("hda_codec: too deep connection for 0x%x\n", nid);
 		return -1;
 	}
diff --git a/sound/pci/hda/hda_generic.h b/sound/pci/hda/hda_generic.h
index 417ab65..89ad877 100644
--- a/sound/pci/hda/hda_generic.h
+++ b/sound/pci/hda/hda_generic.h
@@ -37,7 +37,7 @@ struct hda_multi_io {
  * vol_ctl and mute_ctl contains the NIDs for the assigned mixers
  */
 
-#define MAX_NID_PATH_DEPTH	5
+#define MAX_NID_PATH_DEPTH	10
 
 enum {
 	NID_PATH_VOL_CTL,
-- 
1.8.0.1
