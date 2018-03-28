From: "Wischer, Timo (ADITG/ESB)" <twischer@de.adit-jv.com>
Subject: Re: [PATCH - IOPLUG DRAIN 0/2]
Date: Wed, 28 Mar 2018 08:42:50 +0000
Message-ID: <B0FB33DC1499054591F62C0EF1E013D7684FE8D9@HI2EXCH01.adit-jv.com>
References: <1521726537-7651-1-git-send-email-twischer@de.adit-jv.com>
 <B0FB33DC1499054591F62C0EF1E013D7684FE451@HI2EXCH01.adit-jv.com>
 <s5hwoy39q5c.wl-tiwai@suse.de>
 <s5htvt79ptg.wl-tiwai@suse.de>,<s5hr2ob9n9t.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp1.de.adit-jv.com (smtp1.de.adit-jv.com [62.225.105.245])
 by alsa0.perex.cz (Postfix) with ESMTP id 0CC64266E07
 for <alsa-devel@alsa-project.org>; Wed, 28 Mar 2018 10:42:58 +0200 (CEST)
In-Reply-To: <s5hr2ob9n9t.wl-tiwai@suse.de>
Content-Language: en-US
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi Takashi,

now I got your idea.
Thanks for the patch.
But I see some small concerns.
See my inline comments:

Beside this concerns I really like this solution.


-- 8< --
--- a/src/pcm/pcm_ioplug.c
+++ b/src/pcm/pcm_ioplug.c
@@ -47,6 +47,11 @@ typedef struct snd_pcm_ioplug_priv {
        snd_htimestamp_t trigger_tstamp;
 } ioplug_priv_t;

+static int snd_pcm_ioplug_drop(snd_pcm_t *pcm);
+static int snd_pcm_ioplug_poll_descriptors_count(snd_pcm_t *pcm);
+static int snd_pcm_ioplug_poll_descriptors(snd_pcm_t *pcm, struct pollfd *pfds, unsigned int space);
+static int snd_pcm_ioplug_poll_revents(snd_pcm_t *pcm, struct pollfd *pfds, unsigned int nfds, unsigned short *revents);
+
 /* update the hw pointer */
 /* called in lock */
 static void snd_pcm_ioplug_hw_ptr_update(snd_pcm_t *pcm)
@@ -57,6 +62,7 @@ static void snd_pcm_ioplug_hw_ptr_update(snd_pcm_t *pcm)
        hw = io->data->callback->pointer(io->data);
        if (hw >= 0) {
                snd_pcm_uframes_t delta;
+               snd_pcm_uframes_t avail;

                if ((snd_pcm_uframes_t)hw >= io->last_hw)
                        delta = hw - io->last_hw;
@@ -67,6 +73,12 @@ static void snd_pcm_ioplug_hw_ptr_update(snd_pcm_t *pcm)
                        delta = wrap_point + hw - io->last_hw;
                }
                snd_pcm_mmap_hw_forward(io->data->pcm, delta);
+               /* stop the stream if all samples are drained */
+               if (io->data->state == SND_PCM_STATE_DRAINING) {
+                       avail = snd_pcm_mmap_avail(pcm);
+                       if (avail >= pcm->buffer_size)
+                               snd_pcm_ioplug_drop(pcm);
+               }
                io->last_hw = (snd_pcm_uframes_t)hw;
        } else
                io->data->state = SNDRV_PCM_STATE_XRUN;
In case of draining drop has to be called because draining is done

@@ -488,20 +500,66 @@ static int snd_pcm_ioplug_drop(snd_pcm_t *pcm)
        return 0;
 }

+static int ioplug_drain_via_poll(snd_pcm_t *pcm)
+{
+       ioplug_priv_t *io = pcm->private_data;
+       int err;
+
+       /* in non-blocking mode, leave application to poll() by itself */
+       if (io->data->nonblock)
+               return -EAGAIN;
In case of nonblock snd_pcm_ioplug_hw_ptr_update() will not be called by the user
Therefore the user will never detect that draining is done.
I fear snd_pcm_ioplug_hw_ptr_update() has also to be called in nonblock mode here.

+
+       while (io->data->state == SND_PCM_STATE_DRAINING) {
+               err = snd_pcm_wait_nocheck(pcm, -1);
+               snd_pcm_ioplug_hw_ptr_update(pcm);
+               if (err < 0)
+                       break;
+       }
+
+       return 0;
+}
+
 /* need own locking */
 static int snd_pcm_ioplug_drain(snd_pcm_t *pcm)
 {
        ioplug_priv_t *io = pcm->private_data;
        int err;

-       if (io->data->state == SND_PCM_STATE_OPEN)
+       snd_pcm_lock(pcm);
+       switch (io->data->state) {
+       case SND_PCM_STATE_OPEN:
+       case SND_PCM_STATE_DISCONNECTED:
+       case SND_PCM_STATE_SUSPENDED:
                return -EBADFD;
+       case SND_PCM_STATE_PREPARED:
+               if (pcm->stream == SND_PCM_STREAM_PLAYBACK) {
+                       err = snd_pcm_ioplug_start(pcm);
+                       if (err < 0)
+                               goto unlock;
+                       io->data->state = SND_PCM_STATE_DRAINING;
+               }
+               break;
+       case SND_PCM_STATE_RUNNING:
+               io->data->state = SND_PCM_STATE_DRAINING;
+               break;
+       }

-       io->data->state = SND_PCM_STATE_DRAINING;
-       if (io->data->callback->drain)
-               io->data->callback->drain(io->data);
-       snd_pcm_lock(pcm);
-       err = snd_pcm_ioplug_drop(pcm);
+       if (io->data->state == SND_PCM_STATE_DRAINING) {
+               if (io->data->callback->drain) {
+                       snd_pcm_unlock(pcm); /* let plugin own locking */
+                       err = io->data->callback->drain(io->data);
+                       snd_pcm_lock(pcm);
+               } else {
+                       err = ioplug_drain_via_poll(pcm);
+               }
+               if (err < 0)
+                       goto unlock;
+       }
+
+       if (io->data->state != SND_PCM_STATE_SETUP)
+               err = snd_pcm_ioplug_drop(pcm);
+
+ unlock:
        snd_pcm_unlock(pcm);
        return err;
 }

Will you create the patch and apply it to master or
is there anything which I have to do?

Best regards

Timo
