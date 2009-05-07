From: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: appl_ptr and DMA overrun at end of stream
Date: Thu, 7 May 2009 12:35:24 -0400
Message-ID: <9e4733910905070935k2da0ea0bu7f8c9cadc3dcd9eb@mail.gmail.com>
References: <9e4733910905070923i16683486n678653ba56c28b74@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from gv-out-0910.google.com (gv-out-0910.google.com [216.239.58.191])
	by alsa0.perex.cz (Postfix) with ESMTP id 5CE4C1038D8
	for <alsa-devel@alsa-project.org>;
	Thu,  7 May 2009 18:35:26 +0200 (CEST)
Received: by gv-out-0910.google.com with SMTP id i36so154093gve.24
	for <alsa-devel@alsa-project.org>; Thu, 07 May 2009 09:35:25 -0700 (PDT)
In-Reply-To: <9e4733910905070923i16683486n678653ba56c28b74@mail.gmail.com>
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

Debug trace... at the bottom you can see where I needed to stop
queuing new DMA data

If you dig around in the archives, other people have run into this same problem.

root@phyCORE:~ aplay phone.wav
mpc5200-psc-ac97 f0002200.sound: psc_dma_open(substream=c7913700)
Playing WAVE 'phone.wav' : Signed 16 bit Little Endian, Rate 44100 Hz, Stereo
mpc5200-psc-ac97 f0002200.sound:
psc_ac97_hw_analog_params(substream=c7913700) p_size=5513
p_bytes=44104 periods=4 buffer_size=22052  buffer_bytes=176416
channels=2 rate=44100 format=11
AC97_EXTENDED_STATUS 411
mpc5200-psc-ac97 f0002200.sound: psc_dma_trigger(substream=c7913700,
cmd=1) stream_id=0
runtime->dma_area c7a00000
Initial pointer 0
Playback

--- DMA address / s->appl_ptr  / runtime->control->appl_ptr

enqueue 7a00000 0 22052
queued
enqueue 7a0ac48 5513 22052
queued
enqueue 7a15890 11026 22052
queued
enqueue 7a204d8 16539 22052
queued
enqueue 7a00000 22052 22052
enqueue 7a00000 22052 22052
enqueue 7a00000 22052 27565
queued
enqueue 7a0ac48 27565 33078
queued
enqueue 7a15890 33078 38591
queued
enqueue 7a204d8 38591 44104
queued
enqueue 7a00000 44104 49617
queued
enqueue 7a0ac48 49617 55130
queued
enqueue 7a15890 55130 60643
queued
enqueue 7a204d8 60643 66156
queued
enqueue 7a00000 66156 71669
queued
enqueue 7a0ac48 71669 77182
queued
enqueue 7a15890 77182 82695
queued
enqueue 7a204d8 82695 88208
queued
enqueue 7a00000 88208 93721
queued
enqueue 7a0ac48 93721 99234
queued
enqueue 7a15890 99234 104747
queued
enqueue 7a204d8 104747 110260
queued
enqueue 7a00000 110260 115773
queued
enqueue 7a0ac48 115773 115773 - stopped queuing new buffers here
enqueue 7a0ac48 115773 115773
enqueue 7a0ac48 115773 115773
mpc5200-psc-ac97 f0002200.sound: psc_dma_trigger(substream=c7913700,
cmd=0) stream_id=0
 -- this trigger is too late. Samples have already started going into the codec
mpc5200-psc-ac97 f0002200.sound: psc_dma_close(substream=c7913700)
root@phyCORE:


-- 
Jon Smirl
jonsmirl@gmail.com
