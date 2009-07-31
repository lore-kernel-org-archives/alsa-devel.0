From: John Bonesio <bones@secretlab.ca>
Subject: [PATCH] ASoC: MPC5200: Support for buffer wrap around
Date: Fri, 31 Jul 2009 16:08:55 -0700
Message-ID: <20090731230311.17686.46431.stgit@riker>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-px0-f192.google.com (mail-px0-f192.google.com
	[209.85.216.192])
	by alsa0.perex.cz (Postfix) with ESMTP id AB85E24755
	for <alsa-devel@alsa-project.org>;
	Sat,  1 Aug 2009 01:09:08 +0200 (CEST)
Received: by pxi30 with SMTP id 30so1517027pxi.16
	for <alsa-devel@alsa-project.org>; Fri, 31 Jul 2009 16:09:07 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Grant Likely <grant.likely@secretlab.ca>, Jon Smirl <jonsmirl@gmail.com>, Eric Millbrandt <emillbrandt@dekaresearch.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, alsa-devel
List-Id: alsa-devel@alsa-project.org

We've encountered strange behavior in the alsamixer settings using the wm9712
codec. If we unmute the headphone output and then unmute the PCM output, the
headphone output gets reset to mute in the hardware register. At this point
the hardware register does not match the value in the register cache.

I've spent some time debugging this, and the headphone setting is set outside
of any code path that would call the ac97_write() routine. As best as I can
tell, there is something strange going on in hardware.

I've provided this patch that works around the problem.

Have any of you seen this before? Is this patch the right approach?

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
