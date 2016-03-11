From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH 1/4] ASoC: compress: Pass error out of
 soc_compr_pointer
Date: Fri, 11 Mar 2016 16:44:28 +0530
Message-ID: <20160311111428.GB11154@localhost>
References: <1457606694-10985-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
 <20160311074843.GV11154@localhost>
 <20160311100425.GH1490@localhost.localdomain>
 <20160311103747.GZ11154@localhost> <s5hbn6l5meo.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id 885A326655C
 for <alsa-devel@alsa-project.org>; Fri, 11 Mar 2016 12:10:17 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <s5hbn6l5meo.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, broonie@kernel.org, lgirdwood@gmail.com, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On Fri, Mar 11, 2016 at 11:39:11AM +0100, Takashi Iwai wrote:
> On Fri, 11 Mar 2016 11:37:47 +0100,
> Vinod Koul wrote:
> > 
> > On Fri, Mar 11, 2016 at 10:04:25AM +0000, Charles Keepax wrote:
> > > On Fri, Mar 11, 2016 at 01:18:43PM +0530, Vinod Koul wrote:
> > > > On Thu, Mar 10, 2016 at 10:44:51AM +0000, Charles Keepax wrote:
> > > > > The soc_compr_pointer does not correctly pass any errors returned by the
> > > > > driver callback back up the stack. This patch corrects this issue.
> > > > 
> > > > Should we do that :) I am not too sure. Pointer query is supposed to read
> > > > the current value and return. You are trying to indicate that stream has
> > > > gone bad which is not the same as read faced an error...
> > > > 
> > > > Also please use cover letter for these things to describe problem you are
> > > > trying to solve.
> > > 
> > > Apologies for not doing so, I had been viewing this as more of a
> > > simple oversight in the framework rather than a design choice.
> > > 
> > > The problem I am looking at is the DSP suffers an unrecoverable
> > > error. We can find out about this error in our driver because the
> > > DSP returns some error status to us.  This is fine if user-space
> > > is doing a read as reads return error status back to user-space
> > > so the user can find out that things have gone bad. However, if
> > > user-space is doing an avail request there is no path for the
> > > error to come back up to user-space. The pointer request returns
> > > zero available data, so a read never happens and we basically
> > > just end up sitting waiting for data on a stream that we know
> > > full well has died.
> > 
> > So this confirms my hunch and we should then notify core of error by stopping
> > the stream properly and then return error on poll/pointer query.
> > 
> > So cna try this untested patch, whcih includes a hack for stopped state. We
> > don't seem to have a stopped state in ALSA, that bit would need refinement
> 
> In PCM, the stopped state is either SETUP/PREPARE or XRUN.

We didn't use PREPARE so we can set to XRUN. So here is alternate patch for
this, whcih looks much better :)

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
index 18b8dc45bb8f..5d2a4d30eb6e 100644
--- a/sound/core/compress_offload.c
+++ b/sound/core/compress_offload.c
@@ -224,6 +224,14 @@ snd_compr_ioctl_avail(struct snd_compr_stream *stream, unsigned long arg)
 	struct snd_compr_avail ioctl_avail;
 	size_t avail;
 
+	mutex_lock(&stream->device->lock);
+	if (stream->runtime->state == SNDRV_PCM_STATE_OPEN ||
+			stream->runtime->state == SNDRV_PCM_STATE_XRUN) {
+		mutex_unlock(&stream->device->lock);
+		return -EBADFD;
+	}
+	mutex_unlock(&stream->device->lock);
+
 	avail = snd_compr_calc_avail(stream, &ioctl_avail);
 	ioctl_avail.avail = avail;
 
@@ -386,7 +394,8 @@ static unsigned int snd_compr_poll(struct file *f, poll_table *wait)
 		return -EFAULT;
 
 	mutex_lock(&stream->device->lock);
-	if (stream->runtime->state == SNDRV_PCM_STATE_OPEN) {
+	if (stream->runtime->state == SNDRV_PCM_STATE_OPEN ||
+			stream->runtime->state == SNDRV_PCM_STATE_XRUN) {
 		retval = -EBADFD;
 		goto out;
 	}
@@ -669,7 +678,7 @@ static int snd_compr_start(struct snd_compr_stream *stream)
 	return retval;
 }
 
-static int snd_compr_stop(struct snd_compr_stream *stream)
+static int _snd_compr_stop(struct snd_compr_stream *stream)
 {
 	int retval;
 
@@ -685,6 +694,20 @@ static int snd_compr_stop(struct snd_compr_stream *stream)
 	return retval;
 }
 
+int snd_compr_stop(struct snd_compr_stream *stream)
+{
+	int ret = _snd_compr_stop(stream);
+
+	if (ret) {
+		mutex_lock(&stream->device->lock);
+		stream->runtime->state = SNDRV_PCM_STATE_XRUN;
+		mutex_unlock(&stream->device->lock);
+	}
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(snd_compr_stop);
+
 static int snd_compress_wait_for_drain(struct snd_compr_stream *stream)
 {
 	int ret;
@@ -832,7 +855,7 @@ static long snd_compr_ioctl(struct file *f, unsigned int cmd, unsigned long arg)
 		retval = snd_compr_start(stream);
 		break;
 	case _IOC_NR(SNDRV_COMPRESS_STOP):
-		retval = snd_compr_stop(stream);
+		retval = _snd_compr_stop(stream);
 		break;
 	case _IOC_NR(SNDRV_COMPRESS_DRAIN):
 		retval = snd_compr_drain(stream);


-- 
~Vinod
