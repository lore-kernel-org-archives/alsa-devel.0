From: Leonardo Gabrielli <l.gabrielli@univpm.it>
Subject: Re: twl4030 latency update
Date: Tue, 25 Mar 2014 19:50:33 +0100
Message-ID: <5331CFF9.20402@univpm.it>
References: <532ACD4A.3080508@univpm.it> <532AEEA6.20704@ti.com>
 <532AFBDD.8040407@univpm.it> <532BE58A.2010701@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ee0-f51.google.com (mail-ee0-f51.google.com [74.125.83.51])
 by alsa0.perex.cz (Postfix) with ESMTP id 3FDF9264FBB
 for <alsa-devel@alsa-project.org>; Tue, 25 Mar 2014 19:50:42 +0100 (CET)
Received: by mail-ee0-f51.google.com with SMTP id c13so798875eek.24
 for <alsa-devel@alsa-project.org>; Tue, 25 Mar 2014 11:50:41 -0700 (PDT)
In-Reply-To: <532BE58A.2010701@ti.com>
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

Thanks Peter,
I've been able today to test following your suggestions.
Unfortunately I didn't get any improvement on latency, but reducing sDMA 
FIFO threshold improved on audio integrity (with some period+samplerate 
combinations I have corrupted audio, maybe scrambled or empty frames).

TESTS:
1- with FIFO threshold 1264 for McBSP2
  running jackd -P62 -dalsa -dhw:0 -r $SRATE -p $PERIOD -n2 -s -S -i2 -o2
with the following combinations of $SRATE - $PERIOD:
22050 - 512 - AU=ko lat=/
22050 - 256 - AU=ok lat=54ms
22050 - 128 - AU=ko lat=/
22050 - 64 - AU=ok lat=34ms
32000 - 64 - AU=ok lat=23ms
44100 - 64 - AU=ok lat=17ms

2- with FIFO threshold 320 for McBSP2
the rest as above
22050 - 512 - AU=ko lat=/
22050 - 256 - AU=ok lat=54ms
22050 - 128 - AU=ok lat=38ms
22050 - 64 - AU=ok lat=40-60ms (changing for each invocation of jackd)
32000 - 64 - AU=ok lat=23ms
44100 - 64 - AU=ok lat=17ms

Outcome: maybe I got it wrong, I thought this would reduce the number of 
periods allocated by jack (they didn't change between the two tests) 
hence reduce latency.
The CPU is not overwhelmed even in the 64sample tests (good).

Also: after a reboot the threshold and dma_op_mode get back to their 
defaults. Can I make it stable or do I need an upstart job to echo the 
proper values into the sysfs each time?

Cheers and thanks

Leonardo


On 21/03/2014 08:08, Peter Ujfalusi wrote:
> On 03/20/2014 04:31 PM, Leonardo Gabrielli wrote:
>> Dear Peter,
>> thanks, I'm not sure I understand all the details but after a fast find in my
>> beagleboard /sys I found
>>
>> ./sys/devices/68000000.ocp/49026000.mcbsp/dma_op_mode
>> ./sys/devices/68000000.ocp/49022000.mcbsp/dma_op_mode
>> ./sys/devices/68000000.ocp/49024000.mcbsp/dma_op_mode
>> ./sys/devices/68000000.ocp/48096000.mcbsp/dma_op_mode
>> ./sys/devices/68000000.ocp/48074000.mcbsp/dma_op_mode
>>
>> All of these are already set as threshold:
>> cat sys/devices/68000000.ocp/49022000.mcbsp/dma_op_mode
>> [element] threshold
> it is in 'element' mode, the [] shows the selected mode.
> You can change it:
> echo threshold > /sys/devices/68000000.ocp/49022000.mcbsp/dma_op_mode
>
>> Probably I found the FIFOs to be shortened in order to reduce latency: all of
>> the thresholds are 112 besides one of the devices which has:
>> cat sys/devices/68000000.ocp/49022000.mcbsp/max_rx_thres
>> 1264
>> for both tx and rx. Maybe that's the ALSA playback samples queue.
> This is for the threshold mode. With this value you can set the maximum slots
> you want to use in the McBSP FIFO.
>
> To change it:
> echo 320 > /sys/devices/68000000.ocp/49022000.mcbsp/max_tx_thres
> echo 320 > /sys/devices/68000000.ocp/49022000.mcbsp/max_ex_thres
>
> for example.
>
> At the end with this value you can limit the sDMA burst sizes and the McBSP
> FIFO level. The threshold means: generate DMA request if threshold number of
> slots are free in the FIFO (playback) or when threshold amount of data
> available in the FIFO (capture).
>
>> In fact I find:
>> cat /proc/device-tree/ocp/mcbsp\@49022000/ti\,hwmods
>> mcbsp2mcbsp2_sidetone
>>
>> So it's the McBSP2 which you mentioned.
>>
>> Now, I'm not sure how to change the threshold, I guess I have to patch some
>> kernel module and rebuild?
> No, you do not need to recompile anything. See my previous comment.
>
>>
>> On 20/03/2014 14:35, Peter Ujfalusi wrote:
>>> Hi Leonardo,
>>>
>>> On 03/20/2014 01:13 PM, Leonardo Gabrielli wrote:
>>>> Dear Peter,
>>>> I was investigating on TWL4030 high playback latency and stumbled in an old
>>>> thread started by Edgar
>>>> http://mailman.alsa-project.org/pipermail/alsa-devel/2011-October/045173.html
>>>> where I read this is related to McBSP2 buffer length
>>>> Recent kernels seems to have the same behavior (I have a debian beagleboardxM
>>>> with 3.13.3-armv7-x10)
>>>> Did you manage to get a fix to this problem? Would it be possible?
>>> The 'misusing/configuring the McBSP, and sDMA' did not worked :(
>>> However the mcbsp code went through quite a bit of change since than
>>> concerning the McBSP FIFO/sDMA configuration.
>>>
>>> If we have FIFO the sDMA is always in packet mode.
>>> The default is to transfer one sample with sDMA per DMA request.
>>> You can switch the McBSP to 'threshold' mode and set the maximum FIFO
>>> threshold you want to use. The code will figure out the optimal FIFO/burst
>>> size based on the period size and the max threshold you have set.
>>> This is done via a sysfs file under the mcbsp, the file is dma_op_mode if I
>>> recall correctly.
>>> Playing with the max tx/rx threshold you might be able to get better latency.
>>>
>
