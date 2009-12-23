From: Stefan Schoenleitner <dev.c0debabe@gmail.com>
Subject: Re: need help with io plugin programming: how to add
 delay ?
Date: Wed, 23 Dec 2009 18:08:06 +0100
Message-ID: <4B324E76.7040003@gmail.com>
References: <4B312435.800@gmail.com>
	<4B315163.5090404@gmail.com>		<53baa24a0912221814t3e8628c4odc908c0813c0a56b@mail.gmail.com>		<4B31D184.3020300@gmail.com>	<53baa24a0912230128p5fee628en39b7b81f45e9fb9c@mail.gmail.com>
	<4B31FC67.2090201@gmail.com> <4B3247B4.4000506@kiilerich.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from netfinity.tbmn.org (mail.tbmn.org [88.117.197.126])
	by alsa0.perex.cz (Postfix) with ESMTP id EBD711038A1
	for <alsa-devel@alsa-project.org>; Wed, 23 Dec 2009 18:08:27 +0100 (CET)
In-Reply-To: <4B3247B4.4000506@kiilerich.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mads Kiilerich <mads@kiilerich.com>
Cc: alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi,

Mads Kiilerich wrote:   
> AFAIK ALSA gurantees no deadlines, so I think you will have to add a
> "sufficiently large" buffer somewhere - and make sure to handle
> over/underruns somehow anyway.

I already thought that this would help.
So the alsa plugin would then fill some large buffer in my daemon
application and instead of receiving the data from a socket I would
have it available in some application buffer already.
Thus I could just read the frames from the application
buffer each 20ms and send them over UART to the DSP.

However, right now I found out that there seems to be no way
to execute *anything* each 20ms +/- 1ms.

So far I tried

	* nanosleep()
	* pthread_cond_timed_wait()
	* usleep()

I'm looking forward to try

	* HPET
	* RTC
	* setitimer()
	* alsa timers ?
	* anything else ?

I don't understand why all the function I have tried
so far have microsecond or even nanosecond precision and in the
end I'm off not for some nano- or microseconds, but for a full 15ms !
This is really bad :(


>> Just before starting to write yet another implementation
>> (the fourth one,
> 
> I did the same exercise. It _is_ really hard to get started writing
> sound applications and figure out which abstraction level and
> implementation to use and how to use it correctly.

Indeed.


> I ended up coding for the pulseaudio API. My case was for
> http://bitbucket.org/kiilerix/tcpcam/ . The result isn't pretty, but it
> could have been worse. The result isn't very stable or understood in all
> details, but it is good enough for my case. This case is different than
> yours, but I had problems similar to yours when I tried to code for the
> ALSA api. My numbers also happens to be exactly the same as in your case.

As you said it's a different case.

>> this time with jack)
> 
> Jack to some extent builds on top of ALSA, so jack can't do it any
> better than ALSA. But jack might use ALSA the right way and thus give
> you someting close to what you want. AFAIK.

I looked at some code already.
Generally speaking it looks good, but it also uses 32 bit floating
point format for example (while I would need 8Khz 16bit LE).
It seems a little bit of a detour if I use:

ALSA --> jack io plugin --> jackd --> jack-client --> resample and change format --> my application

instead of

ALSA --> my plugin --> my application


As I said above, right now the problem is not even fully alsa related.
It is how I can execute something (e.g. my uart send code) each 20ms +/- 1ms.


>> It is connected over UART at 460800 baud and requires exactly 160
>> 16bit PCM samples
>> with 8kHz sampling rate each 20ms for speech compression.
>>    
> 
> It is my experience that it matters that two different oscillators never
> have exactly the same frequency, so over time you will get an over- or
> under-run.

Yes, I will have to deal with this as well :(
However, from time to time an overflow/underrun should be ok as long it
is generally working I guess.

Thanks for your inspiring words,
stefan
