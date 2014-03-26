From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: twl4030 latency update
Date: Wed, 26 Mar 2014 10:26:52 +0200
Message-ID: <53328F4C.8030205@ti.com>
References: <532ACD4A.3080508@univpm.it> <532AEEA6.20704@ti.com>
 <532AFBDD.8040407@univpm.it> <532BE58A.2010701@ti.com>
 <5331CFF9.20402@univpm.it>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from comal.ext.ti.com (comal.ext.ti.com [198.47.26.152])
 by alsa0.perex.cz (Postfix) with ESMTP id B16392650E1
 for <alsa-devel@alsa-project.org>; Wed, 26 Mar 2014 09:26:56 +0100 (CET)
In-Reply-To: <5331CFF9.20402@univpm.it>
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

Hi Leonardo,

On 03/25/2014 08:50 PM, Leonardo Gabrielli wrote:
> Thanks Peter,
> I've been able today to test following your suggestions.
> Unfortunately I didn't get any improvement on latency, but reducing sDMA =
FIFO
> threshold improved on audio integrity (with some period+samplerate
> combinations I have corrupted audio, maybe scrambled or empty frames).

Can you elaborate on the corrupted/scrambled audio? I just don't see how it
can happen. Can you get the /proc/asound/card0/pcm0p/sub0/hw_params when you
have the audio quality issue?

I can not run jackd on the board anymore (with linux-next at least):
FATAL: cannot locate cpu MHz in /proc/cpuinfo

but with aplay -v --period-size=3D512 or 64 2ch-left-since-22050.wav
seams to be fine for me (assuming AU=3Dko means that it is the corrupted on=
e)

> TESTS:
> 1- with FIFO threshold 1264 for McBSP2
>  running jackd -P62 -dalsa -dhw:0 -r $SRATE -p $PERIOD -n2 -s -S -i2 -o2
> with the following combinations of $SRATE - $PERIOD:
> 22050 - 512 - AU=3Dko lat=3D/
> 22050 - 256 - AU=3Dok lat=3D54ms
> 22050 - 128 - AU=3Dko lat=3D/
> 22050 - 64 - AU=3Dok lat=3D34ms
> 32000 - 64 - AU=3Dok lat=3D23ms
> 44100 - 64 - AU=3Dok lat=3D17ms
> =

> 2- with FIFO threshold 320 for McBSP2
> the rest as above
> 22050 - 512 - AU=3Dko lat=3D/
> 22050 - 256 - AU=3Dok lat=3D54ms
> 22050 - 128 - AU=3Dok lat=3D38ms
> 22050 - 64 - AU=3Dok lat=3D40-60ms (changing for each invocation of jackd)
> 32000 - 64 - AU=3Dok lat=3D23ms
> 44100 - 64 - AU=3Dok lat=3D17ms
> =

> Outcome: maybe I got it wrong, I thought this would reduce the number of
> periods allocated by jack (they didn't change between the two tests) hence
> reduce latency.

The McBSP2 FIFO will be always there. There's nothing can be done on that. =
The
size on McBSP2 is 1280 words -> 640 stereo samples, ie ~29ms with 22050,
14.5ms with 44100.

If you are staying in element mode this means that it is granted that the
sample at the DMA pointer will out on the i2s line about the mentioned time=
s.
This is the delay caused by the FIFO itself. From where the rest is coming =
I'm
not really sure.

Now if you are in threshold mode this changes a bit, but the FIFO will be
there still. At start the FIFO is going to be filled up with threshold long
bursts. From there you will have DMA burst with about threshold length every
time the FIFO has that amount of free slots in it.
In case of tx_threshold 1264 (632 sample) and 512 period size:
0. The actual threshold level will be 512 samples.
1. copy of 512 samples (1 period to FIFO)
   ~128 (640 - 512) free slot left in the FIFO
2. nothing happens until the FIFO level drops to 127 (we will have free spa=
ce
for 512 samples).
3. next 512 sample burst to FIFO.
4. the FIFO will be full or close to full
5. goto 2

When the period size is bigger than the desired threshold (set via sysfs) t=
hen
the code will figure out the best configuration for the actual threshold/DMA
burst.

The same principle applies to element mode, where the DMA bursts are set to
one sample. Meaning that at start you will have ~640 quick DMA bursts to fi=
ll
the FIFO up and after that you will have the next burst coming at every 1/H=
z time.

You see, the FIFO is there to add delay in both cases however in threshold
mode you are not going to stress the system with constant DMA activity, you
only have bursts to fill the FIFO up.

> The CPU is not overwhelmed even in the 64sample tests (good).
> =

> Also: after a reboot the threshold and dma_op_mode get back to their defa=
ults.
> Can I make it stable or do I need an upstart job to echo the proper values
> into the sysfs each time?

You need to change these after every boot, yes. The default is element mode.

> Cheers and thanks
> =

> Leonardo
> =

> =

> On 21/03/2014 08:08, Peter Ujfalusi wrote:
>> On 03/20/2014 04:31 PM, Leonardo Gabrielli wrote:
>>> Dear Peter,
>>> thanks, I'm not sure I understand all the details but after a fast find=
 in my
>>> beagleboard /sys I found
>>>
>>> ./sys/devices/68000000.ocp/49026000.mcbsp/dma_op_mode
>>> ./sys/devices/68000000.ocp/49022000.mcbsp/dma_op_mode
>>> ./sys/devices/68000000.ocp/49024000.mcbsp/dma_op_mode
>>> ./sys/devices/68000000.ocp/48096000.mcbsp/dma_op_mode
>>> ./sys/devices/68000000.ocp/48074000.mcbsp/dma_op_mode
>>>
>>> All of these are already set as threshold:
>>> cat sys/devices/68000000.ocp/49022000.mcbsp/dma_op_mode
>>> [element] threshold
>> it is in 'element' mode, the [] shows the selected mode.
>> You can change it:
>> echo threshold > /sys/devices/68000000.ocp/49022000.mcbsp/dma_op_mode
>>
>>> Probably I found the FIFOs to be shortened in order to reduce latency: =
all of
>>> the thresholds are 112 besides one of the devices which has:
>>> cat sys/devices/68000000.ocp/49022000.mcbsp/max_rx_thres
>>> 1264
>>> for both tx and rx. Maybe that's the ALSA playback samples queue.
>> This is for the threshold mode. With this value you can set the maximum =
slots
>> you want to use in the McBSP FIFO.
>>
>> To change it:
>> echo 320 > /sys/devices/68000000.ocp/49022000.mcbsp/max_tx_thres
>> echo 320 > /sys/devices/68000000.ocp/49022000.mcbsp/max_ex_thres
>>
>> for example.
>>
>> At the end with this value you can limit the sDMA burst sizes and the Mc=
BSP
>> FIFO level. The threshold means: generate DMA request if threshold numbe=
r of
>> slots are free in the FIFO (playback) or when threshold amount of data
>> available in the FIFO (capture).
>>
>>> In fact I find:
>>> cat /proc/device-tree/ocp/mcbsp\@49022000/ti\,hwmods
>>> mcbsp2mcbsp2_sidetone
>>>
>>> So it's the McBSP2 which you mentioned.
>>>
>>> Now, I'm not sure how to change the threshold, I guess I have to patch =
some
>>> kernel module and rebuild?
>> No, you do not need to recompile anything. See my previous comment.
>>
>>>
>>> On 20/03/2014 14:35, Peter Ujfalusi wrote:
>>>> Hi Leonardo,
>>>>
>>>> On 03/20/2014 01:13 PM, Leonardo Gabrielli wrote:
>>>>> Dear Peter,
>>>>> I was investigating on TWL4030 high playback latency and stumbled in =
an old
>>>>> thread started by Edgar
>>>>> http://mailman.alsa-project.org/pipermail/alsa-devel/2011-October/045=
173.html
>>>>>
>>>>> where I read this is related to McBSP2 buffer length
>>>>> Recent kernels seems to have the same behavior (I have a debian
>>>>> beagleboardxM
>>>>> with 3.13.3-armv7-x10)
>>>>> Did you manage to get a fix to this problem? Would it be possible?
>>>> The 'misusing/configuring the McBSP, and sDMA' did not worked :(
>>>> However the mcbsp code went through quite a bit of change since than
>>>> concerning the McBSP FIFO/sDMA configuration.
>>>>
>>>> If we have FIFO the sDMA is always in packet mode.
>>>> The default is to transfer one sample with sDMA per DMA request.
>>>> You can switch the McBSP to 'threshold' mode and set the maximum FIFO
>>>> threshold you want to use. The code will figure out the optimal FIFO/b=
urst
>>>> size based on the period size and the max threshold you have set.
>>>> This is done via a sysfs file under the mcbsp, the file is dma_op_mode=
 if I
>>>> recall correctly.
>>>> Playing with the max tx/rx threshold you might be able to get better l=
atency.
>>>>
>>
> =



-- =

P=E9ter
