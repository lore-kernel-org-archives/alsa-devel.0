From: Paul Davis <paul@linuxaudiosystems.com>
Subject: Re: Lowest latency: JACK, or ALSA directly?
Date: Thu, 11 Nov 2004 10:34:08 -0500
Message-ID: <200411111534.iABFY8UK012314@localhost.localdomain>
References: <20041111144152.GA12443@stud.ntnu.no>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: Your message of "Thu, 11 Nov 2004 15:41:53 +0100."
             <20041111144152.GA12443@stud.ntnu.no>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Asbj rn S b  <asbjs@stud.ntnu.no>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

>As I understand it, JACK acts as a middle layer between a (jack-aware)
>application and the underlying ALSA libraries.  But it is also possible
>to program against the ALSA libraries directly (which I am doing now).
>
>I am writing an application for audio transfer over network, where the
>main goal is to achieve the lowest latency possible.  I would assume
>that, as JACK adds an extra layer, it may also introduce extra latency. =20
>Is that so?  And in that case, how much may be gained by using the ALSA
>libs directly, instead of going through ALSA?

it doesn't *add* any latency at all. what it might conceivably do is
to prevent a given application from reaching the lowest possible
latency, because of the extra context switching involved in JACK. so
far, however, this doesn't appear to be the case - people have JACK
running at the same latency settings as they could get with ALSA. so
the effect is marginal if its measurable at all.

>Although I so far barely have gotten into ALSA programming, it does seem
>to be manageable in difficulty. (Don't laugh, I am an aconcy austican, not a=20
>programmer.)  How is programming against JACK in comparison?

JACK is *massively* simpler.

>As far as I understand it, the main advantages of JACK are the=20
>possibility to connect together several applications, as well as the=20
>ability to keep these applications in sync.  That is however not very=20
>important to me now, as I will probably not need to connect to other=20
>programs.  Are there other important advantages?  And what are the=20
>disadvantages?

You can forget all about h/w configuration, sample format, and program
structure. JACK takes care of all that, though some people would say imposes it own
choices on your application

--p


-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
