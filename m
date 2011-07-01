From: alex dot baldacchino dot alsasub at gmail dot com
	<alex.baldacchino.alsasub@gmail.com>
Subject: Re: additional problem
Date: Fri, 1 Jul 2011 02:48:51 +0200
Message-ID: <BANLkTi=exstgRO7eKU7pBh-VyU2VvhwAQA@mail.gmail.com>
References: <4E0B2F67.3070304@digital-pipe.com>
	<BANLkTimKzKg0Jp_=VNjJPMu7gTH_v1kBcw@mail.gmail.com>
	<4E0CC849.5020909@digital-pipe.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179]) by alsa0.perex.cz (Postfix) with ESMTP id 2ABBD24739
	for <alsa-devel@alsa-project.org>;
	Fri,  1 Jul 2011 02:48:53 +0200 (CEST)
Received: by wyh21 with SMTP id 21so2107522wyh.38
	for <alsa-devel@alsa-project.org>; Thu, 30 Jun 2011 17:48:52 -0700 (PDT)
In-Reply-To: <4E0CC849.5020909@digital-pipe.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: David Henderson <dhenderson@digital-pipe.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

2011/6/30 David Henderson <dhenderson@digital-pipe.com>:
> On 06/30/2011 01:34 PM, alex dot baldacchino dot alsasub at gmail dot com
> wrote:
>>
>> 2011/6/29 David Henderson<dhenderson@digital-pipe.com>:
>>>
>>> Hi gang! =A0I've successfully been able to compile the alsa-utils packa=
ge
>>> with the "--with-alsa-inc-prefix=3D/opt/staging/alsa/var/share/include
>>> --with-alsa-prefix=3D/opt/staging/alsa/lib", but the problem I'm having
>>> now is that the compiled binaries are looking for those directories
>>> during run-time and not just compile-time. =A0Does anyone have any
>>> thoughts on using those directories for package creation, but that the
>>> software doesn't use the '/opt/staging/alsa' prefix during run-time?
>>>
>>> Thanks,
>>> Dave
>>> _______________________________________________
>>> Alsa-devel mailing list
>>> Alsa-devel@alsa-project.org
>>> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>>>
>>
>> Do you have a full build environment under /opt/staging? If so, you
>> could try to chroot there and configure your software 'normally'
>> instead of passing those parameters... or passing those paths starting
>> from '/' instead of '/opt/staging/' (provided that the final
>> installation will match them, e.g. binaries will look into
>> '/var/share/include' and /lib)... it might work...
>>
>> If you missed something from the 'real' environment, you could try
>> (before chroot'ing) to create (hard) links to those paths within a
>> 'local' dir (e.g. create dir /opt/staging/extern/ and therein link to
>> /bin, /sbin, /usr/bin etc.) then arrange to have these 'local' paths
>> listed (after chroot'ing) at the end of your PATH env variable. You
>> would need at least a working /opt/staging/bin/sh and perhaps some
>> symlinks, such as a 'lib' pointing to "/alsa/lib" and a 'var' pointing
>> to "/alsa/var", but if such names exist as directories you could need
>> links to each file/subdirectory, perhaps a script could help you
>> creating them on the fly (after chroot'ing) once you knew what you
>> need (e.g. if you need stuff in alsa/var/share/include, arrange your
>> script to work, for instance, with 'alsa' as first parameter and
>> var/share/include as second parameter, then mkdir -p var/share/include
>> and symlink to alsa/var/share/include/<whatever> =A0- if there are
>> subdirs therein, mkdir -p instead of symlinking and move in depth,
>> just in case you needed something from a different
>> <name>/var/share/include/<inner_name>/*). You might also need
>> (sym)links to stuff in extern/<somedir>/ - such a 'dynamic' build
>> environment may become hard to create and handle, more than a full
>> build env for creating a distro from scratch, unless that's what
>> you're doing, just using some code and configurations from an existing
>> distro, in which case maybe you have a full build env yet, so just
>> chroot, compile and install everything both with DESTDIR (to create a
>> package later) and 'normally' (to have include and lib files easy to
>> reuse to match dependencies for building other software).
>>
>> Or... put your hands into alsa-utils'
>> autogen/automake/configure/script files (if you want an automated
>> process to reuse, or just modify the generated Makefile, if enough)
>> and customize them to achieve what you aim, e.g. setting different -L
>> and -rpath wherever needed, or set and export a global LDFLAGS, taking
>> care to include every library needed and correct paths (use the
>> generated Makefile as a hint), again with different -L and -rpath...
>> or perhaps all you need could be setting the final dirs to look into
>> at runtime in LD_RUN_PATH, in which case you could configure your
>> build as you've done successfully until now, then export (for
>> instance) LD_RUN_PATH=3D/lib (use the correct path, if you need to
>> include more than one path for shared objects, separate them with a
>> colon, e.g. LD_RUN_PATH=3D/lib:/var/lib - if I didn't misunderstand, you
>> have some stuff in /var that usually is in /usr/*), then make etc. The
>> latter choice might be the easier, so give it a try, but might not
>> work if your generated Makefile contains -rpath in LDFLAGS...
>>
>> Regards.
>>
>> Alex
>
> Currently I am building a distro from scratch with all the software
> "installed" to /opt/staging/os - so I guess I do have a build directory. =
=A0I
> should be able to chroot into that directory and have everything work
> correctly (as far as dependencies and such) since I boot to the very same
> dir hierarchy (obviously minus the /opt/staging/os prefix). =A0I haven't =
had
> to do it with any of the software I've compiled so far, but have a few
> questions regarding this practice. =A0If I chroot into that directory bef=
ore
> compiling the software, how will I make all the necessary changes (e.g.
> PATHs, env values, etc) that are required for the build directory as there
> are quite a bit of large differences between the main OS and the one I'm
> building? =A0Also, when chroot'ing, it shouldn't make any changes to the
> current main OS correct? =A0For example, if I open a terminal window and
> chroot there, it won't affect the rest of the OS correct? =A0Forgive my
> ignorance, but I've never had to use chroot and I couldn't find any relat=
ed
> info in the man page.
>
> Thanks,
> Dave
>
>


I'm not an expert in building distros, but there are several good
guides on the net, both for 'normal' and embedded systems. For
instance, you could give a look at http://www.linuxfromscratch.org/
and take hints on the path you need to follow to create your distro.

About chroot, think of it as creating a sort of 'sandbox' where you do
anything without affecting the 'external world' - you're inside
/opt/staging/ but you're calling it / no more (or better, there is
more: you can access about only stuff within /opt/staging/ tree - but
read further), so, if you load or modify a file called, say,
/etc/.somethingrc, you're working with /opt/staging/etc/.somethingrc,
not the 'external OS' /etc/.somethingrc, unless the one in
/opt/staging is (e.g.) a hardlink to it. AFAICT, it's been for ages
the usual way (used together with pivot_root) to pass from early
user-space to the 'main' system during boot-up, specially when initial
ramdisks where used to boot, now, with initramfs/cpio archives, it's
common to find switch_root/new_root being used instead, specially for
those small distros (but not only) build around busybox (switch_root -
new_root is the counterpart offered by klibc) -- do not use such
commands in place of chroot for your purpose, because they can be
disruptive!

Changing environment variables is generally harmless (from this point
of view), changes apply from the 'point' they're made and exported.
For instance, if you modify the content of PATH in an xterm, you'll
find the 'old' content in another one. That's the same for a chroot
env, but with a difference: you shouldn't be allowed to see the 'real
OS' envs (specially files, such as /etc/groups, unless you use mount
--bind, but I think hardlinks should work too), so you should need to
create them, and anyway, what you modify within the chroot environment
applies to the chroot environment (unless arranging to touch something
out of it, but you need do it purposely for it to happen - but read
further). But beware two things: first, you're still using the same
kernel and (loaded) modules, so, if your new distro embeds a more
recent kernel version and any of the software you're building relies
upon new functionalities provided by the newer kernel, you may found
troubles testing such software, though you should be still able to
compile it; second, what chroot really does is changing the way an
absolute path is resolved: if you cd to /bin after chroot'ing to
/opt/staging, you're entering /opt/staging/bin, but if you use
relative paths you may happen to touch something outside the chroot
env, so you'd need to cd /opt/staging before invoking chroot. You
might set envs with a 'local' (and eventually minimal) init script, so
that, for instance, you would execute:

cd /opt/staging
chroot /opt/staging # this typically invokes /bin/sh -i, that is
/opt/staging/bin/sh -i
/init_env.sh # if you have proper files (passwd, groups, .bashrc and
so on under /opt/staging/etc you might not need this, or you might use
it for additional customization)

(remember to avoid using relative paths as ../somename, or check pwd
is not '/' before doing so if in doubt on your position, because you
might happen to escape from the chroot jail)

You can find more infos at
http://xpt.sourceforge.net/techdocs/nix/chroot/ -
http://en.wikipedia.org/wiki/Chroot -
http://www.bpfh.net/simes/computing/chroot-break.html

Regards.

Alex
