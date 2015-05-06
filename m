From: Dan Hordern <danhordern@gmail.com>
Subject: ALSA: dmix: pcm status incomplete
Date: Wed, 6 May 2015 14:29:01 +1000
Message-ID: <CAECUvW3sTPqpquv_BFr61mnmrL5kRDcsD9spF5FfuGJ4CFO98A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yk0-f170.google.com (mail-yk0-f170.google.com
 [209.85.160.170])
 by alsa0.perex.cz (Postfix) with ESMTP id 42FC3260522
 for <alsa-devel@alsa-project.org>; Wed,  6 May 2015 06:29:02 +0200 (CEST)
Received: by ykec202 with SMTP id c202so48419041yke.2
 for <alsa-devel@alsa-project.org>; Tue, 05 May 2015 21:29:01 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

I require timestamp information from the soundcard and host for our
application. However, I noticed that when using "dmix:0,0" instead of
"hw:0,0", the audio timestamp and delay frames are both zero.

Looking in to the code, it seems that the 'snd_pcm_dmix_status' function
does not populate either of these. In order to expose these, I have
modified this function to get this information from the slave pcm; patch
below.

I was hoping for some feedback on this change. I am not sure if the delay
value makes sense as yet, and whether there are consequences of using the
hardware trigger timestamp etc. I am guessing the dsnoop and dshare plugins
may also have this issue, though I have not checked.

Thanks,
Dan


diff --git a/src/pcm/pcm_dmix.c b/src/pcm/pcm_dmix.c
index babde6a..a4d7fc0 100644
--- a/src/pcm/pcm_dmix.c
+++ b/src/pcm/pcm_dmix.c
@@ -475,12 +475,12 @@ static int snd_pcm_dmix_status(snd_pcm_t *pcm,
snd_pcm_status_t * status)
                break;
        }
        memset(status, 0, sizeof(*status));
+       snd_pcm_status(dmix->spcm, status);
        status->state = snd_pcm_dmix_state(pcm);
-       status->trigger_tstamp = dmix->trigger_tstamp;
-       gettimestamp(&status->tstamp, pcm->tstamp_type);
        status->avail = snd_pcm_mmap_playback_avail(pcm);
        status->avail_max = status->avail > dmix->avail_max ? status->avail
: dmix->avail_max;
        dmix->avail_max = 0;
+       status->delay = snd_pcm_mmap_playback_delay(pcm);
        return 0;
 }
