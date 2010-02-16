From: Giuliano Pochini <pochini@shiny.it>
Subject: [PATCH] Echoaudio,
	fix Guru Meditation #00000005.48454C50
Date: Wed, 17 Feb 2010 00:57:44 +0100
Message-ID: <20100217005744.672d6429@Jay>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out26.alice.it (smtp-out26.alice.it [85.33.2.26])
	by alsa0.perex.cz (Postfix) with ESMTP id D25F5103845
	for <alsa-devel@alsa-project.org>; Wed, 17 Feb 2010 00:59:54 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Takashi Iwai <tiwai@suse.de>, Clemens Ladisch <clemens@ladisch.de>
List-Id: alsa-devel@alsa-project.org

(resend: I mistyped the list address)

There is a small window between the hw_params() callback and when
runtime->frame_bits is set by ALSA middle layer. When another substream is
already running, if an interrupt is delivered during that window the irq
handler calls pcm_pointer() which does a division by zero. The patch below
makes the irq handler skip substreams that are initialized but not started
yet. Cc to Clemens Ladisch because he proposed an alternate fix.

For more information, please read the original thread in the linux-kernel
mailing list: http://lkml.org/lkml/2010/2/2/187


Short description: This patch fixes a division by zero error in the irq handler.


Signed-off-by: Giuliano Pochini <pochini@shiny.it>

--- alsa-driver-1.0.22.1/alsa-kernel/pci/echoaudio/echoaudio.c__orig	2010-02-16 22:21:36.000000000 +0100
+++ alsa-driver-1.0.22.1/alsa-kernel/pci/echoaudio/echoaudio.c	2010-02-16 22:21:45.000000000 +0100
@@ -1864,7 +1864,9 @@ static irqreturn_t snd_echo_interrupt(in
 	/* The hardware doesn't tell us which substream caused the irq,
 	thus we have to check all running substreams. */
 	for (ss = 0; ss < DSP_MAXPIPES; ss++) {
-		if ((substream = chip->substream[ss])) {
+		substream = chip->substream[ss];
+		if (substream && ((struct audiopipe *)substream->runtime->
+				private_data)->state == PIPE_STATE_STARTED) {
 			period = pcm_pointer(substream) /
 				substream->runtime->period_size;
 			if (period != chip->last_period[ss]) {


-- 
Giuliano.
