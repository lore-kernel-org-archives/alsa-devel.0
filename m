From: Tim Goetze <tim@quitte.de>
Subject: Re: new "in-compatible" alsa-lib PCM API
Date: Wed, 18 Sep 2002 16:50:15 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.21.0209181615050.630-100000@summer.quitte>
References: <m2bs6vbds4.fsf@vador.mandrakesoft.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <m2bs6vbds4.fsf@vador.mandrakesoft.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=alsa-devel>
To: Thierry Vignaud <tvignaud@mandrakesoft.com>
Cc: Jaroslav Kysela <perex@perex.cz>, "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Thierry Vignaud wrote:

>Tim Goetze <tim@quitte.de> writes:
>
>> > autoconfiguration code to alsa.m4. My suggestion is to use
>> > /opt/alsa/rc3 directory for this job. Comments?
>>
>> /opt is redhat only, debian systems do not have it.
>
>err, even if i dislike it, /opt is defined by the fhs
>
>anyway, api incompatibles libraries can cohabit in the same place with
>different majors.
>
>debian and major enable one to have multiples versions of the same lib
>provided the upstream authors increase it major on each api and/or abi
>change. one can only have one devel library package (aka headers, ...)
>
>this is the /usr/share/aclocal/alsa.m4 job to provide right linking
>flags depending of the library

anyway, i agree with paul that pkg-config should be used instead,
which offers a lot more flexibility.

now that i think about it some more, i feel compelled to add:

this dance around the 0.9.0 version seems ridiculous to me. the
logical consequence of API changes is bumping the version number,
and not hiding it in a 'nano' version increment.

sorry for the harsh words,

tim




-------------------------------------------------------
This SF.NET email is sponsored by: AMD - Your access to the experts
on Hammer Technology! Open Source & Linux Developers, register now
for the AMD Developer Symposium. Code: EX8664
http://www.developwithamd.com/developerlab
