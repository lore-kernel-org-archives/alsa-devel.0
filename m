From: Tim Goetze <tim@quitte.de>
Subject: Re: Why do I get broken pipe on write to a pcm in  
 statePREPARED?
Date: Tue, 17 Sep 2002 11:21:14 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.21.0209171108510.612-100000@summer.quitte>
References: <3D86E602.E1466721@libero.it>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <3D86E602.E1466721@libero.it>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=alsa-devel>
To: Abramo Bagnara <abramo.bagnara@libero.it>
Cc: Abramo Bagnara <abbagnara@racine.ra.it>, "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Abramo Bagnara wrote:

>> let's imagine:
>> 
>> * a single-threaded app. if the coder omits starting the stream before
>> poll, he'll quickly find out that nothing is played/recorded, and that
>> poll will hit the timeout, and consequently revise his code logic.
>
>It would be definitely not easy for the app. to detect *why* poll is
>blocking and it'd needs time. I think it would be a bad solution.

snd_pcm_state_t s = snd_pcm_state (pcm); // or
$ cat /proc/asound/card0/pcm0c/sub0/status # if all else fails.

are enough to enlighten the coder in this case. 

besides, if this happens in a single-threaded program, the code is
broken and should be fixed at coding, not execution time.

>> * a multi-threaded app. it is *very* convenient not to do the 'easy'
>> message passing for starting/stopping streams in many, many
>> applications. all you have to do in the 'engine' thread is poll and
>> process. i wonder if you can imagine how much easier things get when
>> things work this way.
>
>This argument might be applied to every message passing need between
>threads. Do we want to change an useful semantic to have just another
>way to do an already easy task? I don't believe so.

then take a look at how /dev/rtc does it. it does periodic irqs, 
much like a pcm. it is perfectly legal to poll /dev/rtc without
setting it to trigger, in which case it will block until timeout. 

i don't see why alsa has to do things differently, it is supposed to
be advanced *linux* sound arch after all, so make it act like other 
linux devices do, please.

>> i mean, alsa is great, but why do you have to make it a pita to code
>> for?
>
>I suppose you're exaggerating the thing to support your arguments, don't
>you ;-)

nope. coding the workaround around the broken poll behaviour 
definitely was a pita.

besides, i don't get what you aim for. you're doing things in
a non-standard way, and coders don't understand it. don't you
care about your users? and if you do, don't you care about 
complying with linux standards?

tim



-------------------------------------------------------
Sponsored by: AMD - Your access to the experts on Hammer Technology! 
Open Source & Linux Developers, register now for the AMD Developer 
Symposium. Code: EX8664 http://www.developwithamd.com/developerlab
