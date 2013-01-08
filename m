From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 092/112] ALSA: hda - Correct aamix output paths
Date: Tue,  8 Jan 2013 12:39:25 +0100
Message-ID: <1357645185-7645-93-git-send-email-tiwai@suse.de>
References: <1357645185-7645-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id E24AF265224
 for <alsa-devel@alsa-project.org>; Tue,  8 Jan 2013 12:40:26 +0100 (CET)
Received: from relay2.suse.de (unknown [195.135.220.254])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx2.suse.de (Postfix) with ESMTP id BEEC3A538A
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

The output paths including aamix should be parsed only for the first
output.  The surround paths including aamix must be wrong, since it
would mix all streams, i.e. all channels would be mixed into a single
and multiplexed again.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/hda_generic.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/pci/hda/hda_generic.c b/sound/pci/hda/hda_generic.c
index 65883c7..774c092 100644
--- a/sound/pci/hda/hda_generic.c
+++ b/sound/pci/hda/hda_generic.c
@@ -918,7 +918,7 @@ static int try_assign_dacs(struct hda_codec *codec, int num_outs,
 				badness += bad->no_dac;
 		}
 		path = snd_hda_add_new_path(codec, dac, pin, HDA_PARSE_NO_AAMIX);
-		if (!path && i > 0 && spec->mixer_nid) {
+		if (!path && !i && spec->mixer_nid) {
 			/* try with aamix */
 			path = snd_hda_add_new_path(codec, dac, pin, HDA_PARSE_ALL);
 		}
@@ -1102,7 +1102,7 @@ static bool map_singles(struct hda_codec *codec, int outs,
 		if (!dac)
 			continue;
 		path = snd_hda_add_new_path(codec, dac, pins[i], HDA_PARSE_NO_AAMIX);
-		if (!path && i > 0 && spec->mixer_nid)
+		if (!path && !i && spec->mixer_nid)
 			path = snd_hda_add_new_path(codec, dac, pins[i], HDA_PARSE_ALL);
 		if (path) {
 			dacs[i] = dac;
-- 
1.8.0.1
