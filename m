From: Mads Kiilerich <mads@kiilerich.com>
Subject: Re: need help with io plugin programming: how to add
 delay ?
Date: Wed, 23 Dec 2009 17:39:16 +0100
Message-ID: <4B3247B4.4000506@kiilerich.com>
References: <4B312435.800@gmail.com>
	<4B315163.5090404@gmail.com>		<53baa24a0912221814t3e8628c4odc908c0813c0a56b@mail.gmail.com>		<4B31D184.3020300@gmail.com>	<53baa24a0912230128p5fee628en39b7b81f45e9fb9c@mail.gmail.com>
	<4B31FC67.2090201@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f212.google.com (mail-ew0-f212.google.com
	[209.85.219.212])
	by alsa0.perex.cz (Postfix) with ESMTP id 5EC3710380E
	for <alsa-devel@alsa-project.org>; Wed, 23 Dec 2009 17:39:20 +0100 (CET)
Received: by ewy4 with SMTP id 4so24436427ewy.32
	for <alsa-devel@alsa-project.org>; Wed, 23 Dec 2009 08:39:19 -0800 (PST)
In-Reply-To: <4B31FC67.2090201@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Stefan Schoenleitner <dev.c0debabe@gmail.com>
Cc: alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Stefan Schoenleitner wrote, On 12/23/2009 12:08 AM:
> However, the result is not satisfying at all as the delay between the received chunks varies and sometimes even takes a whole 15ms (!) longer (i.e. 35ms delay instead of 20ms).
>    
...
> As the calculation of the sleep time uses an *absolute* point of time
> as reference (which is takes before starting to poll() and recv() from the socket), all delay after the time measurement and before the actual sleep does not influence the precision, right ?
> For this reason I have no idea where the high delay variations are coming from.
> I mean how should it work with an alsa plugin if not even this simple simulation code works
> in a timely and precise manner ?
>
> * What am I doing wrong ?
>
> I thought of adding buffering so that the socket read operations do not have a strict timing schedule.
> However, as I said earlier, if the time for socket polling or recv varies, it does not influence the precision as an absolute point of time is used as timeout and the (absolute) start time measurement is done *before* all the socket operations.
> Thus I think that for this reason adding buffering would not make much difference here, right ?
>    

AFAIK ALSA gurantees no deadlines, so I think you will have to add a 
"sufficiently large" buffer somewhere - and make sure to handle 
over/underruns somehow anyway.

> Just before starting to write yet another implementation
> (the fourth one,

I did the same exercise. It _is_ really hard to get started writing 
sound applications and figure out which abstraction level and 
implementation to use and how to use it correctly.

I ended up coding for the pulseaudio API. My case was for 
http://bitbucket.org/kiilerix/tcpcam/ . The result isn't pretty, but it 
could have been worse. The result isn't very stable or understood in all 
details, but it is good enough for my case. This case is different than 
yours, but I had problems similar to yours when I tried to code for the 
ALSA api. My numbers also happens to be exactly the same as in your case.

> this time with jack)

Jack to some extent builds on top of ALSA, so jack can't do it any 
better than ALSA. But jack might use ALSA the right way and thus give 
you someting close to what you want. AFAIK.

> It is connected over UART at 460800 baud and requires exactly 160 16bit PCM samples
> with 8kHz sampling rate each 20ms for speech compression.
>    

It is my experience that it matters that two different oscillators never 
have exactly the same frequency, so over time you will get an over- or 
under-run.

/Mads
