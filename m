From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Some questions related to ALSA based duplex audio
 processing
Date: Tue, 31 Jan 2012 14:30:53 +0100
Message-ID: <4F27ED0D.9030002@ladisch.de>
References: <4F259BD1.4030001@ind.rwth-aachen.de> <4F27C51F.1000202@ladisch.de>
	<4F27D30B.6010607@ind.rwth-aachen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com
	[66.111.4.27]) by alsa0.perex.cz (Postfix) with ESMTP id 2838A246B5
	for <alsa-devel@alsa-project.org>; Tue, 31 Jan 2012 14:28:37 +0100 (CET)
Received: from compute4.internal (compute4.nyi.mail.srv.osa [10.202.2.44])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 4C93F20E5C
	for <alsa-devel@alsa-project.org>; Tue, 31 Jan 2012 08:28:34 -0500 (EST)
In-Reply-To: <4F27D30B.6010607@ind.rwth-aachen.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: public-hk <public-hk@ind.rwth-aachen.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

public-hk wrote:
>>> I have understood from the docs that the snd_pcm_read/snd_pcm_write
>>> functions do nothing else than addressing the memory mapped areas. As a conclusion, I realize
>>> this access myself to have more control about it.
>>
>> Why do you want to duplicate snd_pcm_read/write?  What do you "control"
>> there, i.e., what are you doing differently?
>
> The additional degree of freedom is that I see the amount of samples which are available in the mmap'ed buffer whereas with read and write, I only get the notification that
> a specific amount of samples has been available (based on the number of samples to be read/written specified when calling the function).

snd_pcm_avail()

>>> And by using the async callbacks, I do not have to deal with blocking or non-blocking read functions or polling related issues.
>>
>> But instead you have to deal with signal delivery.  Besides being
>> nonportable, you are not allowed to do anything useful inside a signal
>> handler.
>
> Why is this nonportable?

Not every sound device type supports async callbacks.

> The sound APIs that I dealt with before more or less by definition work based on callback mechanisms (ASIO, CoreAudio).
> What is the restriction considering the processing that I plan within the signal handler?

Signals are _not_ threads; they are sent to an existing process or
thread, and interrupt it.

Most functions are not reentrant and therefore cannot be called from
a signal handler.  The only useful thing you _can_ do is to write to
a pipe to wake up another thread that waits with poll() for this
notification, but then you could just as well wait for the device
itself.

> Is that a documented restriction?

http://pubs.opengroup.org/onlinepubs/009695399/functions/xsh_chap02_04.html

(ALSA uses SIGIO.  SIGEV_THREAD is not supported.)

> A possible alternative realization would be to start a thread in which I do
> 1) pcm_read
> 2) process audio samples
> 3) pcm_write
> in an infinite loop. In this case, however, the "read" would also block the "write" for a specific
> time. This architecture would
> a) introduce additional delay if I miss the next required "write" due to the blocking "read".
> b) might reduce the available processing time (operation "process audio samples")  since I have "wasted" time in the blocking "read".

Then use non-blocking mode.
(Or use a library that does this for you.)


Regards,
Clemens
