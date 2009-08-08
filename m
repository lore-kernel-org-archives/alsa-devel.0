From: Jon Smirl <jonsmirl@gmail.com>
Subject: Implementing sync start
Date: Sat, 8 Aug 2009 14:16:09 -0400
Message-ID: <9e4733910908081116p221e606cma31a95b06d9b5be6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.240])
	by alsa0.perex.cz (Postfix) with ESMTP id A31BF246AE
	for <alsa-devel@alsa-project.org>;
	Sat,  8 Aug 2009 20:16:10 +0200 (CEST)
Received: by an-out-0708.google.com with SMTP id c37so678682anc.2
	for <alsa-devel@alsa-project.org>; Sat, 08 Aug 2009 11:16:09 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel mailing list <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

I'm implementing sync start as Takashi described...
---------------
If the hardware supports the simultaneous triggering of multiple
streams, add the sync support to the driver.  Namely,
- Add SNDRV_PCM_INFO_SYNC_START flag to PCM info field
- Call snd_pcm_set_sync(substream) at each open callback
- In the trigger callback, check all bundled streams via
 snd_pcm_group_for_each_entry().  Mark all the streams but the
 current one via snd_pcm_trigger_done().
 Then start all streams at once.
 Ditto for stop and pause.
-------------

Is there a simple way to test this with something like a mono sine wav
file? A aplay mono.wav and then use and ALSA conf to copy the sine to
all channels and then sync start them.

-----------

brutefit has this routine for sync start, does this look correct?

int
bfio_synch_start(void)
{
    snd_pcm_status_t *status;
    int err, n;

    if (base_handle == NULL) {
        return 0;
    }

    /* FIXME: the SND_PCM_STATE_RUNNING code would not be needed if the
       bfio_write autostart hack was not there */
    snd_pcm_status_alloca(&status);

    if (link_handles) {
        if ((err = snd_pcm_status(base_handle, status)) < 0) {
            fprintf(stderr, "ALSA I/O: Could not get status: %s.\n",
                    snd_strerror(err));
            return -1;
        }
        if (snd_pcm_status_get_state(status) == SND_PCM_STATE_RUNNING) {
            return 0;
        }
        if ((err = snd_pcm_start(base_handle)) < 0) {
            fprintf(stderr, "ALSA I/O: Could not start audio: %s.\n",
                    snd_strerror(err));
            return -1;
        }
        return 0;
    }

    FOR_IN_AND_OUT {
        for (n = 0; n < n_handles[IO]; n++) {
            if ((err = snd_pcm_status(handles[IO][n], status)) < 0) {
                fprintf(stderr, "ALSA I/O: Could not get status: %s.\n",
                        snd_strerror(err));
                return -1;
            }
            if (snd_pcm_status_get_state(status) == SND_PCM_STATE_RUNNING) {
                continue;
            }

            if ((err = snd_pcm_start(handles[IO][n])) < 0) {
                fprintf(stderr, "ALSA I/O: Could not start audio: %s.\n",
                        snd_strerror(err));
                return -1;
            }
        }
    }
    return 0;
}


-- 
Jon Smirl
jonsmirl@gmail.com
