From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH] ALSA: Remove transfer_ack_{begin,
	end} callbacks from struct snd_pcm_runtime
Date: Thu, 22 Oct 2015 13:11:56 +0200
Message-ID: <1445512316-25478-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-188.synserver.de (smtp-out-188.synserver.de
 [212.40.185.188])
 by alsa0.perex.cz (Postfix) with ESMTP id 2398A26043C
 for <alsa-devel@alsa-project.org>; Thu, 22 Oct 2015 13:12:10 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.com>, Jaroslav Kysela <perex@perex.cz>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

While there is nothing wrong with the transfer_ack_begin and
transfer_ack_end callbacks per-se, the last documented user was part of the
alsa-driver 0.5.12a package, which was released 14 years ago and even
predates the upstream integration of the ALSA core and has subsequently
been superseded by newer alsa-driver releases.

This seems to indicate that there is no need for having these callbacks and
they are just cruft that can be removed.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 Documentation/DocBook/writing-an-alsa-driver.tmpl | 19 ++-----------------
 include/sound/pcm.h                               |  4 ----
 sound/core/pcm_lib.c                              |  5 -----
 3 files changed, 2 insertions(+), 26 deletions(-)

diff --git a/Documentation/DocBook/writing-an-alsa-driver.tmpl b/Documentation/DocBook/writing-an-alsa-driver.tmpl
index 84ef6a9..a27ab9f5 100644
--- a/Documentation/DocBook/writing-an-alsa-driver.tmpl
+++ b/Documentation/DocBook/writing-an-alsa-driver.tmpl
@@ -2181,10 +2181,6 @@ struct _snd_pcm_runtime {
 	struct snd_pcm_hardware hw;
 	struct snd_pcm_hw_constraints hw_constraints;
 
-	/* -- interrupt callbacks -- */
-	void (*transfer_ack_begin)(struct snd_pcm_substream *substream);
-	void (*transfer_ack_end)(struct snd_pcm_substream *substream);
-
 	/* -- timer -- */
 	unsigned int timer_resolution;	/* timer resolution */
 
@@ -2209,9 +2205,8 @@ struct _snd_pcm_runtime {
 	  For the operators (callbacks) of each sound driver, most of
 	these records are supposed to be read-only.  Only the PCM
 	middle-layer changes / updates them.  The exceptions are
-	the hardware description (hw), interrupt callbacks
-	(transfer_ack_xxx), DMA buffer information, and the private
-	data.  Besides, if you use the standard buffer allocation
+	the hardware description (hw) DMA buffer information and the
+	private data.  Besides, if you use the standard buffer allocation
 	method via <function>snd_pcm_lib_malloc_pages()</function>,
 	you don't need to set the DMA buffer information by yourself.
 	</para>
@@ -2538,16 +2533,6 @@ struct _snd_pcm_runtime {
         </para>
 	</section>
 
-	<section id="pcm-interface-runtime-intr">
-	<title>Interrupt Callbacks</title>
-	<para>
-	The field <structfield>transfer_ack_begin</structfield> and
-	<structfield>transfer_ack_end</structfield> are called at
-	the beginning and at the end of
-	<function>snd_pcm_period_elapsed()</function>, respectively. 
-	</para>
-	</section>
-
     </section>
 
     <section id="pcm-interface-operators">
diff --git a/include/sound/pcm.h b/include/sound/pcm.h
index 2882ddd..3e0ffd2 100644
--- a/include/sound/pcm.h
+++ b/include/sound/pcm.h
@@ -402,10 +402,6 @@ struct snd_pcm_runtime {
 	struct snd_pcm_hardware hw;
 	struct snd_pcm_hw_constraints hw_constraints;
 
-	/* -- interrupt callbacks -- */
-	void (*transfer_ack_begin)(struct snd_pcm_substream *substream);
-	void (*transfer_ack_end)(struct snd_pcm_substream *substream);
-
 	/* -- timer -- */
 	unsigned int timer_resolution;	/* timer resolution */
 	int tstamp_type;		/* timestamp type */
diff --git a/sound/core/pcm_lib.c b/sound/core/pcm_lib.c
index 6dc4277..05a3ca9 100644
--- a/sound/core/pcm_lib.c
+++ b/sound/core/pcm_lib.c
@@ -1875,9 +1875,6 @@ void snd_pcm_period_elapsed(struct snd_pcm_substream *substream)
 		return;
 	runtime = substream->runtime;
 
-	if (runtime->transfer_ack_begin)
-		runtime->transfer_ack_begin(substream);
-
 	snd_pcm_stream_lock_irqsave(substream, flags);
 	if (!snd_pcm_running(substream) ||
 	    snd_pcm_update_hw_ptr0(substream, 1) < 0)
@@ -1889,8 +1886,6 @@ void snd_pcm_period_elapsed(struct snd_pcm_substream *substream)
 #endif
  _end:
 	snd_pcm_stream_unlock_irqrestore(substream, flags);
-	if (runtime->transfer_ack_end)
-		runtime->transfer_ack_end(substream);
 	kill_fasync(&runtime->fasync, SIGIO, POLL_IN);
 }
 
-- 
2.1.4
