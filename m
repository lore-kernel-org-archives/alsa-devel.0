From: stan <ghjeold_i_mwee@cox.net>
Subject: Re: XRUN happens too often.
Date: Wed, 09 Apr 2008 15:28:02 -0700
Message-ID: <47FD42F2.70903@cox.net>
References: <loom.20080408T090019-595@post.gmane.org>	<loom.20080408T113541-885@post.gmane.org>	<47FB8D57.8030904@cox.net>
	<loom.20080409T051547-963@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fed1rmmtao105.cox.net (fed1rmmtao105.cox.net [68.230.241.41])
	by alsa0.perex.cz (Postfix) with ESMTP id BD96810381A
	for <alsa-devel@alsa-project.org>;
	Thu, 10 Apr 2008 00:28:05 +0200 (CEST)
In-Reply-To: <loom.20080409T051547-963@post.gmane.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Rong-Jhe <r93922118@ntu.edu.tw>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Rong-Jhe wrote:
>> I don't have a direct answer for you, but I have an application that seems
>> to be able to write data using writei with no problems at rates up to
>> 192 KHz.  You can download it from sourceforge and look at the source.
>>
>> http://sourceforge.net/projects/discord/ 
>>
>> I copied and adapted from other examples on the web.  Do a search for 
>> alsa in
>> the source code and it should take you to the initialization function 
>> and the
>> playing function.
>>
>>     
>
> Thanks for your help.
> I think that XRUN may happen because the time of using snd_pcm_writei().
> I have a problem about snd_pcm_write().
> If the pcm is block, when does snd_pcm_writei() return?
>
> I try to write the audio data into the dsp file directly without ALSA library.
> The data will be written into DMA of the soundcard.
> This action of writting is asynchronous, and the write() returns after 
> queueing the data intto the DMA.
>
> I guess the problem may be caused by the late time which the second 
> snd_pcm_writei() is called.
> The time between two snd_pcm_writei() may be too long, so the pcm enters XRUN 
> state.
>
> The period time in this pcm is 21333 us, and the buffer time is 213330 us 
> because there are 10 periods in a buffer.
>
> I recorded the time timeA that snd_pcm_writei() is called, and the time timeB 
> that snd_pcm_writei() returns.
> I calculate the duration between timeA and timeB, and the duration is not 
> regular.
>
> If snd_pcm_writei() is synchronous, the duration may be equal to the buffer 
> time( 10xperiod time).
> According to the measurement, snd_pcm_writei() seems not to be synchronous.
> Can anyone tell me the basic theory of snd_pcm_writei(), especially in dmix 
> mode.
>
>   
I'm not sure I understand what your asking, and I don't know if
I'm the right person to answer at any rate :-), but here goes.

I think you are asking why there is variation in the time that a
system call takes (writei is calling the alsa library, a system library),
and if so then it is because all modern OSs have multitasking and 
interrupts.
Even hardened real time systems can have variation on interrupt
call response times, depending on what is happening.  The write to the sound
device is an interrupt, and the OS controls that.

That being said, if you are having underruns because of interrupt processing
time you are very close to the limit on your system.  I don't think that can
be it unless you are doing something like video processing at the time 
you are
playing, or something like beagle or dbupdate is running (higher 
priority tasks
than the sound card unless you have real time sound set).
