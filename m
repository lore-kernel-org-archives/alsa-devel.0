From: Lydia Wang <lydiawang@viatech.com.cn>
Subject: [PATCH 5/7] ALSA: VIA HDA: Get codec's type in
	via_new_spec() function
Date: Tue, 22 Mar 2011 16:25:03 +0800
Message-ID: <4D885CDF.6000206@viatech.com.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from exchtp08.via.com.tw (exchtp08.via.com.tw [61.66.243.7])
	by alsa0.perex.cz (Postfix) with ESMTP id 83CFC1038FD
	for <alsa-devel@alsa-project.org>; Tue, 22 Mar 2011 09:25:08 +0100 (CET)
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
Cc: tiwai@suse.de, HaraldWelte@viatech.com, lydiawang@viatech.com.cn
List-Id: alsa-devel@alsa-project.org

From: Lydia Wang <lydiawang@viatech.com.cn>
Subject: ALSA: VIA HDA: Get codec's type in via_new_spec() function.

Add get_codec_type() in via_new_spec() function to make sure getting
correct codec type before building mixer controls.

Signed-off-by: Lydia Wang <lydiawang@viatech.com.cn>
---
 sound/pci/hda/patch_via.c |    9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

--- a/sound/pci/hda/patch_via.c
+++ b/sound/pci/hda/patch_via.c
@@ -159,6 +159,7 @@
 #endif
 };
 
+static enum VIA_HDA_CODEC get_codec_type(struct hda_codec *codec);
 static struct via_spec * via_new_spec(struct hda_codec *codec)
 {
 	struct via_spec *spec;
@@ -169,6 +170,10 @@
 
 	codec->spec = spec;
 	spec->codec = codec;
+	spec->codec_type = get_codec_type(codec);
+	/* VT1708BCE & VT1708S are almost same */
+	if (spec->codec_type == VT1708BCE)
+		spec->codec_type = VT1708S;
 	return spec;
 }
 
@@ -2203,10 +2208,6 @@
 	for (i = 0; i < spec->num_iverbs; i++)
 		snd_hda_sequence_write(codec, spec->init_verbs[i]);
 
-	spec->codec_type = get_codec_type(codec);
-	if (spec->codec_type == VT1708BCE)
-		spec->codec_type = VT1708S; /* VT1708BCE & VT1708S are almost
-					       same */
 	/* Lydia Add for EAPD enable */
 	if (!spec->dig_in_nid) { /* No Digital In connection */
 		if (spec->dig_in_pin) {
