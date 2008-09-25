From: Matthew Ranostay <mranostay@embeddedalley.com>
Subject: [PATCH] hda: slave_dig_outs code block in wrong
	location
Date: Thu, 25 Sep 2008 09:17:11 -0400
Message-ID: <48DB8F57.3050001@embeddedalley.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from easi.embeddedalley.com (easi.embeddedalley.com [71.6.201.124])
	by alsa0.perex.cz (Postfix) with SMTP id 8408B245C8
	for <alsa-devel@alsa-project.org>;
	Thu, 25 Sep 2008 15:17:21 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

Removed invalid references to slave_dig_outs inside the S/PDIF IN capture switch
control. Beforehand this was basically a mute switch for the S/PDIF outs as well.

Signed-off-by: Matthew Ranostay <mranostay@embeddedalley.com>
---

diff --git a/pci/hda/hda_codec.c b/pci/hda/hda_codec.c
index c742e10..cb9aae5 100644
--- a/pci/hda/hda_codec.c
+++ b/pci/hda/hda_codec.c
@@ -1652,15 +1652,9 @@ static int snd_hda_spdif_in_switch_put(struct snd_kcontrol *kcontrol,
 	mutex_lock(&codec->spdif_mutex);
 	change = codec->spdif_in_enable != val;
 	if (change) {
-		hda_nid_t *d;
 		codec->spdif_in_enable = val;
 		snd_hda_codec_write_cache(codec, nid, 0,
 					  AC_VERB_SET_DIGI_CONVERT_1, val);
-
-		if (codec->slave_dig_outs)
-			for (d = codec->slave_dig_outs; *d; d++)
-				snd_hda_codec_write_cache(codec, *d, 0,
-					  AC_VERB_SET_DIGI_CONVERT_1, val);
 	}
 	mutex_unlock(&codec->spdif_mutex);
 	return change;
