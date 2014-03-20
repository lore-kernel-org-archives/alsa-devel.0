From: Leonardo Gabrielli <l.gabrielli@univpm.it>
Subject: Re: twl4030 latency update
Date: Thu, 20 Mar 2014 15:31:57 +0100
Message-ID: <532AFBDD.8040407@univpm.it>
References: <532ACD4A.3080508@univpm.it> <532AEEA6.20704@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wg0-f50.google.com (mail-wg0-f50.google.com [74.125.82.50])
 by alsa0.perex.cz (Postfix) with ESMTP id ECC112651A2
 for <alsa-devel@alsa-project.org>; Thu, 20 Mar 2014 15:32:05 +0100 (CET)
Received: by mail-wg0-f50.google.com with SMTP id x13so657182wgg.33
 for <alsa-devel@alsa-project.org>; Thu, 20 Mar 2014 07:32:05 -0700 (PDT)
In-Reply-To: <532AEEA6.20704@ti.com>
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
Cc: Edgar Berdahl <eberdahl@ccrma.Stanford.EDU>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Dear Peter,
thanks, I'm not sure I understand all the details but after a fast find 
in my beagleboard /sys I found

./sys/devices/68000000.ocp/49026000.mcbsp/dma_op_mode
./sys/devices/68000000.ocp/49022000.mcbsp/dma_op_mode
./sys/devices/68000000.ocp/49024000.mcbsp/dma_op_mode
./sys/devices/68000000.ocp/48096000.mcbsp/dma_op_mode
./sys/devices/68000000.ocp/48074000.mcbsp/dma_op_mode

All of these are already set as threshold:
cat sys/devices/68000000.ocp/49022000.mcbsp/dma_op_mode
[element] threshold

Probably I found the FIFOs to be shortened in order to reduce latency: 
all of the thresholds are 112 besides one of the devices which has:
cat sys/devices/68000000.ocp/49022000.mcbsp/max_rx_thres
1264
for both tx and rx. Maybe that's the ALSA playback samples queue.

In fact I find:
cat /proc/device-tree/ocp/mcbsp\@49022000/ti\,hwmods
mcbsp2mcbsp2_sidetone

So it's the McBSP2 which you mentioned.

Now, I'm not sure how to change the threshold, I guess I have to patch 
some kernel module and rebuild?


On 20/03/2014 14:35, Peter Ujfalusi wrote:
> Hi Leonardo,
>
> On 03/20/2014 01:13 PM, Leonardo Gabrielli wrote:
>> Dear Peter,
>> I was investigating on TWL4030 high playback latency and stumbled in an old
>> thread started by Edgar
>> http://mailman.alsa-project.org/pipermail/alsa-devel/2011-October/045173.html
>> where I read this is related to McBSP2 buffer length
>> Recent kernels seems to have the same behavior (I have a debian beagleboardxM
>> with 3.13.3-armv7-x10)
>> Did you manage to get a fix to this problem? Would it be possible?
> The 'misusing/configuring the McBSP, and sDMA' did not worked :(
> However the mcbsp code went through quite a bit of change since than
> concerning the McBSP FIFO/sDMA configuration.
>
> If we have FIFO the sDMA is always in packet mode.
> The default is to transfer one sample with sDMA per DMA request.
> You can switch the McBSP to 'threshold' mode and set the maximum FIFO
> threshold you want to use. The code will figure out the optimal FIFO/burst
> size based on the period size and the max threshold you have set.
> This is done via a sysfs file under the mcbsp, the file is dma_op_mode if I
> recall correctly.
> Playing with the max tx/rx threshold you might be able to get better latency.
>
