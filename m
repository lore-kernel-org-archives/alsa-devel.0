From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH 1/4] ASoC: compress: Pass error out of
	soc_compr_pointer
Date: Fri, 11 Mar 2016 16:07:47 +0530
Message-ID: <20160311103747.GZ11154@localhost>
References: <1457606694-10985-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
 <20160311074843.GV11154@localhost>
 <20160311100425.GH1490@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 754C32606A9
 for <alsa-devel@alsa-project.org>; Fri, 11 Mar 2016 11:33:35 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20160311100425.GH1490@localhost.localdomain>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com, tiwai@suse.com, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

On Fri, Mar 11, 2016 at 10:04:25AM +0000, Charles Keepax wrote:
> On Fri, Mar 11, 2016 at 01:18:43PM +0530, Vinod Koul wrote:
> > On Thu, Mar 10, 2016 at 10:44:51AM +0000, Charles Keepax wrote:
> > > The soc_compr_pointer does not correctly pass any errors returned by the
> > > driver callback back up the stack. This patch corrects this issue.
> > 
> > Should we do that :) I am not too sure. Pointer query is supposed to read
> > the current value and return. You are trying to indicate that stream has
> > gone bad which is not the same as read faced an error...
> > 
> > Also please use cover letter for these things to describe problem you are
> > trying to solve.
> 
> Apologies for not doing so, I had been viewing this as more of a
> simple oversight in the framework rather than a design choice.
> 
> The problem I am looking at is the DSP suffers an unrecoverable
> error. We can find out about this error in our driver because the
> DSP returns some error status to us.  This is fine if user-space
> is doing a read as reads return error status back to user-space
> so the user can find out that things have gone bad. However, if
> user-space is doing an avail request there is no path for the
> error to come back up to user-space. The pointer request returns
> zero available data, so a read never happens and we basically
> just end up sitting waiting for data on a stream that we know
> full well has died.

So this confirms my hunch and we should then notify core of error by stopping
the stream properly and then return error on poll/pointer query.

So cna try this untested patch, whcih includes a hack for stopped state. We
don't seem to have a stopped state in ALSA, that bit would need refinement

-- >8 --

diff --git a/include/sound/compress_driver.h b/include/sound/compress_driver.h
index c0abcdc11470..a42c64248ad7 100644
--- a/include/sound/compress_driver.h
+++ b/include/sound/compress_driver.h
@@ -187,4 +187,5 @@ static inline void snd_compr_drain_notify(struct snd_compr_stream *stream)
 	wake_up(&stream->runtime->sleep);
 }
 
+int snd_compr_stop(struct snd_compr_stream *stream);
 #endif
diff --git a/sound/core/compress_offload.c b/sound/core/compress_offload.c
index 18b8dc45bb8f..5b451a3af1a3 100644
--- a/sound/core/compress_offload.c
+++ b/sound/core/compress_offload.c
@@ -218,12 +218,22 @@ static inline size_t snd_compr_get_avail(struct snd_compr_stream *stream)
 	return snd_compr_calc_avail(stream, &avail);
 }
 
+#define SNDRV_PCM_STATE_STOP 8
+
 static int
 snd_compr_ioctl_avail(struct snd_compr_stream *stream, unsigned long arg)
 {
 	struct snd_compr_avail ioctl_avail;
 	size_t avail;
 
+	mutex_lock(&stream->device->lock);
+	if (stream->runtime->state == SNDRV_PCM_STATE_OPEN ||
+			stream->runtime->state == SNDRV_PCM_STATE_STOP) {
+		mutex_unlock(&stream->device->lock);
+		return -EBADFD;
+	}
+	mutex_unlock(&stream->device->lock);
+
 	avail = snd_compr_calc_avail(stream, &ioctl_avail);
 	ioctl_avail.avail = avail;
 
@@ -386,7 +396,8 @@ static unsigned int snd_compr_poll(struct file *f, poll_table *wait)
 		return -EFAULT;
 
 	mutex_lock(&stream->device->lock);
-	if (stream->runtime->state == SNDRV_PCM_STATE_OPEN) {
+	if (stream->runtime->state == SNDRV_PCM_STATE_OPEN ||
+			stream->runtime->state == SNDRV_PCM_STATE_STOP) {
 		retval = -EBADFD;
 		goto out;
 	}
@@ -669,7 +680,7 @@ static int snd_compr_start(struct snd_compr_stream *stream)
 	return retval;
 }
 
-static int snd_compr_stop(struct snd_compr_stream *stream)
+int snd_compr_stop(struct snd_compr_stream *stream)
 {
 	int retval;
 
@@ -684,6 +695,7 @@ static int snd_compr_stop(struct snd_compr_stream *stream)
 	}
 	return retval;
 }
+EXPORT_SYMBOL_GPL(snd_compr_stop);
 
 static int snd_compress_wait_for_drain(struct snd_compr_stream *stream)
 {


-- 
~Vinod
