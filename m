From: Thierry Vignaud <tvignaud@mandrakesoft.com>
Subject: Re: errors in symlinks in alsa-oss rc1 with mandrake
 9.0
Date: Mon, 16 Dec 2002 10:58:13 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <m2of7ms2tm.fsf@vador.mandrakesoft.com>
References: <3DFCBF9A.2090108@iriXx.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <3DFCBF9A.2090108@iriXx.org> (iriXx's message of "Sun, 15 Dec
 2002 17:44:58 +0000")
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: m@iriXx.org
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

iriXx <m@iriXx.org> writes:

> just a note to say i had to modify the symlinks to 'missing',
> 'mkinstalldirs' and 'install-sh' to get alsa-oss-0.9.0rc1 to install
> under mandrake 9.0.

alsa-oss just build fine, look at myt libalsa-oss0 package in mandrake
contribs.

> it seems that from 9.0 mandrake puts automake in
> /usr/share/automake-1.4 rather than /usr/share/automake.

mdk9.0 come with both automake-1.4 and automake-1.6 since some
packages need the latter and some other the first one.

there's nothing wrong in having versionnated directories such as
/usr/share/automake.

there's nothing enforcing having /usr/share/automake.

only automake should access such files.

> i dont know if anyone wants to add a detection for this to the
> config script?

you should not have to rely on automake macros being in
/usr/share/automake and i failled to see where such  assumption is
made in alsa-oss build system in cvs.

so there's no point in such script.

if some tarball of some with a pre build configure and the like, and
if some links're broken, aclocal, libtoolize, automake and autoconf
are your friends to fix them.

anyway, generating them from cvs does works on any system having
automake & autoconf.



-------------------------------------------------------
This sf.net email is sponsored by:
With Great Power, Comes Great Responsibility 
Learn to use your power at OSDN's High Performance Computing Channel
http://hpc.devchannel.org/
