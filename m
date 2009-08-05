From: John Bonesio <bones@secretlab.ca>
Subject: Re: [PATCH] ASoC: MPC5200: Support for buffer wrap
	around
Date: Wed, 05 Aug 2009 09:44:32 -0700
Message-ID: <1249490672.4582.65.camel@riker>
References: <20090729153844.18131.68062.stgit@riker>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-D7TcNx246dz2g/fqLr/C"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wf-out-1314.google.com (wf-out-1314.google.com [209.85.200.170])
	by alsa0.perex.cz (Postfix) with ESMTP id 7D3D7244E1
	for <alsa-devel@alsa-project.org>;
	Wed,  5 Aug 2009 18:44:41 +0200 (CEST)
Received: by wf-out-1314.google.com with SMTP id 24so49755wfg.23
	for <alsa-devel@alsa-project.org>; Wed, 05 Aug 2009 09:44:40 -0700 (PDT)
In-Reply-To: <20090729153844.18131.68062.stgit@riker>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Grant Likely <grant.likely@secretlab.ca>, alsa-devel@alsa-project.org, Eric Millbrandt <emillbrandt@dekaresearch.com>
List-Id: alsa-devel@alsa-project.org


--=-D7TcNx246dz2g/fqLr/C
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi Mark,

This is another patch for ALSA on the MPC5200 that was sent to the ALSA
devel list. I'm not sure if you noticed it.

Since I've submitted the patch to the list, we've been able to test it,
and audio continues to play right through appl_ptr wrapping back around
to the beginning of the buffer.

I've attached the patch, for your convenience.

- John

On Wed, 2009-07-29 at 08:38 -0700, John Bonesio wrote:
> Here's another appl_ptr related patch to the alsa soc mpc5200 ac97 driver. This 
> time the patch is to fix a problem with not correctly handling appl_ptr
> wrapping back around to the beginning of the buffer.
> 
> I haven't yet seen a symptom related to this. This came up when I was chatting
> with Jon Smirl about another bug I was examining. Right now there is another
> problem that is preventing me from playing really long audio streams. 
> 
> Let me know if this is the wrong approach.
> 
> - John
> 
> The code in psc_dma_bcom_enqueue_tx() didn't account for the fact that
> s->runtime->control->appl_ptr can wrap around to the beginning of the
> buffer. This change fixes this problem.
> 
> Signed-off-by: John Bonesio <bones@secretlab.ca>
> ---
> 
>  sound/soc/fsl/mpc5200_dma.c |   17 +++++++++++++++++
>  1 files changed, 17 insertions(+), 0 deletions(-)
> 
> diff --git a/sound/soc/fsl/mpc5200_dma.c b/sound/soc/fsl/mpc5200_dma.c
> index cfe0ea4..2551c58 100644
> --- a/sound/soc/fsl/mpc5200_dma.c
> +++ b/sound/soc/fsl/mpc5200_dma.c
> @@ -70,6 +70,23 @@ static void psc_dma_bcom_enqueue_next_buffer(struct psc_dma_stream *s)
>  
>  static void psc_dma_bcom_enqueue_tx(struct psc_dma_stream *s)
>  {
> +	if (s->appl_ptr > s->runtime->control->appl_ptr) {
> +		/*
> +		 * In this case s->runtime->control->appl_ptr has wrapped around.
> +		 * Play the data to the end of the boundary, then wrap our own
> +		 * appl_ptr back around.
> +		 */
> +		while (s->appl_ptr < s->runtime->boundary) {
> +			if (bcom_queue_full(s->bcom_task))
> +				return;
> +
> +			s->appl_ptr += s->period_size;
> +
> +			psc_dma_bcom_enqueue_next_buffer(s);
> +		}
> +		s->appl_ptr -= s->runtime->boundary;
> +	}
> +
>  	while (s->appl_ptr < s->runtime->control->appl_ptr) {
>  
>  		if (bcom_queue_full(s->bcom_task))
> 

--=-D7TcNx246dz2g/fqLr/C
Content-Disposition: attachment; filename="0001-ASoC-MPC5200-Support-for-buffer-wrap-around.patch"
Content-Type: text/x-patch; name="0001-ASoC-MPC5200-Support-for-buffer-wrap-around.patch"; charset="UTF-8"
Content-Transfer-Encoding: 7bit

>From 4df451365d98bd33b27fc61896fad32bcbc5692b Mon Sep 17 00:00:00 2001
From: John Bonesio <bones@secretlab.ca>
Date: Tue, 28 Jul 2009 15:51:07 -0700
Subject: [PATCH] ASoC: MPC5200: Support for buffer wrap around

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
-- 
1.6.0.4


--=-D7TcNx246dz2g/fqLr/C
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--=-D7TcNx246dz2g/fqLr/C--
