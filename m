From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: mapping externally allocated Scatter Gather DMA
 buffers
Date: Wed, 10 Nov 2010 08:05:00 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1011100755560.29422@eeebox2.perex-int.cz>
References: <AANLkTik4VQmsvBiXyoj-wEu5jgjpPVRP0bF7gkp9GJ-E@mail.gmail.com>
	<alpine.LNX.2.00.1010260923070.29422@eeebox2.perex-int.cz>
	<AANLkTin58toyQJ0f3M3abszE0zgV+t9R29rsFKin74vk@mail.gmail.com>
	<alpine.LNX.2.00.1011091300130.29422@eeebox2.perex-int.cz>
	<AANLkTikzXbnnPBNS+51zFvrYVqOTw8bz1=qWq_h--y35@mail.gmail.com>
	<alpine.LNX.2.00.1011091347020.29422@eeebox2.perex-int.cz>
	<AANLkTikHL5-6nuf6_sbkAX+y_vUo57tF-SW_j75ijEPJ@mail.gmail.com>
	<alpine.LNX.2.00.1011091530230.29422@eeebox2.perex-int.cz>
	<AANLkTimTrFLv911vVm-eH9EqDyXEwg-y4uFkqbUyVB7v@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id F08EC103857
	for <alsa-devel@alsa-project.org>; Wed, 10 Nov 2010 08:05:01 +0100 (CET)
In-Reply-To: <AANLkTimTrFLv911vVm-eH9EqDyXEwg-y4uFkqbUyVB7v@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Manu Abraham <abraham.manu@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, 10 Nov 2010, Manu Abraham wrote:

> testbox ~ # arecord -Dplughw:2,0
> Recording WAVE 'stdin' : Unsigned 8 bit, Rate 8000 Hz, Mono
> ALSA lib pcm_mmap.c:369:(snd_pcm_mmap) mmap failed: Invalid argument
> arecord: set_params:1041: Unable to install hw params:

set_params fails, because snd_pcm_mmap (mmap() syscall) failed for your 
driver. The configuration space for hw_params is now OK.

You have to check sound/core/pcm_native.c, if snd_pcm_default_mmap() and 
snd_pcm_mmap_data() implementation matches the mmap policy for your DMA 
buffer. You may create your own mmap callback - substream->ops->mmap.

> bufsiz=31872 periods=83 bytes=384

This looks correct. Frame (in ALSA meaning) is 2 8-bit unsigned samples 
(you have forced to use 2 channels in your hw->ops). Thus 192 frames is 
384 bytes for this stream format. Perhaps, your frame is not ALSA frame.

ALSA frame: channels * sizeof(sample)

> Now, I wonder what a period really is. I guess I lack the basics here
> .. A basic explanation to the context,
> would be quite helpful.

Period is just a time after which should the driver acknowledge the 
transferred samples. Note that it's preffered to also allow large periods 
(if you can set hw to not acknowledge each DMA block transfer).

 						Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.
