From: mru@users.sourceforge.net (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Subject: Re: ring buffer pointer accuracy.
Date: Mon, 14 Jul 2003 18:53:19 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <yw1xk7al82yo.fsf@users.sourceforge.net>
References: <3F12C37F.4020402@superbug.demon.co.uk> <XFMail.20030714175754.pochini@shiny.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Giuliano Pochini <pochini@shiny.it> writes:

>> I would like some idea of how accurate the snd_pcm_delay() result is
>> likely to be. If I am trying to syncronise video to audio, and I notice
>> a difference between audio and video, I need to know how accurate I can
>> make it.
>
> I suppose you need a precision of 42ms (the duration of a cinema frame).
> You can read the position at intervals <= 42ms. If the value you read is
> different then the previous one, you know that value is up to date.
> You know exactly when you started to play the sound. If you do your own
> timing and you take into account the period time, you only need to read
> position 3-4 times every 10s or so to check if you are losing sync.

You could use the ALSA timer interface.  It gives a resolution equal
to the period time.  If that's too long time, you can use the system
clock to interpolate.

> Even if you have a really bad soundcard, it's unlikely the sample clock
> skews more than 1%.

1% would be about a minute at the end of normal movie.  That's not
what I like to call acceptable.

>> If some cards only update "delay" once per period, but others update it
>> all the time, I would like the application to know about it, so it can
>> decide how accurately it can actually get audio and video in sync.
>
> You can use shorter periods if your cards allows it.

Most cards I've come across support period lengths of down to 10 ms or
less.  That's plenty enough for video playback.

-- 
Måns Rullgård
mru@users.sf.net



-------------------------------------------------------
This SF.Net email sponsored by: Parasoft
Error proof Web apps, automate testing & more.
Download & eval WebKing and get a free book.
www.parasoft.com/bulletproofapps1
