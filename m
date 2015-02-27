From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 1/9] ALSA: hda - Split snd_hda_build_pcms()
Date: Fri, 27 Feb 2015 23:55:36 +0100
Message-ID: <1425077744-4553-2-git-send-email-tiwai@suse.de>
References: <1425077744-4553-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id B7FC02651D2
 for <alsa-devel@alsa-project.org>; Fri, 27 Feb 2015 23:55:49 +0100 (CET)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 614E4ABE8
 for <alsa-devel@alsa-project.org>; Fri, 27 Feb 2015 22:55:46 +0000 (UTC)
In-Reply-To: <1425077744-4553-1-git-send-email-tiwai@suse.de>
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

snd_hda_build_pcms() does actually three things: let the codec driver
build up hda_pcm list, set the PCM default values, and call the
attach_pcm bus ops for each hda_pcm instance.  The former two are
basically independent from the bus implementation, so it'd make the
code a bit more readable.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/hda_codec.c | 102 +++++++++++++++++++++++++++-------------------
 sound/pci/hda/hda_codec.h |   1 +
 2 files changed, 60 insertions(+), 43 deletions(-)

diff --git a/sound/pci/hda/hda_codec.c b/sound/pci/hda/hda_codec.c
index 26d45268647d..a6e49e446f8d 100644
--- a/sound/pci/hda/hda_codec.c
+++ b/sound/pci/hda/hda_codec.c
@@ -4118,71 +4118,87 @@ static int get_empty_pcm_device(struct hda_bus *bus, unsigned int type)
 	return -EAGAIN;
 }
 
-/*
- * attach a new PCM stream
- */
-static int snd_hda_attach_pcm(struct hda_codec *codec, struct hda_pcm *pcm)
+/* call build_pcms ops of the given codec and set up the default parameters */
+int snd_hda_codec_parse_pcms(struct hda_codec *codec)
 {
-	struct hda_bus *bus = codec->bus;
-	struct hda_pcm_stream *info;
-	int stream, err;
+	unsigned int pcm;
+	int err;
 
-	if (snd_BUG_ON(!pcm->name))
-		return -EINVAL;
-	for (stream = 0; stream < 2; stream++) {
-		info = &pcm->stream[stream];
-		if (info->substreams) {
+	if (codec->num_pcms)
+		return 0; /* already parsed */
+
+	if (!codec->patch_ops.build_pcms)
+		return 0;
+
+	err = codec->patch_ops.build_pcms(codec);
+	if (err < 0) {
+		codec_err(codec, "cannot build PCMs for #%d (error %d)\n",
+			  codec->addr, err);
+		return err;
+	}
+
+	for (pcm = 0; pcm < codec->num_pcms; pcm++) {
+		struct hda_pcm *cpcm = &codec->pcm_info[pcm];
+		int stream;
+
+		for (stream = 0; stream < 2; stream++) {
+			struct hda_pcm_stream *info = &cpcm->stream[stream];
+
+			if (!info->substreams)
+				continue;
+			if (snd_BUG_ON(!cpcm->name))
+				return -EINVAL;
 			err = set_pcm_default_values(codec, info);
-			if (err < 0)
+			if (err < 0) {
+				codec_warn(codec,
+					   "fail to setup default for PCM %s\n",
+					   cpcm->name);
 				return err;
+			}
 		}
 	}
-	return bus->ops.attach_pcm(bus, codec, pcm);
+
+	return 0;
 }
 
 /* assign all PCMs of the given codec */
 int snd_hda_codec_build_pcms(struct hda_codec *codec)
 {
+	struct hda_bus *bus = codec->bus;
 	unsigned int pcm;
-	int err;
+	int dev, err;
 
-	if (!codec->num_pcms) {
-		if (!codec->patch_ops.build_pcms)
-			return 0;
-		err = codec->patch_ops.build_pcms(codec);
-		if (err < 0) {
-			codec_err(codec,
-				  "cannot build PCMs for #%d (error %d)\n",
-				  codec->addr, err);
-			err = snd_hda_codec_reset(codec);
-			if (err < 0) {
-				codec_err(codec,
-					  "cannot revert codec\n");
-				return err;
-			}
-		}
+	if (snd_BUG_ON(!bus->ops.attach_pcm))
+		return -EINVAL;
+
+	err = snd_hda_codec_parse_pcms(codec);
+	if (err < 0) {
+		snd_hda_codec_reset(codec);
+		return err;
 	}
+
+	/* attach a new PCM streams */
 	for (pcm = 0; pcm < codec->num_pcms; pcm++) {
 		struct hda_pcm *cpcm = &codec->pcm_info[pcm];
-		int dev;
 
+		if (cpcm->pcm)
+			continue; /* already attached */
 		if (!cpcm->stream[0].substreams && !cpcm->stream[1].substreams)
 			continue; /* no substreams assigned */
 
-		if (!cpcm->pcm) {
-			dev = get_empty_pcm_device(codec->bus, cpcm->pcm_type);
-			if (dev < 0)
-				continue; /* no fatal error */
-			cpcm->device = dev;
-			err = snd_hda_attach_pcm(codec, cpcm);
-			if (err < 0) {
-				codec_err(codec,
-					  "cannot attach PCM stream %d for codec #%d\n",
-					  dev, codec->addr);
-				continue; /* no fatal error */
-			}
+		dev = get_empty_pcm_device(bus, cpcm->pcm_type);
+		if (dev < 0)
+			continue; /* no fatal error */
+		cpcm->device = dev;
+		err =  bus->ops.attach_pcm(bus, codec, cpcm);
+		if (err < 0) {
+			codec_err(codec,
+				  "cannot attach PCM stream %d for codec #%d\n",
+				  dev, codec->addr);
+			continue; /* no fatal error */
 		}
 	}
+
 	return 0;
 }
 
diff --git a/sound/pci/hda/hda_codec.h b/sound/pci/hda/hda_codec.h
index 634d07c2634b..fff3603bfff5 100644
--- a/sound/pci/hda/hda_codec.h
+++ b/sound/pci/hda/hda_codec.h
@@ -490,6 +490,7 @@ int snd_hda_codec_build_controls(struct hda_codec *codec);
  * PCM
  */
 int snd_hda_build_pcms(struct hda_bus *bus);
+int snd_hda_codec_parse_pcms(struct hda_codec *codec);
 int snd_hda_codec_build_pcms(struct hda_codec *codec);
 
 int snd_hda_codec_prepare(struct hda_codec *codec,
-- 
2.3.0
