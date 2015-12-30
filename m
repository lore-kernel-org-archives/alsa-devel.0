From: Julia Lawall <Julia.Lawall@lip6.fr>
Subject: [PATCH] ALSA: dummy: constify dummy_timer_ops
	structures
Date: Wed, 30 Dec 2015 12:28:49 +0100
Message-ID: <1451474929-25424-1-git-send-email-Julia.Lawall@lip6.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail2-relais-roc.national.inria.fr
 (mail2-relais-roc.national.inria.fr [192.134.164.83])
 by alsa0.perex.cz (Postfix) with ESMTP id 2D150265960
 for <alsa-devel@alsa-project.org>; Wed, 30 Dec 2015 12:41:32 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>
Cc: alsa-devel@alsa-project.org, kernel-janitors@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

The dummy_timer_ops structures are never modified, so declare them as
const.

Done with the help of Coccinelle.

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

---
 sound/drivers/dummy.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/drivers/dummy.c b/sound/drivers/dummy.c
index 016e451..75b7485 100644
--- a/sound/drivers/dummy.c
+++ b/sound/drivers/dummy.c
@@ -351,7 +351,7 @@ static void dummy_systimer_free(struct snd_pcm_substream *substream)
 	kfree(substream->runtime->private_data);
 }
 
-static struct dummy_timer_ops dummy_systimer_ops = {
+static const struct dummy_timer_ops dummy_systimer_ops = {
 	.create =	dummy_systimer_create,
 	.free =		dummy_systimer_free,
 	.prepare =	dummy_systimer_prepare,
@@ -475,7 +475,7 @@ static void dummy_hrtimer_free(struct snd_pcm_substream *substream)
 	kfree(dpcm);
 }
 
-static struct dummy_timer_ops dummy_hrtimer_ops = {
+static const struct dummy_timer_ops dummy_hrtimer_ops = {
 	.create =	dummy_hrtimer_create,
 	.free =		dummy_hrtimer_free,
 	.prepare =	dummy_hrtimer_prepare,
