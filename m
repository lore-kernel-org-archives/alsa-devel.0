From: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
Subject: [PATCH] ALSA: HDA: fix a mask
Date: Tue, 11 Jun 2019 19:09:07 +0200
Message-ID: <20190611170907.trlfzwdar3xydc5f@debian.ka.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 36871F896F1
 for <alsa-devel@alsa-project.org>; Tue, 11 Jun 2019 19:09:38 +0200 (CEST)
Content-Disposition: inline
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

Response tag only occupies 6 bits, not 7. This bug is harmless, since
the value has just been shifted to the right by 26 bits, so this is
only a cosmetic fix.

Signed-off-by: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
---
 sound/pci/hda/hda_jack.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/pci/hda/hda_jack.c b/sound/pci/hda/hda_jack.c
index 74b4695..60a5485 100644
--- a/sound/pci/hda/hda_jack.c
+++ b/sound/pci/hda/hda_jack.c
@@ -563,7 +563,7 @@ static void call_jack_callback(struct hda_codec *codec, unsigned int res,
 void snd_hda_jack_unsol_event(struct hda_codec *codec, unsigned int res)
 {
 	struct hda_jack_tbl *event;
-	int tag = (res >> AC_UNSOL_RES_TAG_SHIFT) & 0x7f;
+	int tag = (res & AC_UNSOL_RES_TAG) >> AC_UNSOL_RES_TAG_SHIFT;
 
 	event = snd_hda_jack_tbl_get_from_tag(codec, tag);
 	if (!event)
-- 
1.9.3
