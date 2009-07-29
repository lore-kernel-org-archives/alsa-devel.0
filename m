From: John Bonesio <bones@secretlab.ca>
Subject: [PATCH] ASoC: MPC5200: Support for buffer wrap around
Date: Wed, 29 Jul 2009 08:38:55 -0700
Message-ID: <20090729153844.18131.68062.stgit@riker>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f212.google.com (mail-ew0-f212.google.com
	[209.85.219.212])
	by alsa0.perex.cz (Postfix) with ESMTP id 0453324935
	for <alsa-devel@alsa-project.org>;
	Wed, 29 Jul 2009 17:39:04 +0200 (CEST)
Received: by ewy8 with SMTP id 8so33288ewy.32
	for <alsa-devel@alsa-project.org>; Wed, 29 Jul 2009 08:39:04 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Grant Likely <grant.likely@secretlab.ca>, Jon Smirl <jonsmirl@gmail.com>, Eric Millbrandt <emillbrandt@dekaresearch.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Here's another appl_ptr related patch to the alsa soc mpc5200 ac97 driver. This 
time the patch is to fix a problem with not correctly handling appl_ptr
wrapping back around to the beginning of the buffer.

I haven't yet seen a symptom related to this. This came up when I was chatting
with Jon Smirl about another bug I was examining. Right now there is another
problem that is preventing me from playing really long audio streams. 

Let me know if this is the wrong approach.

- John

The code in psc_dma_bcom_enqueue_tx() didn't account for the fact that
s->runtime->control->appl_ptr can wrap around to the beginning of the
buffer. This change fixes this problem.

Signed-off-by: John Bonesio <bones@secretlab.ca>
---

 sound/soc/fsl/mpc5200_dma.c |   17 +++++++++++++++++
 1 files changed, 17 insertions(+), 0 deletions(-)

diff --git a/sound/soc/fsl/mpc5200_dma.c b/sound/soc/fsl/mpc5200_dma.c
index cfe0ea4..2551c58 100644
--- a/sound/soc/fsl/mpc5200_dma.c
+++ b/sound/soc/fsl/mpc5200_dma.c
@@ -70,6 +70,23 @@ static void psc_dma_bcom_enqueue_next_buffer(struct psc_dma_stream *s)
 
 static void psc_dma_bcom_enqueue_tx(struct psc_dma_stream *s)
 {
+	if (s->appl_ptr > s->runtime->control->appl_ptr) {
+		/*
+		 * In this case s->runtime->control->appl_ptr has wrapped around.
+		 * Play the data to the end of the boundary, then wrap our own
+		 * appl_ptr back around.
+		 */
+		while (s->appl_ptr < s->runtime->boundary) {
+			if (bcom_queue_full(s->bcom_task))
+				return;
+
+			s->appl_ptr += s->period_size;
+
+			psc_dma_bcom_enqueue_next_buffer(s);
+		}
+		s->appl_ptr -= s->runtime->boundary;
+	}
+
 	while (s->appl_ptr < s->runtime->control->appl_ptr) {
 
 		if (bcom_queue_full(s->bcom_task))
