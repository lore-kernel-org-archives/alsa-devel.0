From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 1/3] ALSA: hda - Drop explicit memset() by
	reallocation with __GFP_ZERO
Date: Wed, 13 Mar 2013 17:42:37 +0100
Message-ID: <1363192959-11917-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 5439926197B
 for <alsa-devel@alsa-project.org>; Wed, 13 Mar 2013 17:42:39 +0100 (CET)
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 388A8A4F01
 for <alsa-devel@alsa-project.org>; Wed, 13 Mar 2013 17:42:39 +0100 (CET)
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
 sound/pci/hda/hda_codec.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/sound/pci/hda/hda_codec.c b/sound/pci/hda/hda_codec.c
index 04b5738..a1c5053 100644
--- a/sound/pci/hda/hda_codec.c
+++ b/sound/pci/hda/hda_codec.c
@@ -5539,10 +5539,9 @@ void *snd_array_new(struct snd_array *array)
 		void *nlist;
 		if (snd_BUG_ON(num >= 4096))
 			return NULL;
-		nlist = krealloc(array->list, size, GFP_KERNEL);
+		nlist = krealloc(array->list, size, GFP_KERNEL | __GFP_ZERO);
 		if (!nlist)
 			return NULL;
-		memset(nlist + oldsize, 0, size - oldsize);
 		array->list = nlist;
 		array->alloced = num;
 	}
-- 
1.8.1.4
