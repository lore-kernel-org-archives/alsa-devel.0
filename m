From: GNUtoo <GNUtoo@no-log.org>
Subject: Re: [PATCH] Sound: MSM soc : imported alsa for the MSM
 from codeaurora
Date: Mon, 30 Nov 2009 00:16:42 +0100
Message-ID: <1259536602.3374.129.camel@gnutoo-desktop>
References: <1257435101.25623.1.camel@localhost>
	<1257720370-23012-1-git-send-email-GNUtoo@no-log.org>
	<20091113145050.GC30966@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out13.alice.it (smtp-out13.alice.it [85.33.2.18])
	by alsa0.perex.cz (Postfix) with ESMTP id 17F30103809
	for <alsa-devel@alsa-project.org>; Mon, 30 Nov 2009 00:16:53 +0100 (CET)
In-Reply-To: <20091113145050.GC30966@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, pavel@ucw.cz
List-Id: alsa-devel@alsa-project.org

On Fri, 2009-11-13 at 14:50 +0000, Mark Brown wrote:
> > +                     /* Update with actual sent buffer size */
> > +                     if (prtd->out[idx].used != BUF_INVALID_LEN)
> > +                             prtd->pcm_irq_pos +=
> prtd->out[idx].used;
> > +
> > +                     if (prtd->pcm_irq_pos > prtd->pcm_size)
> > +                             prtd->pcm_irq_pos = prtd->pcm_count;
> 
> This looks suspicious - it looks like what's going on is that you're
> getting a notification from the DSP that it has consumed a data buffer
> but this might go out of bounds and get clamped.

The first time that it's called prtd->out[idx].used = BUF_INVALID_LEN so
it's skipped(it's the same first bogus time than in my previous mails).

The second time prtd->out[idx].used is equal to the period_bytes_max 
which is equal to the .buffer_bytes_max / 2
prtd->pcm_irq_pos is 0 then is incremented to prtd->out[idx].used
So it's clamped only the first time.


By the way I've used that info to skip it in the alsa_send_buffer
so it looks like this:
in alsa_send_buffer I've tried to add a check for the invalid len before
of after the "if (frame->used && prtd->out_needed) {"

here an example of it beeing before "if (frame->used &&
prtd->out_needed) {"
@@ -411,6 +418,10 @@ ssize_t alsa_send_buffer(struct msm_audio *prtd,
const char __user *buf,
 
                spin_lock_irqsave(&the_locks.write_dsp_lock, flag);
                frame = prtd->out + prtd->out_tail;
+               if (frame->used == BUF_INVALID_LEN){
+
spin_unlock_irqrestore(&the_locks.write_dsp_lock, flag);
+                       break;
+               }
                if (frame->used && prtd->out_needed) {
                        audio_dsp_send_buffer(prtd, prtd->out_tail,
                                              frame->used);
@@ -418,10 +429,12 @@ ssize_t alsa_send_buffer(struct msm_audio *prtd,
const char __user *buf,
                        prtd->out_needed--;
                }

                spin_unlock_irqrestore(&the_locks.write_dsp_lock, flag);
for the try where it was after the spin_unlock was not necessary because
it was put just after the spin_unlock

Then...
mplayer said:
alsa-init: got buffersize=19200
alsa-init: got period size 600
and it played a song for half a second
and then the kernel panicked

here the code of mplayer:
      // gets buffersize for control
      if ((err = snd_pcm_hw_params_get_buffer_size(alsa_hwparams,
&bufsize)) < 0)
        {
          mp_msg(MSGT_AO,MSGL_ERR,MSGTR_AO_ALSA_UnableToGetBufferSize,
snd_strerror(err));
          return 0;
        }
      else {
        ao_data.buffersize = bufsize * bytes_per_sample;
          mp_msg(MSGT_AO,MSGL_V,"alsa-init: got buffersize=%i\n",
ao_data.buffersize);
      }

      if ((err = snd_pcm_hw_params_get_period_size(alsa_hwparams,
&chunk_size, NULL)) < 0) {
        mp_msg(MSGT_AO,MSGL_ERR,MSGTR_AO_ALSA_UnableToGetPeriodSize,
snd_strerror(err));
        return 0;
      } else {
        mp_msg(MSGT_AO,MSGL_V,"alsa-init: got period size %li\n",
chunk_size);
      }
      ao_data.outburst = chunk_size * bytes_per_sample;


a strace shows that:

ioctl(0, TIOCGWINSZ, {ws_row=51, ws_col=202, ws_xpixel=0, ws_ypixel=0})
= 0
) = 401, "A:   0.0 (00.0) of 2.0 (02.0) ??"..., 40A:   0.0 (00.0) of 2.0
(02.0) ??,?% 
gettimeofday({1259531032, 572021}, NULL) = 0
select(1, [0], NULL, NULL, {0, 0})      = 0SNDRV_PCM_IOCTL_STATUS
(Timeout)
ioctl(6, 0x806c4120, 0xbee5dac0)        = 0
nanosleep({0, 27000000}, NULL)          = 0
ioctl(6, 0x806c4120, 0xbee5dac0)        = 0
nanosleep({0, 27000000}, Read from remote host 192.168.0.202: Connection
reset by peer
Connection to 192.168.0.202 closed.

0x806c4120 corresponds to A 0x20 that corresponds to
SNDRV_PCM_IOCTL_STATUS = _IOR('A', 0x20, struct snd_pcm_status) in
asound.h

After that I moved the snd_pcm_period_elapsed like this:

@@ -154,7 +158,10 @@ void alsa_dsp_event(void *data, unsigned id,
uint16_t *msg)
                                wake_up(&the_locks.write_wait);
                        }

spin_unlock_irqrestore(&the_locks.write_dsp_lock, flag);
+
snd_pcm_period_elapsed(prtd->playback_substream);
                        break;

and removed it from the old location: 

diff --git a/sound/soc/msm/msm7k-pcm.c b/sound/soc/msm/msm7k-pcm.c
index 38e8283..3e54184 100644
--- a/sound/soc/msm/msm7k-pcm.c
+++ b/sound/soc/msm/msm7k-pcm.c
@@ -152,8 +152,6 @@ static struct snd_pcm_hw_constraint_list
constraints_sample_rates = {
 
 static void playback_event_handler(void *data)
 {
-       struct msm_audio *prtd = data;
-       snd_pcm_period_elapsed(prtd->playback_substream);
 }

If I remember well aplay doesn't use the SNDRV_PCM_IOCTL_STATUS

Denis.
