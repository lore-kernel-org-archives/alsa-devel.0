From: Paul Davis <paul@linuxaudiosystems.com>
Subject: Re: RME9632 Precise Pointer option problem (attn Thomas Charbonnel)
Date: Mon, 27 Sep 2004 16:11:48 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200409272011.i8RKBm5e019024@localhost.localdomain>
References: <1096294072.2173.18.camel@localhost>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: Your message of "Mon, 27 Sep 2004 10:07:52 EDT."
             <1096294072.2173.18.camel@localhost>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: mjander@users.sourceforge.net
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

>This would not be the first soundcard that needs some conditions to be
>met, in order to have a valid value on such kind of register. There
>maybe some flags that indicate that the value is correct, or you need to
>flag eplicitly that you want to read it. Hopefuly you have the specs, if
>not, pass the WDM driver through IDA pro and you probably know what i
>mean :). Or maybe a previous I/O operation, register access or whatever
>keeps the card busy ? There are many things that could be wrong (check
>timing issues).

AFAIK, there is no WDM driver, just ASIO, and ASIO doesn't require an
accurate hw ptr.



-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM.
Deadline: Sept. 24. Go here: http://sf.net/ppc_contest.php
