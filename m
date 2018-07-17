From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] ALSA: emu8000: Use swap macro in
	snd_emu8000_sample_new
Date: Tue, 17 Jul 2018 10:06:10 -0500
Message-ID: <20180717150610.GA10577@embeddedor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from gateway33.websitewelcome.com (gateway33.websitewelcome.com
 [192.185.146.68])
 by alsa0.perex.cz (Postfix) with ESMTP id AD8DE267776
 for <alsa-devel@alsa-project.org>; Tue, 17 Jul 2018 17:06:13 +0200 (CEST)
Received: from cm10.websitewelcome.com (cm10.websitewelcome.com [100.42.49.4])
 by gateway33.websitewelcome.com (Postfix) with ESMTP id B7EF038B0
 for <alsa-devel@alsa-project.org>; Tue, 17 Jul 2018 10:06:11 -0500 (CDT)
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
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, "Gustavo A. R. Silva" <gustavo@embededdor.com>
List-Id: alsa-devel@alsa-project.org

Make use of the swap macro and remove unnecessary variable *tmp*. This
makes the code easier to read and maintain.

This code was detected with the help of Coccinelle.

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 sound/isa/sb/emu8000_patch.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/sound/isa/sb/emu8000_patch.c b/sound/isa/sb/emu8000_patch.c
index c2e41d2..d45a6b9 100644
--- a/sound/isa/sb/emu8000_patch.c
+++ b/sound/isa/sb/emu8000_patch.c
@@ -165,11 +165,8 @@ snd_emu8000_sample_new(struct snd_emux *rec, struct snd_sf_sample *sp,
 		return 0;
 
 	/* be sure loop points start < end */
-	if (sp->v.loopstart > sp->v.loopend) {
-		int tmp = sp->v.loopstart;
-		sp->v.loopstart = sp->v.loopend;
-		sp->v.loopend = tmp;
-	}
+	if (sp->v.loopstart > sp->v.loopend)
+		swap(sp->v.loopstart, sp->v.loopend);
 
 	/* compute true data size to be loaded */
 	truesize = sp->v.size;
-- 
2.7.4
