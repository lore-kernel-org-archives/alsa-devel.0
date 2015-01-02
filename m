From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 2/2] ALSA: ps3: Remove unnecessary
	snd_pcm_lib_preallocate_free_for_all()
Date: Fri,  2 Jan 2015 15:03:43 +0100
Message-ID: <1420207423-10184-2-git-send-email-lars@metafoo.de>
References: <1420207423-10184-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-239.synserver.de (smtp-out-243.synserver.de
 [212.40.185.243])
 by alsa0.perex.cz (Postfix) with ESMTP id 226CD260504
 for <alsa-devel@alsa-project.org>; Fri,  2 Jan 2015 15:03:49 +0100 (CET)
In-Reply-To: <1420207423-10184-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>
Cc: Geoff Levand <geoff@infradead.org>, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Clemens Ladisch <clemens@ladisch.de>
List-Id: alsa-devel@alsa-project.org

The ALSA core takes care that all preallocated memory is freed when the card
(and the PCM) itself is freed. There is no need to do this manually in the
driver.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/ppc/snd_ps3.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/sound/ppc/snd_ps3.c b/sound/ppc/snd_ps3.c
index 58f292a..3682425 100644
--- a/sound/ppc/snd_ps3.c
+++ b/sound/ppc/snd_ps3.c
@@ -1044,7 +1044,7 @@ static int snd_ps3_driver_probe(struct ps3_system_bus_device *dev)
 	if (!the_card.null_buffer_start_vaddr) {
 		pr_info("%s: nullbuffer alloc failed\n", __func__);
 		ret = -ENOMEM;
-		goto clean_preallocate;
+		goto clean_card;
 	}
 	pr_debug("%s: null vaddr=%p dma=%#llx\n", __func__,
 		 the_card.null_buffer_start_vaddr,
@@ -1066,8 +1066,6 @@ clean_dma_map:
 			  PAGE_SIZE,
 			  the_card.null_buffer_start_vaddr,
 			  the_card.null_buffer_start_dma_addr);
-clean_preallocate:
-	snd_pcm_lib_preallocate_free_for_all(the_card.pcm);
 clean_card:
 	snd_card_free(the_card.card);
 clean_irq:
-- 
1.8.0
