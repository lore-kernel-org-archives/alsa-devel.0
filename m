From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] ALSA: hda - Optimize resume for codecs without
	jack detection
Date: Wed, 17 Jul 2019 15:55:52 +0200
Message-ID: <20190717135552.25825-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 7B4F1F800C4
 for <alsa-devel@alsa-project.org>; Wed, 17 Jul 2019 15:55:53 +0200 (CEST)
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id 60E6AB11A
 for <alsa-devel@alsa-project.org>; Wed, 17 Jul 2019 13:55:53 +0000 (UTC)
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The codecs without jack detection also don't have to be resumed
forcibly because, obviously, they have no jack.  Skip the forced
resume in such a case as optimization as well.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/hda_codec.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/pci/hda/hda_codec.c b/sound/pci/hda/hda_codec.c
index e30e86ca6b72..51f10ed9bc43 100644
--- a/sound/pci/hda/hda_codec.c
+++ b/sound/pci/hda/hda_codec.c
@@ -2942,7 +2942,7 @@ static int hda_codec_runtime_resume(struct device *dev)
 static int hda_codec_force_resume(struct device *dev)
 {
 	struct hda_codec *codec = dev_to_hda_codec(dev);
-	bool forced_resume = !codec->relaxed_resume;
+	bool forced_resume = !codec->relaxed_resume && codec->jacktbl.used;
 	int ret;
 
 	/* The get/put pair below enforces the runtime resume even if the
-- 
2.16.4
