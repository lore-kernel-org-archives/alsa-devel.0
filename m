From: Paul Davis <pbd@op.net>
Subject: Re: new "in-compatible" alsa-lib PCM API
Date: Wed, 18 Sep 2002 10:19:48 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <E17rfe8-0004lZ-00@usw-sf-list1.sourceforge.net>
References: <m2bs6vbds4.fsf@vador.mandrakesoft.com>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: Your message of "Wed, 18 Sep 2002 15:58:19 +0200."
             <m2bs6vbds4.fsf@vador.mandrakesoft.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=alsa-devel>
To: Thierry Vignaud <tvignaud@mandrakesoft.com>
Cc: Tim Goetze <tim@quitte.de>, Jaroslav Kysela <perex@perex.cz>, "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

>this is the /usr/share/aclocal/alsa.m4 job to provide right linking
>flags depending of the library

ah. typical autoconf confusion here.

autoconf looks in only ONE directory by default for *.m4 files. if it
was installed from a package, it probably looks in
/usr/share/aclocal. if it was installed from source, it probably looks
in /usr/local/share/aclocal. there is no way to make it look in both
places without supplying explicit command line arguments, and since
autoconf is frequently run by the entire configure system, this is
hard to do. why autoconf does this is beyond me; it entirely forgets
the long unix tradition of FOO_PATH environment variables.

this causes no end of difficulties when using software that is
generally installed from a tgz or CVS (such as ALSA) on systems where
autoconf was installed from a package. autoconf will complain that it
can't find the foo.m4 file (because its in the "wrong" place). 

--p



-------------------------------------------------------
This SF.NET email is sponsored by: AMD - Your access to the experts
on Hammer Technology! Open Source & Linux Developers, register now
for the AMD Developer Symposium. Code: EX8664
http://www.developwithamd.com/developerlab
