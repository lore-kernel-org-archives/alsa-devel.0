From: Thierry Vignaud <tvignaud@mandrakesoft.com>
Subject: Re: Forward: Re: questions for alsa-devel
Date: Wed, 02 Oct 2002 19:19:26 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <m2zntwn4gx.fsf@vador.mandrakesoft.com>
References: <m27kh1djdd.fsf@vador.mandrakesoft.com>
	<20021002145420.6F590146FB@Cantor.suse.de> <s5hd6qskhmn.wl@alsa2.suse.de>
	<s5hbs6ckgm0.wl@alsa2.suse.de>
	<20021002174359.1d2395d3.matthias@rpmforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20021002174359.1d2395d3.matthias@rpmforge.net> (Matthias
 Saou's message of "Wed, 2 Oct 2002 17:43:59 +0200")
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=alsa-devel>
To: Matthias Saou <matthias@rpmforge.net>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Matthias Saou <matthias@rpmforge.net> writes:

> I've managed to work something out for Red Hat Linux that should be
> easily portable to Mandrake I guess (then again, they already have
> ALSA 0.5.x built in, is that what I understood from the last few
> mails??).

yep, we shipped alsa-0.5.x for quite some times, at least since
december 2000 (and i believe a few month before), that is since mdk8.0
i think.

between mdk8.2 (released in very early 2002) and mdk9.0 (released a
few days ago), we switched from alsa 0.5.x to alsa-0.9.x

> I have a single "alsa-driver" source package which builds a binary
> "alsa-driver" one containing the include files and the device
> entries (in a tricky way by adding a file to /etc/makedev.d/ in
> order to package the device entries even while building as
> non-root), and another "alsa-kernel" one which matches the currently
> running kernel's package.

since it must be rebuild for each kernel, we integrated in our kernel
package (first as a separate tarball with configure/make/..., now we
untar it under sound in kernel linux sources and apply a few patches
to config.in so that there's one make to run)



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
