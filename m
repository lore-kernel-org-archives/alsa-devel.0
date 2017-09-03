From: Wang YanQing <udknight@gmail.com>
Subject: [PATCH] ALSA: hda: Fix resource leak issue in
 snd_hda_codec_build_controls and snd_hda_codec_parse_pcms
Date: Sun, 3 Sep 2017 23:27:32 +0800
Message-ID: <20170903152731.GA27302@udknight>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pf0-f193.google.com (mail-pf0-f193.google.com
 [209.85.192.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 7E2A4266F0D
 for <alsa-devel@alsa-project.org>; Sun,  3 Sep 2017 17:27:38 +0200 (CEST)
Received: by mail-pf0-f193.google.com with SMTP id g13so2967263pfm.2
 for <alsa-devel@alsa-project.org>; Sun, 03 Sep 2017 08:27:38 -0700 (PDT)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

When patch_ops.init, patch_ops.build_pcms and patch_ops.build_controls
return failure, we need to free resource with patch_ops.free, or we will
get resource leak.

Signed-off-by: Wang YanQing <udknight@gmail.com>
---
 sound/pci/hda/hda_codec.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/sound/pci/hda/hda_codec.c b/sound/pci/hda/hda_codec.c
index df6b57e..4e3e613 100644
--- a/sound/pci/hda/hda_codec.c
+++ b/sound/pci/hda/hda_codec.c
@@ -2973,8 +2973,11 @@ int snd_hda_codec_build_controls(struct hda_codec *codec)
 		err = codec->patch_ops.init(codec);
 	if (!err && codec->patch_ops.build_controls)
 		err = codec->patch_ops.build_controls(codec);
-	if (err < 0)
+	if (err < 0) {
+		if (codec->patch_ops.free)
+			codec->patch_ops.free(codec);
 		return err;
+	}
 
 	/* we create chmaps here instead of build_pcms */
 	err = add_std_chmaps(codec);
@@ -3170,6 +3173,8 @@ int snd_hda_codec_parse_pcms(struct hda_codec *codec)
 	if (err < 0) {
 		codec_err(codec, "cannot build PCMs for #%d (error %d)\n",
 			  codec->core.addr, err);
+		if (codec->patch_ops.free)
+			codec->patch_ops.free(codec);
 		return err;
 	}
 
-- 
1.8.5.6.2.g3d8a54e.dirty
