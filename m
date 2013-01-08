From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 005/112] ALSA: hda - Fix mono amp values in
	proc output
Date: Tue,  8 Jan 2013 12:37:58 +0100
Message-ID: <1357645185-7645-6-git-send-email-tiwai@suse.de>
References: <1357645185-7645-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 325472615DA
 for <alsa-devel@alsa-project.org>; Tue,  8 Jan 2013 12:40:23 +0100 (CET)
Received: from relay1.suse.de (unknown [195.135.220.254])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx2.suse.de (Postfix) with ESMTP id 13C2EA51D9
 for <alsa-devel@alsa-project.org>; Tue,  8 Jan 2013 12:40:22 +0100 (CET)
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

The mono widget is always connected to the left channel, thus the left
channel amp value also should be referred for mono widgets instead of
the right channel.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/hda_proc.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/sound/pci/hda/hda_proc.c b/sound/pci/hda/hda_proc.c
index 045e5d3..740f46a 100644
--- a/sound/pci/hda/hda_proc.c
+++ b/sound/pci/hda/hda_proc.c
@@ -138,16 +138,17 @@ static void print_amp_vals(struct snd_info_buffer *buffer,
 	dir = dir == HDA_OUTPUT ? AC_AMP_GET_OUTPUT : AC_AMP_GET_INPUT;
 	for (i = 0; i < indices; i++) {
 		snd_iprintf(buffer, " [");
+		val = snd_hda_codec_read(codec, nid, 0,
+					 AC_VERB_GET_AMP_GAIN_MUTE,
+					 AC_AMP_GET_LEFT | dir | i);
+		snd_iprintf(buffer, "0x%02x", val);
 		if (stereo) {
 			val = snd_hda_codec_read(codec, nid, 0,
 						 AC_VERB_GET_AMP_GAIN_MUTE,
-						 AC_AMP_GET_LEFT | dir | i);
-			snd_iprintf(buffer, "0x%02x ", val);
+						 AC_AMP_GET_RIGHT | dir | i);
+			snd_iprintf(buffer, " 0x%02x", val);
 		}
-		val = snd_hda_codec_read(codec, nid, 0,
-					 AC_VERB_GET_AMP_GAIN_MUTE,
-					 AC_AMP_GET_RIGHT | dir | i);
-		snd_iprintf(buffer, "0x%02x]", val);
+		snd_iprintf(buffer, "]");
 	}
 	snd_iprintf(buffer, "\n");
 }
-- 
1.8.0.1
