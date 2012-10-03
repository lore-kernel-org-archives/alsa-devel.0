From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: Re: issue of shdma-base library
Date: Wed, 3 Oct 2012 14:33:50 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.1210031414080.26201@axis700.grange>
References: <506A7E48.3060701@jinso.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from moutng.kundenserver.de (moutng.kundenserver.de [212.227.17.9])
 by alsa0.perex.cz (Postfix) with ESMTP id A42A026168C
 for <alsa-devel@alsa-project.org>; Wed,  3 Oct 2012 14:33:53 +0200 (CEST)
In-Reply-To: <506A7E48.3060701@jinso.co.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Do Q.Thang" <dq-thang@jinso.co.jp>
Cc: alsa-devel@alsa-project.org, Shimoda Yoshihiro <yoshihiro.shimoda.uh@renesas.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>, Morimoto Kuninori <kuninori.morimoto.gx@renesas.com>
List-Id: alsa-devel@alsa-project.org

Subject: [PATCH] ASoC: fsi: don't reschedule DMA from an atomic context

shdma doesn't support transfer re-scheduling or triggering from callbacks 
or from atomic context. The fsi driver issues DMA transfers from a tasklet 
context, which is a bug. To fix it convert tasklet to a work.

Reported-by: Do Q.Thang <dq-thang@jinso.co.jp>
Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---

Thang-san, Please, check, whether the attached patch fixes your issues. It 
seems to fix them for me.

Mark, please, wait with committing this patch until the guys confirm, it 
really helps. It then will also have to go to 3.6-stable.

Thanks
Guennadi

On Tue, 2 Oct 2012, Do Q.Thang wrote:

> Hi Guennadi-san,
> 
> I'm testing uptream kernel (v3.6-rc3 ~) on the kzm-a9-gt & armadillo-800eva
> board.
> I found 2 issues with the sh-dma driver while testing audio playback.
> 
> issue 1: this log appeared while playback with the aplay, then aplay was
> stopped.
> 
> ------- log -----------------------------
> # aplay audio_s16le_44100.wav
>  Playing WAVE 'audio_s16le_44100.wav' : Signed 16 bit Little Endian, Rate
> 44100 Hz, Stereo
>  aplay: pcm_write:1710: write error: Input/output error
> -----------------------------------------
> 
> issue 2: this log appeared while playback with the aplay, then aplay was
> stopped.
> ( this issue isn't appear on the kzm-a9-gt board only )
> 
> ------- log -----------------------------
> # aplay audio_s16le_44100.wav
>  Playing WAVE 'audio.wav' : Signed 16 bit Little Endian, Rate 44100 Hz, Stereo
>  BUG: scheduling while atomic: kworker/1:1/273/0x00000103
>  aplay: pcm_write:1710: write error: Input/output error
> -----------------------------------------
> 
> I think these issues are introduced by "dmaengine:add an shdma-base library"
> commit.
> 
> ---------- commit -----------------------
> commit 9a7b8e002e331d0599127f16613c32f425a14f2c
> Author: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> Date:   Wed May 9 17:09:13 2012 +0200
> 
>     dmaengine: add an shdma-base library
> 
>     This patch extracts code from shdma.c, that does not directly deal with
>     hardware implementation details and can be re-used with diverse DMA
>     controller variants, found on SH-based SoCs.
> 
>     Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
>     Cc: Sascha Hauer <s.hauer@pengutronix.de>
>     Signed-off-by: Vinod Koul <vinod.koul@linux.intel.com>
> ------------------------------------------
> 
> About issue 1: I found that
> The fsi.c uses fsi_dma_do_tasklet() to setup dma-transfer.This is a function
> of a tasklet.
> When one dma-transfer is finished shdma_chan_ld_cleanup() is called.In this
> function
> __ld_cleanup() is called to cleanup the schan->ld_queue. In behavior of
> __ld_cleanup()
> if descriptor is the last chunk its callback is called, then its node is
> cleanup in the
> next call of __ld_cleanup().In callback of the last descriptor,
> fsi_dma_do_tasklet() is
> scheduled then is called after the shdma_chan_ld_cleanup() is finished.
> But when this issue appear, shdma_chan_ld_cleanup() is called while
> shdma_chan_ld_cleanup()
> is not finished.At that time, schan->ld_queue is not empty, so in
> shdma_tx_submit()
> schan->pm_state is set to SHDMA_PM_PENDING, and then dma-transfer isn't
> started in
> shdma_issue_pending().
> 
> About issue 2:
> I found that this issue is appear when pm_runtime_barrier() is running.
> This issue is not appear when disable CONFIG_PM_RUNTIME config.
> 
> What do you think about these issues?
> 
> Best regards
> ---
> Thang

diff --git a/sound/soc/sh/fsi.c b/sound/soc/sh/fsi.c
index 0540408..1bb0d58c 100644
--- a/sound/soc/sh/fsi.c
+++ b/sound/soc/sh/fsi.c
@@ -20,6 +20,7 @@
 #include <linux/sh_dma.h>
 #include <linux/slab.h>
 #include <linux/module.h>
+#include <linux/workqueue.h>
 #include <sound/soc.h>
 #include <sound/sh_fsi.h>
 
@@ -223,7 +224,7 @@ struct fsi_stream {
 	 */
 	struct dma_chan		*chan;
 	struct sh_dmae_slave	slave; /* see fsi_handler_init() */
-	struct tasklet_struct	tasklet;
+	struct work_struct	work;
 	dma_addr_t		dma;
 };
 
@@ -1085,9 +1086,9 @@ static void fsi_dma_complete(void *data)
 	snd_pcm_period_elapsed(io->substream);
 }
 
-static void fsi_dma_do_tasklet(unsigned long data)
+static void fsi_dma_do_work(struct work_struct *work)
 {
-	struct fsi_stream *io = (struct fsi_stream *)data;
+	struct fsi_stream *io = container_of(work, struct fsi_stream, work);
 	struct fsi_priv *fsi = fsi_stream_to_priv(io);
 	struct snd_soc_dai *dai;
 	struct dma_async_tx_descriptor *desc;
@@ -1129,7 +1130,7 @@ static void fsi_dma_do_tasklet(unsigned long data)
 	 * FIXME
 	 *
 	 * In DMAEngine case, codec and FSI cannot be started simultaneously
-	 * since FSI is using tasklet.
+	 * since FSI is using the scheduler work queue.
 	 * Therefore, in capture case, probably FSI FIFO will have got
 	 * overflow error in this point.
 	 * in that case, DMA cannot start transfer until error was cleared.
@@ -1153,7 +1154,7 @@ static bool fsi_dma_filter(struct dma_chan *chan, void *param)
 
 static int fsi_dma_transfer(struct fsi_priv *fsi, struct fsi_stream *io)
 {
-	tasklet_schedule(&io->tasklet);
+	schedule_work(&io->work);
 
 	return 0;
 }
@@ -1195,14 +1196,14 @@ static int fsi_dma_probe(struct fsi_priv *fsi, struct fsi_stream *io, struct dev
 		return fsi_stream_probe(fsi, dev);
 	}
 
-	tasklet_init(&io->tasklet, fsi_dma_do_tasklet, (unsigned long)io);
+	INIT_WORK(&io->work, fsi_dma_do_work);
 
 	return 0;
 }
 
 static int fsi_dma_remove(struct fsi_priv *fsi, struct fsi_stream *io)
 {
-	tasklet_kill(&io->tasklet);
+	cancel_work_sync(&io->work);
 
 	fsi_stream_stop(fsi, io);
 
