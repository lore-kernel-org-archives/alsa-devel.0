From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 2/3] ALSA: hda: Use struct_size()
Date: Fri, 31 May 2019 11:53:20 +0200
Message-ID: <20190531095321.16002-3-tiwai@suse.de>
References: <20190531095321.16002-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 4E2F5F896E5
 for <alsa-devel@alsa-project.org>; Fri, 31 May 2019 11:53:25 +0200 (CEST)
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id 5A5F4B026
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
calculating the hda_conn_list object size with the variable array.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/hda_codec.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/pci/hda/hda_codec.c b/sound/pci/hda/hda_codec.c
index b20eb7fc83eb..d0f1dbcfbda4 100644
--- a/sound/pci/hda/hda_codec.c
+++ b/sound/pci/hda/hda_codec.c
@@ -122,7 +122,7 @@ static int add_conn_list(struct hda_codec *codec, hda_nid_t nid, int len,
 {
 	struct hda_conn_list *p;
 
-	p = kmalloc(sizeof(*p) + len * sizeof(hda_nid_t), GFP_KERNEL);
+	p = kmalloc(struct_size(p, conns, len), GFP_KERNEL);
 	if (!p)
 		return -ENOMEM;
 	p->len = len;
-- 
2.16.4
