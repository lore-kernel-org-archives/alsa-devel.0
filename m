From: James Courtier-Dutton <James@superbug.demon.co.uk>
Subject: Re: [PATCH] Fixes: Re: intel8x0 has stopped working.
Date: Thu, 05 Feb 2004 20:44:33 +0000
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <4022AB31.6070807@superbug.demon.co.uk>
References: <401E8BAE.6010802@superbug.demon.co.uk> <s5hn081uztv.wl@alsa2.suse.de> <401EA82D.3060702@superbug.demon.co.uk> <401ED94F.7080407@superbug.demon.co.uk> <Pine.LNX.4.58.0402031720190.8251@pnote.perex-int.cz> <40201EFF.9000903@superbug.demon.co.uk> <Pine.LNX.4.58.0402051154080.1864@pnote.perex-int.cz> <20040205191522.GE26089@zewt.org> <Pine.LNX.4.58.0402052030370.1864@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from anchor-post-35.mail.demon.net (anchor-post-35.mail.demon.net [194.217.242.85])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id VAA08091
	for <alsa-devel@alsa-project.org>; Thu, 5 Feb 2004 21:37:24 +0100
In-Reply-To: <Pine.LNX.4.58.0402052030370.1864@pnote.perex-int.cz>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jaroslav Kysela <perex@suse.cz>
Cc: Glenn Maynard <g_sf@zewt.org>, ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Jaroslav Kysela wrote:
> On Thu, 5 Feb 2004, Glenn Maynard wrote:
> 
> 
>>On Thu, Feb 05, 2004 at 12:01:28PM +0100, Jaroslav Kysela wrote:
>>
>>>>My point is, I don't think setting start_threshold to buffer_size is 
>>>>even "wrong" at all. Some people might want the buffer to be full before 
>>>>it starts, and my patch allows for that.
>>>
>>>It's not wrong semantics. I see - it's logical, but I don't want to follow
>>>some rule as some API designers does - control magically some things. I
>>>want that developer which uses our API knows what the library / driver
>>>exactly does.
>>>
>>>We have clear conditions when the stream is started. That's it.
>>
>>If this isn't guaranteed to work, I'd suggest making it never work.
> 
> 
> It's guaranteed to work.
> 
> 
>>Otherwise, programs will work on some hardware and not others, which is
>>a case that should be minimized as much as possible; it's these kinds
>>of subtle differences that make it very hard to write reliable (sound,
>>video, etc) code.  I've had to play games with setting hardware settings:
>>always set the sample rate even if I don't care, use a 32k buffer size
>>and not a 4k or 8k one--in order to make it work on as many systems as
>>possible without failing mysteriously or triggering alsa-lib asserts.
> 
> 
> Send us bug-reports if you have problems. We have not a magic ball.
> 
> 
>>(I don't quite understand why start_threashold == buffer_size doessn't
>>mean "start when the buffer is full", though.)
> 
> 
> Because we have the avail_min threshold which says that we don't want to
> write new data when buffer can accept less samples than this threshold. So
> if start_threshold is greather than '(buffer_size / avail_min) *
> avail_min' expression, then stream won't be automatically started, because
> we cannot fill data in read/write operations to satisfy the requirement
> that start_threshold == buffer_size.
> 
> Isn't this clear and right?

What you say is clear, but I don't think it is right.
If I understand it, you don't want to write samples into the buffer if 
less that X samples are free in the buffer.
We then have 2 possible situations: -
1) We wish to write more frames than X
In this case, we know that we wish to write enough frames to fill the 
buffer, so theoretically, the buffer is full, and thus start_threshold 
has been reached even before the actual alsa-lib internal write 
operation has happened. So, we could call snd_pcm_start() at this point.

2) We wish to write less frames than X
In this case, we know that if the write theoretically succeeded, we 
would not have a full buffer, so should not call snd_pcm_start(). But we 
are in catch22 here, because we cannot write any frames until we have X 
free frames in the buffer, but in SND_STATE_PREPARED (i.e. not RUNNING) 
the amount of free frames in the buffer will never change.

Conclusion: -
Due to the problem (2), we have to have start_threshold <= (buffer_size 
- avail_min) if we wish snd_pcm_start() to be automatically called in 
both case (1) and case(2).
If start_threshold > buffer_size, snd_pcm_start will never be called, 
and that is correct because some applications might want to manually 
control snd_pcm_start(). So, we will need range checks in the 
snd_pcm_sw_params_set_start_threshold() call so that the application 
writer is informed at a early stage about wrong settings, rather than 
finding out that snd_pcm_writei() fails on some sound cards but not others!
Summary: -
By me trying to argue that you are wrong, I have proved you right!

> 
> Of course, the "endless loop" is questionable in this case when the stream 
> is not running and we should probably return from the write function.
> 
> 						Jaroslav
> 

Cheers
James


-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
