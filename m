From: Leonardo Gabrielli <l.gabrielli@univpm.it>
Subject: Re: twl4030 latency update
Date: Wed, 26 Mar 2014 10:45:45 +0100
Message-ID: <5332A1C9.3070802@univpm.it>
References: <532ACD4A.3080508@univpm.it> <532AEEA6.20704@ti.com>
 <532AFBDD.8040407@univpm.it> <532BE58A.2010701@ti.com>
 <5331CFF9.20402@univpm.it> <53328F4C.8030205@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bk0-f48.google.com (mail-bk0-f48.google.com
 [209.85.214.48])
 by alsa0.perex.cz (Postfix) with ESMTP id D86E6265119
 for <alsa-devel@alsa-project.org>; Wed, 26 Mar 2014 10:45:48 +0100 (CET)
Received: by mail-bk0-f48.google.com with SMTP id mx12so421294bkb.21
 for <alsa-devel@alsa-project.org>; Wed, 26 Mar 2014 02:45:48 -0700 (PDT)
In-Reply-To: <53328F4C.8030205@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


On 26/03/2014 09:26, Peter Ujfalusi wrote:
> The McBSP2 FIFO will be always there. There's nothing can be done on that. The
> size on McBSP2 is 1280 words -> 640 stereo samples, ie ~29ms with 22050,
> 14.5ms with 44100.
>
> If you are staying in element mode this means that it is granted that the
> sample at the DMA pointer will out on the i2s line about the mentioned times.
> This is the delay caused by the FIFO itself. From where the rest is coming I'm
> not really sure.
BTW: I forgot to mention: the latency listed in my previous email is 
input+output (i.e. I record pulses from the beagleboard input jack and 
the delayed version to the beagleboard output jack). The twl4030 analog 
and digital loopback features have been of course disabled, in order to 
get the total latency due from A/D to D/A.

So just to get confirm I understood the McBSP mechanism well: even 
though I can transfer to/from DMA samples in bursts of <threshold> 
length, each sample will always "travel along" the whole FIFO buffer 
length, (as if in a delay line) and thus they will always have 
640samples delay?

Would it be possible to workaround this, e.g. by putting 4-channel audio 
frames instead of stereo frames in the FIFO (with 2 channels unused), in 
order to fill up the FIFO more quickly and have less latency? Or is it 
pure craze?

Cheers and thank you
