From: Paul Davis <pbd@op.net>
Subject: Re: different nperiods for capture and playback when opening a device in duplex mode ?
Date: Wed, 10 Jul 2002 13:34:03 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <E17SLJx-0003au-00@usw-sf-list1.sourceforge.net>
References: <3D2C5D98.18C4EC22@folkwang-hochschule.de>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: Your message of "Wed, 10 Jul 2002 18:15:20 +0200."
             <3D2C5D98.18C4EC22@folkwang-hochschule.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Joern Nettingsmeier <nettings@folkwang-hochschule.de>
Cc: "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

>is it possible with alsa to use different settings for capture and
>playback, either periods or buffer size or both ?
>if yes, i might try and add that to jack, but since this is my first
>undertaking with alsa programming, i thought i'd ask first :)
>
>i got this idea from glame, which uses 2 and 4 periods and also
>different sizes and runs dropout-free. it does not however open the card
>full-duplex, but uses two threads that operate in halfduplex mode
>instead.

ALSA doesn't support "full duplex" to start with. You always have to
open two separate handles for this. Hence, the problem is 100% inside
of JACK's ALSA driver/client. It is written to use the same number of
periods in both directions. It would be possible to change this but it
would not be easy.

Your problems with JACK are caused by a different problem as far as I
can tell (so far), and GLAME's design won't help. More on the jack-dev
list later today (i hope).

--p


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Two, two, TWO treats in one.
http://thinkgeek.com/sf
