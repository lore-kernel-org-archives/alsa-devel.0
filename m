From: Paul Davis <paul@linuxaudiosystems.com>
Subject: Re: ham radio OSS duplex realtime mmap program.
Date: Fri, 26 Sep 2003 07:47:30 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200309261147.h8QBlUCK011127@oud>
References: <200309251628.48034.Safari.Doktor@addcom.de>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: Your message of "Fri, 26 Sep 2003 13:26:01 +0200."
             <200309251628.48034.Safari.Doktor@addcom.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: "Dr. med. =?iso-8859-15?q?G=FCnther?= Montag" <Safari.Doktor@addcom.de>
Cc: alsa-devel@lists.sourceforge.net, hfterm-hackers@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

>Hello
>I work at "hfkernel" by Tom Sailer, a program for pactor/rtty (soundcard =
>ham=20
>radio digimodes). It seems complicated, because it uses realtime scheduli=
>ng,=20
>select(), mmap(), and runs in 3 threads.=20
>It was made in 1996 for OSS; I am trying to get it running with ALSA.=20

JACK already does this kind of stuff. You'd save yourself major
headaches by starting off doing it as a JACK client. Alternatively,
use the JACK source as a guide, although its very complex because it
is intended to handle many channels in a very robust way, with
complete xrun detection.

http://jackit.sf.net/

another alternative source of ideas would be ecasound's own ALSA code.

--p


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
