From: ylin@mail.com
Subject: Re: Channel swapping issue on TI OMAP3/TWL4030
Date: Sat, 19 Feb 2011 11:08:34 -0500
Message-ID: <8CD9E665EC96F93-126C-1145E@web-mmc-d04.sysops.aol.com>
References: <8CD98E75F0E83E2-63C-14642@web-mmc-m05.sysops.aol.com>	<CF32F28EDF8D20468EEDCBE4975DA0274A46DB@008-AM1MPN1-027.mgdnok.nokia.com><8CD9A87EF4FB765-1218-647@web-mmc-m03.sysops.aol.com>	<4D5A2466.2060705@nokia.com><8CD9B43DFD8A17C-DE8-B3DD@web-mmc-d01.sysops.aol.com>	<4D5B7AB5.201@nokia.com><8CD9C6B934040FF-13C8-4BFB@web-mmc-d06.sysops.aol.com>
	<4D5D0A0E.5030505@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from imr-mb01.mx.aol.com (imr-mb01.mx.aol.com [64.12.207.164])
	by alsa0.perex.cz (Postfix) with ESMTP id 554A124629
	for <alsa-devel@alsa-project.org>; Sat, 19 Feb 2011 17:08:47 +0100 (CET)
Received: from imo-ma03.mx.aol.com (imo-ma03.mx.aol.com [64.12.78.138])
	by imr-mb01.mx.aol.com (8.14.1/8.14.1) with ESMTP id p1JG8fue015117
	for <alsa-devel@alsa-project.org>; Sat, 19 Feb 2011 11:08:41 -0500
Received: from ylin@mail.com
	by imo-ma03.mx.aol.com  (mail_out_v42.9.) id 5.beb.6d2c5cf5 (44222)
	for <alsa-devel@alsa-project.org>; Sat, 19 Feb 2011 11:08:36 -0500 (EST)
In-Reply-To: <4D5D0A0E.5030505@nokia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


> > We tried element and frame mode, playback doesn't sound correct 
with
> > these mode, but the capture is OK.
>
> Hrm, this does not sound right... Historically the element mode was 
the
> first and only mode of using McBSP. The threshold mode has been added 
later.
> Could you explain what do you mean, when you said that the playback 
was
> not correct?
> I have never experienced problems with the element mode.

The element mode works fine with playback after I fill more data to the 
buffer.  We try to optimize the delay and keep the minimum data in the 
buffer.  However, the element mode timing is slightly different from 
threshold, and we have under-run condition.  With filling extra data to 
the buffer, the element mode works fine.  We are testing if we see the 
channel switch with this mode.

> In what mode you are using the TWL4030 codec? Is it master?
> If it is master, can you compare your machine driver with for example
> the Beagle board's machine driver?

It is in master mode.  We are using OMAP3EVM board as reference.  Our 
kernel is based on the TI P3P release.
# /proc/ti-psp-version
AM37x/DM37x  Linux PSP version 03.00.01.06 (OMAP3PHX)
We are using the same audio drivers for OMAP3EVM.  There is only some 
unrelated patches to the driver, such as ramp delay and Bluetooth PCM 
support.

> Or can you share the relevant configuration (from your machine driver)
> with us?

I am not sure exactly the relevant configuration to share.  Here is  
the TWL4030 codec registers with both Tx and Rx audio running.  Please 
let me know if you like to see other configurations and I can pull them 
out.
# cat /sys/devices/platform/soc-audio/codec_reg
twl4030 registers
 0:    0
 1:   a3
 2:   c3
 3:    0
 4:    7
 5:   31
 6:    0
 7:    8
 8:    0
 9:    0
 a:    9
 b:    9
 c:    9
 d:    9
 e:    1
 f:    0
10:    0
11:    0
12:   3f
13:   3f
14:    0
15:    0
16:    0
17:    c
18:    0
19:    0
1a:    0
1b:   2b
1c:   2b
1d:    0
1e:    0
1f:    0
20:    0
21:   10
22:    0
23:    5
24:    4
25:    0
26:    0
27:    0
28:    0
29:    0
2a:   3f
2b:    0
2c:    0
2d:    0
2e:    0
2f:    0
30:    0
31:    0
32:    0
33:    0
34:    0
35:    0
36:    0
37:    0
38:    0
39:    0
3a:   16
3b:    0
3c:    0
3d:    0
3e:    2
3f:    0
40:    0
41:    0
42:    0
43:    0
44:    0
45:    0
46:    0
47:    0
48:   22
49:    0
4a:    2
#

> > and focus on McBSP and DMA.  We don't
> > have chance to check McBSP overflow/underflow as you suggested yet.
>
> If we don't figure out what is the problem, you might need to do 
this...

I am working on this.

Thanks,
Ying
