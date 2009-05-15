From: Alexander Beregalov <a.beregalov@gmail.com>
Subject: [PATCH] parisc/harmony: fix printk format warning
Date: Fri, 15 May 2009 18:00:38 +0400
Message-ID: <1242396038-20179-1-git-send-email-a.beregalov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f223.google.com (mail-ew0-f223.google.com
	[209.85.219.223])
	by alsa0.perex.cz (Postfix) with ESMTP id 64616103992
	for <alsa-devel@alsa-project.org>;
	Fri, 15 May 2009 16:01:01 +0200 (CEST)
Received: by ewy23 with SMTP id 23so2462774ewy.32
	for <alsa-devel@alsa-project.org>; Fri, 15 May 2009 07:00:57 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de, alsa-devel@alsa-project.org
Cc: Alexander Beregalov <a.beregalov@gmail.com>
List-Id: alsa-devel@alsa-project.org

Fix this warning:
sound/parisc/harmony.c:938: warning: format '%lx' expects type 'long unsigned int',
but argument 2 has type 'resource_size_t'

Signed-off-by: Alexander Beregalov <a.beregalov@gmail.com>
---
 sound/parisc/harmony.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/parisc/harmony.c b/sound/parisc/harmony.c
index 6055fd6..63ae0f9 100644
--- a/sound/parisc/harmony.c
+++ b/sound/parisc/harmony.c
@@ -935,7 +935,7 @@ snd_harmony_create(struct snd_card *card,
 	h->iobase = ioremap_nocache(padev->hpa.start, HARMONY_SIZE);
 	if (h->iobase == NULL) {
 		printk(KERN_ERR PFX "unable to remap hpa 0x%lx\n",
-		       padev->hpa.start);
+		       (unsigned long)padev->hpa.start);
 		err = -EBUSY;
 		goto free_and_ret;
 	}
-- 
1.6.2.5
