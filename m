From: Wang YanQing <udknight@gmail.com>
Subject: [PATCH] ALSA: hda: Fix forget to free resource in
 error handling code path in hda_codec_driver_probe
Date: Sun, 3 Sep 2017 22:11:22 +0800
Message-ID: <20170903141122.GA2848@udknight>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pg0-f66.google.com (mail-pg0-f66.google.com [74.125.83.66])
 by alsa0.perex.cz (Postfix) with ESMTP id E118C266E25
 for <alsa-devel@alsa-project.org>; Sun,  3 Sep 2017 16:11:27 +0200 (CEST)
Received: by mail-pg0-f66.google.com with SMTP id t193so2959897pgc.4
 for <alsa-devel@alsa-project.org>; Sun, 03 Sep 2017 07:11:27 -0700 (PDT)
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

When hda_codec_driver_probe meet error and return failure, we need
to free resource with patch_ops.free, or we will get resource leak.

Signed-off-by: Wang YanQing <udknight@gmail.com>
---
 sound/pci/hda/hda_bind.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/pci/hda/hda_bind.c b/sound/pci/hda/hda_bind.c
index 6efadbf..f1b1b7e 100644
--- a/sound/pci/hda/hda_bind.c
+++ b/sound/pci/hda/hda_bind.c
@@ -123,6 +123,8 @@ static int hda_codec_driver_probe(struct device *dev)
 	module_put(owner);
 
  error:
+	if (codec->patch_ops.free)
+		codec->patch_ops.free(codec);
 	snd_hda_codec_cleanup_for_unbind(codec);
 	return err;
 }
-- 
1.8.5.6.2.g3d8a54e.dirty
