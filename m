From: Paul Davis <paul@linuxaudiosystems.com>
Subject: Re: Re: dmix plugin
Date: Thu, 20 Feb 2003 13:26:20 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <E18lvNx-0000A6-00@sc8-sf-list1.sourceforge.net>
References: <3E551713.7E5BB141@libero.it>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: Your message of "Thu, 20 Feb 2003 18:57:39 +0100."
             <3E551713.7E5BB141@libero.it>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

>The server based approach has an added cost of an extra context switch
>every period (about 1500 cycles on my machine i.e.), but this is fully
>amortized by such an huge difference.

recall that (1) the context switch time is not a fixed cost but
depends on the memory behaviour between switches and (2) isn't it
either two switches per participating client/application, or if they
are chained (as in JACK), N+2 switches, where N is the number of
clients/applications ?



-------------------------------------------------------
This SF.net email is sponsored by: SlickEdit Inc. Develop an edge.
The most comprehensive and flexible code editor you can use.
Code faster. C/C++, C#, Java, HTML, XML, many more. FREE 30-Day Trial.
www.slickedit.com/sourceforge
