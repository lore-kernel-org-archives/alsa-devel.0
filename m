From: Matthias Saou <matthias@rpmforge.net>
Subject: Forward: Re: questions for alsa-devel
Date: Wed, 2 Oct 2002 17:43:59 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20021002174359.1d2395d3.matthias@rpmforge.net>
References: <m27kh1djdd.fsf@vador.mandrakesoft.com>
	<20021002145420.6F590146FB@Cantor.suse.de>
	<s5hd6qskhmn.wl@alsa2.suse.de>
	<s5hbs6ckgm0.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hbs6ckgm0.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Once upon a time, Takashi wrote :

> the problem is that many different kernel binaries are built using the
> same kernel tree, i.e. there are many different kernel configs while
> there is only one kernel-source package.
> thus you have to adjust the kernel config by yourself anyway.
> 
> in case building the kernel from scratach, you'll surely configure the
> tree once in prior to build of alsa modules.  this ensures you having
> the correct kernel tree.
> but in the case of distro's kernel package, the default configuration
> might not match with the running kernel unless you set up properly.
> and, much worse is that this small "tune-up" is dependent on each
> distro (for example, the location of config files, etc.)
> 
> it might be possible to hack a spec file to change such things
> automatically.  but, as you know, hacking a spec file is awesome and
> makes the situation more more complicated ;)

I've managed to work something out for Red Hat Linux that should be easily
portable to Mandrake I guess (then again, they already have ALSA 0.5.x
built in, is that what I understood from the last few mails??). I have a
single "alsa-driver" source package which builds a binary "alsa-driver" one
containing the include files and the device entries (in a tricky way by
adding a file to /etc/makedev.d/ in order to package the device entries
even while building as non-root), and another "alsa-kernel" one which
matches the currently running kernel's package.

For Red Hat Linux 8.0, I've got these :

alsa-driver-0.9.0rc3-fr11.i586.rpm
alsa-driver-0.9.0rc3-fr11.src.rpm
alsa-kernel-0.9.0rc3-fr11_2.4.18_14.athlon.rpm
alsa-kernel-0.9.0rc3-fr11_2.4.18_14.i586.rpm
alsa-kernel-0.9.0rc3-fr11_2.4.18_14.i686.rpm
alsa-kernel-smp-0.9.0rc3-fr11_2.4.18_14.athlon.rpm
alsa-kernel-smp-0.9.0rc3-fr11_2.4.18_14.i686.rpm

And even apt for rpm is able to install the correct package when used.
Ain't it easy? All these are easily built by having the "kernel-source"
package installed (the same for all archs), and while running the kernel to
build for so that SMP and CPU arch are detected correctly :-)

You can take a look at all my spec files from here :
http://freshrpms.net/builds/index.html?sort=name

And all binary / source packages from here :
http://psyche.freshrpms.net/

This is quite Red Hat Linux specific, but as Mandrake's way of naming and
managing rpms is close, things may work with minor tweaking.

Of course, this doesn't apply for "home made kernels" for which you should
always keep the source tree and rebuild the ALSA modules against it "by
hand" too.

Matthias

-- 
Clean custom Red Hat Linux rpm packages : http://freshrpms.net/
Red Hat Linux release 7.3 (Valhalla) running Linux kernel 2.4.18-10acpi
Load : 0.15 0.23 0.37


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
