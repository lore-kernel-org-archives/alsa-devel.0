From: Alistair Buxton <a.j.buxton@gmail.com>
Subject: [BUG] Meter causes freeze when closing audio device
Date: Sun, 5 Mar 2017 22:20:42 +0000
Message-ID: <CAO-Op+FW8CL8bvnr6m4Rfj9HSKnPOSBL05k9K5XXrwvpokOtaw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f52.google.com (mail-wm0-f52.google.com [74.125.82.52])
 by alsa0.perex.cz (Postfix) with ESMTP id EABE026583C
 for <alsa-devel@alsa-project.org>; Sun,  5 Mar 2017 23:20:43 +0100 (CET)
Received: by mail-wm0-f52.google.com with SMTP id n11so51191760wma.0
 for <alsa-devel@alsa-project.org>; Sun, 05 Mar 2017 14:20:43 -0800 (PST)
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

To reproduce, put the following in asound.conf or .asoundrc:

pcm.mymeter {
        type meter
        slave.pcm "dmixer"
}

pcm.dmixer  {
        type dmix
        ipc_key 1024
        slave {
                pcm "hw:0,0"
                period_time 0
                period_size 1024
                buffer_size 4096
                rate 48000
        }
        bindings {
                0 0
                1 1
        }
}

ctl.dmixer {
        type hw
        card 0
}

If pulseaudio is running, suspend it:

pasuspender sleep 1d

Now run aplay (you may need to change sample format):

aplay -v -fS16_LE -r48000 -c2 -d1 -Dmymeter /dev/zero

Expected result: aplay should play one second of silence and then exit.

Actual result: About 50% of the time, aplay plays one second of silence and
then freezes forever in poll().

Playing directly to dmixer does not freeze.

Backtrace:

(gdb) bt
#0  0xb6ce5b80 in poll () at ../sysdeps/unix/syscall-template.S:81
#1  0xb6e5c428 in poll (__timeout=-1, __nfds=1, __fds=0xbe96c408)
    at /usr/include/arm-linux-gnueabihf/bits/poll2.h:46
#2  snd1_pcm_wait_nocheck (pcm=pcm@entry=0xc69570, timeout=timeout@entry=-1)
at pcm.c:2418
#3  0xb6e961d8 in snd_pcm_dmix_drain (pcm=0xc69570) at pcm_dmix.c:649
#4  0x0000de90 in ?? ()
Backtrace stopped: previous frame identical to this frame (corrupt stack?)

Also reproducible with other audio players such as sox and ogg123.

Reproducible on Ubuntu 17.04 beta with libasound2 1.1.3 and virtualbox
audio device.
Reproducible on Ubuntu 16.04 with libasound2 1.1.0 and Intel HD audio.
Reproducible on Raspbian Jessie with libasound 1.0.28 and
snd_soc_hifiberry_dac.

-- 
Alistair Buxton
a.j.buxton@gmail.com
