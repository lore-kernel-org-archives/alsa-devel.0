From: Kai Vehmanen <kvehmanen@eca.cx>
Subject: Re: safe support for rewind in ALSA
Date: Tue, 9 Feb 2010 22:54:31 +0200 (EET)
Message-ID: <alpine.DEB.1.10.1002092242540.3125@ecabase.localdomain>
References: <6160a5131002010920j4417a34ai9f410fb500f7f305@mail.gmail.com>
	<20100201180139.GC15509@sirena.org.uk>
	<alpine.LNX.2.00.1002011903330.25340@eeebox2.perex-int.cz>
	<alpine.DEB.1.10.1002012239220.3125@ecabase.localdomain>
	<alpine.DEB.1.10.1002012328440.3125@ecabase.localdomain>
	<4f3252891002081459q29f02414hf168a596ab641995@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from gw01.mail.saunalahti.fi (gw01.mail.saunalahti.fi
	[195.197.172.115])
	by alsa0.perex.cz (Postfix) with ESMTP id 1BD2A10381A
	for <alsa-devel@alsa-project.org>; Tue,  9 Feb 2010 21:58:06 +0100 (CET)
In-Reply-To: <4f3252891002081459q29f02414hf168a596ab641995@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Raymond Yau <superquad.vortex2@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

On Tue, 9 Feb 2010, Raymond Yau wrote:

>>>  - at T3, application calls snd_pcm_delay() to query how many samples
>>>   of delay there is currently (e.g. if it write a sample to ALSA
>>>   PCM device now, how long before it hits the speaker)
>
> No, your assumption (how long before it hits the speaker ) is wrong , refer
> to
>
> http://www.alsa-project.org/alsa-doc/alsa-lib/group___p_c_m.html

I have trouble following your logic here. I mean:

> For playback the delay is defined as the time that a frame that is written
> to the PCM stream shortly after this call will take to be actually audible.
> It is as such the overall latency from the write call to the final DAC.

Isn't that _exactly_ what I wrote above?

I.e. this is the purpose of snd_pcm_delay() and why application developers 
use it for e.g. audio/video sync. So what's the difference? Do you mean 
that speaker!=DAC, or...?

> why do PA insist to use one period per buffer when only those ISA drivers
> and intel8x0 have periods_min =1 , the most common HDA driver and most sound
> cards have periods_min =2 ?

That is discussed at length here:
http://0pointer.de/blog/projects/pulse-glitch-free.html
