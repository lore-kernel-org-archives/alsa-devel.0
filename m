From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: twl4030 latency update
Date: Fri, 21 Mar 2014 09:08:58 +0200
Message-ID: <532BE58A.2010701@ti.com>
References: <532ACD4A.3080508@univpm.it> <532AEEA6.20704@ti.com>
 <532AFBDD.8040407@univpm.it>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bear.ext.ti.com (bear.ext.ti.com [192.94.94.41])
 by alsa0.perex.cz (Postfix) with ESMTP id 6D5E22610AA
 for <alsa-devel@alsa-project.org>; Fri, 21 Mar 2014 08:09:02 +0100 (CET)
In-Reply-To: <532AFBDD.8040407@univpm.it>
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
Cc: Edgar Berdahl <eberdahl@ccrma.Stanford.EDU>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 03/20/2014 04:31 PM, Leonardo Gabrielli wrote:
> Dear Peter,
> thanks, I'm not sure I understand all the details but after a fast find i=
n my
> beagleboard /sys I found
> =

> ./sys/devices/68000000.ocp/49026000.mcbsp/dma_op_mode
> ./sys/devices/68000000.ocp/49022000.mcbsp/dma_op_mode
> ./sys/devices/68000000.ocp/49024000.mcbsp/dma_op_mode
> ./sys/devices/68000000.ocp/48096000.mcbsp/dma_op_mode
> ./sys/devices/68000000.ocp/48074000.mcbsp/dma_op_mode
> =

> All of these are already set as threshold:
> cat sys/devices/68000000.ocp/49022000.mcbsp/dma_op_mode
> [element] threshold

it is in 'element' mode, the [] shows the selected mode.
You can change it:
echo threshold > /sys/devices/68000000.ocp/49022000.mcbsp/dma_op_mode

> Probably I found the FIFOs to be shortened in order to reduce latency: al=
l of
> the thresholds are 112 besides one of the devices which has:
> cat sys/devices/68000000.ocp/49022000.mcbsp/max_rx_thres
> 1264
> for both tx and rx. Maybe that's the ALSA playback samples queue.

This is for the threshold mode. With this value you can set the maximum slo=
ts
you want to use in the McBSP FIFO.

To change it:
echo 320 > /sys/devices/68000000.ocp/49022000.mcbsp/max_tx_thres
echo 320 > /sys/devices/68000000.ocp/49022000.mcbsp/max_ex_thres

for example.

At the end with this value you can limit the sDMA burst sizes and the McBSP
FIFO level. The threshold means: generate DMA request if threshold number of
slots are free in the FIFO (playback) or when threshold amount of data
available in the FIFO (capture).

> =

> In fact I find:
> cat /proc/device-tree/ocp/mcbsp\@49022000/ti\,hwmods
> mcbsp2mcbsp2_sidetone
> =

> So it's the McBSP2 which you mentioned.
> =

> Now, I'm not sure how to change the threshold, I guess I have to patch so=
me
> kernel module and rebuild?

No, you do not need to recompile anything. See my previous comment.

> =

> =

> On 20/03/2014 14:35, Peter Ujfalusi wrote:
>> Hi Leonardo,
>>
>> On 03/20/2014 01:13 PM, Leonardo Gabrielli wrote:
>>> Dear Peter,
>>> I was investigating on TWL4030 high playback latency and stumbled in an=
 old
>>> thread started by Edgar
>>> http://mailman.alsa-project.org/pipermail/alsa-devel/2011-October/04517=
3.html
>>> where I read this is related to McBSP2 buffer length
>>> Recent kernels seems to have the same behavior (I have a debian beagleb=
oardxM
>>> with 3.13.3-armv7-x10)
>>> Did you manage to get a fix to this problem? Would it be possible?
>> The 'misusing/configuring the McBSP, and sDMA' did not worked :(
>> However the mcbsp code went through quite a bit of change since than
>> concerning the McBSP FIFO/sDMA configuration.
>>
>> If we have FIFO the sDMA is always in packet mode.
>> The default is to transfer one sample with sDMA per DMA request.
>> You can switch the McBSP to 'threshold' mode and set the maximum FIFO
>> threshold you want to use. The code will figure out the optimal FIFO/bur=
st
>> size based on the period size and the max threshold you have set.
>> This is done via a sysfs file under the mcbsp, the file is dma_op_mode i=
f I
>> recall correctly.
>> Playing with the max tx/rx threshold you might be able to get better lat=
ency.
>>
> =



-- =

P=E9ter
