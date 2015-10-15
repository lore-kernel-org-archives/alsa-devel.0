From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] ALSA: hda - Enable widget power saving for
	Cirrus codecs
Date: Thu, 15 Oct 2015 11:20:08 +0200
Message-ID: <1444900808-4893-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 0C9A0265311
 for <alsa-devel@alsa-project.org>; Thu, 15 Oct 2015 11:20:10 +0200 (CEST)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 24C51ABF7
 for <alsa-devel@alsa-project.org>; Thu, 15 Oct 2015 09:20:08 +0000 (UTC)
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

Cirrus codecs have also fine power controls on each widget, thus it
gets benefit from the recent widget power-saving feature.  As we
haven't seen any obvious regressions with tests on some MacBooks,
let's try to enable it.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/patch_cirrus.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/pci/hda/patch_cirrus.c b/sound/pci/hda/patch_cirrus.c
index 85813de26da8..01c464a468f6 100644
--- a/sound/pci/hda/patch_cirrus.c
+++ b/sound/pci/hda/patch_cirrus.c
@@ -570,6 +570,7 @@ static struct cs_spec *cs_alloc_spec(struct hda_codec *codec, int vendor_nid)
 		return NULL;
 	codec->spec = spec;
 	spec->vendor_nid = vendor_nid;
+	codec->power_save_node = 1;
 	snd_hda_gen_spec_init(&spec->gen);
 
 	return spec;
-- 
2.6.1
