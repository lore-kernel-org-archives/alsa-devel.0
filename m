From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: twl4030 latency update
Date: Wed, 26 Mar 2014 14:51:04 +0200
Message-ID: <5332CD38.3070700@ti.com>
References: <532ACD4A.3080508@univpm.it> <532AEEA6.20704@ti.com>
 <532AFBDD.8040407@univpm.it> <532BE58A.2010701@ti.com>
 <5331CFF9.20402@univpm.it> <53328F4C.8030205@ti.com>
 <5332A1C9.3070802@univpm.it>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bear.ext.ti.com (bear.ext.ti.com [192.94.94.41])
 by alsa0.perex.cz (Postfix) with ESMTP id BA9412651A4
 for <alsa-devel@alsa-project.org>; Wed, 26 Mar 2014 13:51:08 +0100 (CET)
In-Reply-To: <5332A1C9.3070802@univpm.it>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Leonardo Gabrielli <l.gabrielli@univpm.it>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 03/26/2014 11:45 AM, Leonardo Gabrielli wrote:
> =

> On 26/03/2014 09:26, Peter Ujfalusi wrote:
>> The McBSP2 FIFO will be always there. There's nothing can be done on tha=
t. The
>> size on McBSP2 is 1280 words -> 640 stereo samples, ie ~29ms with 22050,
>> 14.5ms with 44100.
>>
>> If you are staying in element mode this means that it is granted that the
>> sample at the DMA pointer will out on the i2s line about the mentioned t=
imes.
>> This is the delay caused by the FIFO itself. From where the rest is comi=
ng I'm
>> not really sure.

> BTW: I forgot to mention: the latency listed in my previous email is
> input+output (i.e. I record pulses from the beagleboard input jack and the
> delayed version to the beagleboard output jack). The twl4030 analog and
> digital loopback features have been of course disabled, in order to get t=
he
> total latency due from A/D to D/A.

This means that the McBSP latency in worst case is 1280 + selected rx
threshold in words (so /2 in case of stereo.) If you lower the rx threshold
you decrease the latency on the capture side. On the playback side there's
nothing can be done.

> So just to get confirm I understood the McBSP mechanism well: even though=
 I
> can transfer to/from DMA samples in bursts of <threshold> length, each sa=
mple
> will always "travel along" the whole FIFO buffer length, (as if in a delay
> line) and thus they will always have 640samples delay?

On the playback side this is pretty much true. On capture side the threshold
means that DMA will read from FIFO when threshold amount is available in it.

> Would it be possible to workaround this, e.g. by putting 4-channel audio
> frames instead of stereo frames in the FIFO (with 2 channels unused), in =
order
> to fill up the FIFO more quickly and have less latency? Or is it pure cra=
ze?

>From the FIFO McBSP takes data word by word. If you play stereo, you need to
have stereo data in the FIFO. You can not skip two words with McBSP.

The thing I tried for playback and did not worked AFAIR:
In general the idea was to configure DMA to send threshold/channel to every
request while configuring the McBSP threshold register to be 1280 - thresho=
ld.
In case of threshold 80 (40 stereo samples) it would play out:
transfer 40 samples to FIFO per DMA request
assert the DMA request when we have space for 1260 (630 samples). The number
is just a guess, keeping 10 samples in FIFO sounds safe enough
This would keep the FIFO fill between 10 and 50 samples.
But this does not work, I think McBSP is counting the received words also a=
nd
deasserts the DMA request based on this count and not the FIFO level.

Another thing which would be even more complicated is to play with the McBSP
threshold runtime. With the same 40 sample:
DMA is to transfer 40 samples per DMA requests.
start
1. McBSP threshold to 80
2. in dma interrupt callback McBSP threshold to 1260
3. in McBSP warning interrupt (that we will be reaching the threshold soon)
back to 80
4. goto 2

If we could do the step between 3 and 4 within one sample time this might w=
ork
but as soon as you are late the thing will fail.

I know this is working in realtime systems like in DSPs and non linux syste=
ms...

-- =

P=E9ter
