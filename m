From: Paul Davis <pbd@op.net>
Subject: Re: Help with LATENCY FULL DUPLEX AUDIO
Date: Thu, 25 Apr 2002 20:08:07 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200204260004.g3Q04Mr10452@post2.fast.net>
References: <7d937d1dab6560bf3997dd6661e5cdff@www1.mail.volny.cz>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: Your message of "Fri, 26 Apr 2002 01:16:58 +0200."
             <7d937d1dab6560bf3997dd6661e5cdff@www1.mail.volny.cz>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: pavelni@volny.cz
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

>The documentation you writed - mini fullduplex is incomplete
>and have a lot of wrongs (I send some corrects for mini capture and
>playback before).

yes, i need to catch up on that stuff. oh for spare time. did i
mention i just bought a house and need to redecorate it and move? :)

>alsa-lib is api documentation and do not have practical advices to
>write easy way mini full duplex aplication (or applications).
>
>I do not have much time to research how to write it.
>But I am look forward when the nice documentation will exist or I
>will have much time to more try on it.

Jack will do all this for you. If you don't want to use Jack, then its
alsa_driver.c exists as an example of how to do efficient, low latency
full duplex (as well as half-duplex in either direction, with the same
code, just a cmdline option to change the behaviour).

If your app is useful, it would be nice for everyone to be able to use
it with Jack - then we can route signals from other apps to it and
vice versa.

--p
