From: Thierry Vignaud <tvignaud@mandrakesoft.com>
Subject: Re: new "in-compatible" alsa-lib PCM API
Date: Wed, 18 Sep 2002 15:58:19 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <m2bs6vbds4.fsf@vador.mandrakesoft.com>
References: <Pine.LNX.4.21.0209181512140.630-100000@summer.quitte>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.21.0209181512140.630-100000@summer.quitte> (Tim
 Goetze's message of "Wed, 18 Sep 2002 15:15:02 +0200 (CEST)")
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=alsa-devel>
To: Tim Goetze <tim@quitte.de>
Cc: Jaroslav Kysela <perex@perex.cz>, "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Tim Goetze <tim@quitte.de> writes:

> > autoconfiguration code to alsa.m4. My suggestion is to use
> > /opt/alsa/rc3 directory for this job. Comments?
>
> /opt is redhat only, debian systems do not have it.

err, even if i dislike it, /opt is defined by the fhs

anyway, api incompatibles libraries can cohabit in the same place with
different majors.

debian and major enable one to have multiples versions of the same lib
provided the upstream authors increase it major on each api and/or abi
change. one can only have one devel library package (aka headers, ...)

this is the /usr/share/aclocal/alsa.m4 job to provide right linking
flags depending of the library



-------------------------------------------------------
This SF.NET email is sponsored by: AMD - Your access to the experts
on Hammer Technology! Open Source & Linux Developers, register now
for the AMD Developer Symposium. Code: EX8664
http://www.developwithamd.com/developerlab
