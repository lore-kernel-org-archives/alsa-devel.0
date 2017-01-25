From: Anoop Rajan <anoopmannil@gmail.com>
Subject: Alsa-lib Dmix issue
Date: Thu, 26 Jan 2017 00:34:41 +0530
Message-ID: <CACmL+LCqwU8A8uq+Z=wFSazTCSMsKoRm0U+w7airoza240aHVQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ot0-f177.google.com (mail-ot0-f177.google.com
 [74.125.82.177])
 by alsa0.perex.cz (Postfix) with ESMTP id 8D970266F05
 for <alsa-devel@alsa-project.org>; Wed, 25 Jan 2017 20:04:43 +0100 (CET)
Received: by mail-ot0-f177.google.com with SMTP id 73so159260124otj.0
 for <alsa-devel@alsa-project.org>; Wed, 25 Jan 2017 11:04:43 -0800 (PST)
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
Cc: ajith karnik <ajithskarnik@gmail.com>
List-Id: alsa-devel@alsa-project.org

Hello All,

 I am trying to play a song  using dmix plugin using AlsaLib(1.0.29) , My
kernel (Linux 3.8)hangs at poll() on snd timer interface.When I debugged
further, I understood that poll hangs because of DMA interrupt
(snd_pcm_period_elapsed)not been received.

Asound. conf as
pcm.softvol {
    type            softvol
    slave {
        pcm         "hw:0,0"
    }
    control {
        name        "Master"
        card        0
    }
}
pcm.volmix {
        type dmix
        ipc_key 1024
        ipc_key_add_uid yes
        ipc_perm 0660
      slave {
pcm "hw:0,0"
rate 44100
 }
}
used aplay -D 'plug:volmix'  123.wav. Where as the normal playback aplay
123.wav plays the song as expected.

Comparing the two cases, I observed that Dmix is not incrementing the
control.appl_ptr(always zero) in SNDRV_PCM_IOCTL_SYNC_PTR ioctl , but the
later one(with out dmix) increments this and kernel is notified with the
data written with the value in application pointer. Trying to understand
further, though I am not an expert here, snd_pcm_dmix_sync_area is invoked,
the data is written to destination , dmix->slave_appl_ptr  is incremented,
but some how the link to
dmix->spcm->private_data->sync_ptr->c.control.appl_ptr
is not incremented with the written frames.

As I understand, SNDRV_PCM_IOCTL_SYNC_PTR should notify kernel with the
application pointer else kernel cant understand how much is written when we
do data mmap. I am trying to understand why it is not incremented, but
strongly believe that it cannot be a bug in alsa-lib Dmix, but I am lacking
some thing, but wondering what I am missing here.My kernel access type is
MMAP_INTERLEAVED.



Exactly same issue mentioned on RaspberryPi below but no solution provided
https://www.raspberrypi.org/forums/viewtopic.php?t=64936&p=481557.
<https://www.raspberrypi.org/forums/viewtopic.php?t=64936&p=481557>
<https://www.raspberrypi.org/forums/viewtopic.php?t=64936&p=481557>


Please help me to understand more here, any pointers is appreciated.

Regards,
Anoop
