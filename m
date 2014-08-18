From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 2/6] ALSA: hda - Remove obsoleted
	EXPORT_SYMBOL_HDA() macro
Date: Mon, 18 Aug 2014 17:30:29 +0200
Message-ID: <1408375833-22957-3-git-send-email-tiwai@suse.de>
References: <1408375833-22957-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 3C5E126575F
 for <alsa-devel@alsa-project.org>; Mon, 18 Aug 2014 17:30:36 +0200 (CEST)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id BFF08AD12
 for <alsa-devel@alsa-project.org>; Mon, 18 Aug 2014 15:30:35 +0000 (UTC)
In-Reply-To: <1408375833-22957-1-git-send-email-tiwai@suse.de>
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

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/hda_codec.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/sound/pci/hda/hda_codec.h b/sound/pci/hda/hda_codec.h
index bbc5a1392c75..9c8820f21f94 100644
--- a/sound/pci/hda/hda_codec.h
+++ b/sound/pci/hda/hda_codec.h
@@ -687,6 +687,4 @@ snd_hda_codec_load_dsp_cleanup(struct hda_codec *codec,
 				struct snd_dma_buffer *dmab) {}
 #endif
 
-#define EXPORT_SYMBOL_HDA(sym) EXPORT_SYMBOL_GPL(sym)
-
 #endif /* __SOUND_HDA_CODEC_H */
-- 
2.0.4
