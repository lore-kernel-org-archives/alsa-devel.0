From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 01/20] ALSA: hda - Exclude aamix from capture
	paths
Date: Tue, 15 Jan 2013 12:05:28 +0100
Message-ID: <1358247947-13992-2-git-send-email-tiwai@suse.de>
References: <1358247947-13992-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 89A7826160C
 for <alsa-devel@alsa-project.org>; Tue, 15 Jan 2013 12:05:50 +0100 (CET)
Received: from relay2.suse.de (unknown [195.135.220.254])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx2.suse.de (Postfix) with ESMTP id 697B0A5202
 for <alsa-devel@alsa-project.org>; Tue, 15 Jan 2013 12:05:48 +0100 (CET)
In-Reply-To: <1358247947-13992-1-git-send-email-tiwai@suse.de>
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

The capture paths shouldn't contain the analog loopback mixer.
Pass a proper argument to exclude the aamix NID.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/hda_generic.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/sound/pci/hda/hda_generic.c b/sound/pci/hda/hda_generic.c
index b488c62..f07b326 100644
--- a/sound/pci/hda/hda_generic.c
+++ b/sound/pci/hda/hda_generic.c
@@ -2110,13 +2110,9 @@ static int create_input_ctls(struct hda_codec *codec)
 
 			if (!is_reachable_path(codec, pin, adc))
 				continue;
-			path = snd_hda_add_new_path(codec, pin, adc, 0);
-			if (!path) {
-				snd_printd(KERN_ERR
-					   "invalid input path 0x%x -> 0x%x\n",
-					   pin, adc);
+			path = snd_hda_add_new_path(codec, pin, adc, -mixer);
+			if (!path)
 				continue;
-			}
 			print_nid_path("input", path);
 			spec->input_paths[imux_idx][c] =
 				snd_hda_get_path_idx(codec, path);
-- 
1.8.1
