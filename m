From: "Jin-Young Park" <mcjin02@gmail.com>
Subject: Re: What recommended performance for ALSA(ASoC)?
Date: Sat, 8 Mar 2008 02:25:49 +0900
Message-ID: <280b69ac0803070925w4a0e68f3mfc2fd13111167590@mail.gmail.com>
References: <5BF78BCE8D9BF14A83F836BD9E3916BA053FDA@blrms.slti.sanyo.co.in>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ik-out-1112.google.com (ik-out-1112.google.com [66.249.90.177])
	by alsa0.perex.cz (Postfix) with ESMTP id 366372461C
	for <alsa-devel@alsa-project.org>; Fri,  7 Mar 2008 18:25:52 +0100 (CET)
Received: by ik-out-1112.google.com with SMTP id b32so777748ika.0
	for <alsa-devel@alsa-project.org>; Fri, 07 Mar 2008 09:25:51 -0800 (PST)
In-Reply-To: <5BF78BCE8D9BF14A83F836BD9E3916BA053FDA@blrms.slti.sanyo.co.in>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Prithwee Narayan N S <prithweens@sanyo.co.in>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Thanks for your reply.
Your advises are very important information for me. Because explained your
target system is very similar my target system.

> I would like to say ALSA will perfectly runs on your target SOC clock.
> I am running it on 192MHz ARM926 core along with H.264 video decoder!!!.
> BogoMIPS = 95.84.
> Even I had the same glitch problem before.

Following debugging tips are very helpful.
I have questions about debugging tips.

> Few debug steps here:
> 1.      Check the DMA Configuration. (Transfer size, buffer size and
number of Transfers)
> 2.      Does your period,period bytes ,buffer size of Ringbuffer matcheswith the DMA buffer?

What is your ALSA driver setting that buffer bytes, period bytes, periods?
Current my driver setting values are buffer bytes(4KBytes), period
bytes(2KBytes), periods(2).

>Check the correct re-initilization of "period" once the buffer is full.

What does meannig? I don't understand.
And what is proper function for checking buffer and period?
prepare,trigger,irq handler, pointer...

> 3.      Check the current DMA postion at the point of "pointer" callback.This should be equal to number of samples send to the PCM middle layer.
> 4.      As Jaroslav says disc read speed should be > (44100*2*16) for
44.1K 16bit stereo. Or else read from NFSBOOT if your SOC support Ethernet.
 > 5.      Always test with a "sinewave" for glitchs, not with your
favoritesong J

Tell me recommended music for audio test.


Thanks.
