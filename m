From: Giuliano Pochini <pochini@shiny.it>
Subject: Re: ring buffer pointer accuracy.
Date: Mon, 14 Jul 2003 17:57:54 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <XFMail.20030714175754.pochini@shiny.it>
References: <3F12C37F.4020402@superbug.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <3F12C37F.4020402@superbug.demon.co.uk>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: James Courtier-Dutton <James@superbug.demon.co.uk>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


On 14-Jul-2003 James Courtier-Dutton wrote:
>>>Worst case accuracy is about one period AFAIK. It depends on the sound chip
>>>because the low level driver reads the DMA pointer (or something) from some
>>>hardware register or it can know the DMA pointer when it receives an interrupt
>>>at the end of a period.
>>
>>
>> yes.  if the accuracy is in period size, at least it should work
>> somehow.  e.g. the time-slider of a player might not move so smooth
>> but it must not be critical.
>>
>>
> I would like some idea of how accurate the snd_pcm_delay() result is
> likely to be. If I am trying to syncronise video to audio, and I notice
> a difference between audio and video, I need to know how accurate I can
> make it.

I suppose you need a precision of 42ms (the duration of a cinema frame).
You can read the position at intervals <= 42ms. If the value you read is
different then the previous one, you know that value is up to date.
You know exactly when you started to play the sound. If you do your own
timing and you take into account the period time, you only need to read
position 3-4 times every 10s or so to check if you are losing sync.
Even if you have a really bad soundcard, it's unlikely the sample clock
skews more than 1%.

> If some cards only update "delay" once per period, but others update it
> all the time, I would like the application to know about it, so it can
> decide how accurately it can actually get audio and video in sync.

You can use shorter periods if your cards allows it.


Bye.



-------------------------------------------------------
This SF.Net email sponsored by: Parasoft
Error proof Web apps, automate testing & more.
Download & eval WebKing and get a free book.
www.parasoft.com/bulletproofapps1
