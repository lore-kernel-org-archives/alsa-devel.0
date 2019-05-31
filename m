From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 3/3] ALSA: hda/ca0132: Use struct_size()
Date: Fri, 31 May 2019 11:53:21 +0200
Message-ID: <20190531095321.16002-4-tiwai@suse.de>
References: <20190531095321.16002-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 41D9DF8072E
 for <alsa-devel@alsa-project.org>; Fri, 31 May 2019 11:53:25 +0200 (CEST)
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id 663B6B028
 for <alsa-devel@alsa-project.org>; Fri, 31 May 2019 09:53:25 +0000 (UTC)
In-Reply-To: <20190531095321.16002-1-tiwai@suse.de>
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

For code simplification and safety, use struct_size() macro for
calculating the dsp_image_seg object size.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/patch_ca0132.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/pci/hda/patch_ca0132.c b/sound/pci/hda/patch_ca0132.c
index e1ebc6d5f382..de61179c91e2 100644
--- a/sound/pci/hda/patch_ca0132.c
+++ b/sound/pci/hda/patch_ca0132.c
@@ -2731,7 +2731,7 @@ static bool is_last(const struct dsp_image_seg *p)
 
 static size_t dsp_sizeof(const struct dsp_image_seg *p)
 {
-	return sizeof(*p) + p->count*sizeof(u32);
+	return struct_size(p, data, p->count);
 }
 
 static const struct dsp_image_seg *get_next_seg_ptr(
-- 
2.16.4
