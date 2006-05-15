From: Matthias Koenig <list@phasorlab.de>
Subject: Re: ICC driver compiler fails - alsa-driver-1.0.11
Date: Mon, 15 May 2006 12:59:39 +0200
Message-ID: <871wuvy2n8.fsf@zebra.localdomain>
References: <ac06b020605140707h7a8f870dm80da9c2ccc8ecfe9@mail.gmail.com>
	<87slncbkfe.fsf@zebra.localdomain>
	<ac06b020605150125g589a5e0code9fdfb01c94a656@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Thomas Sullivan <metafunk@gmail.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

"Thomas Sullivan" <metafunk@gmail.com> writes:
>> Could you please post the contents of
>> /lib/modules/2.6.16.16-genuine> intel/source/include/linux/compile.h ?
>> Especially the makro LINUX_COMPILER
>
> /lib/modules/2.6.16.16-genuineintel/source/include/linux/compile.h:
>
> #define LINUX_COMPILER "gcc version 3.4.6"
>
> Well, evidently ICC must be acting in some sort of compatibility mode when
> compiling the kernel. I wouldn't have thought it would be the default. Ah
> well, thanks for looking anyway.

Hmm, are you really sure that you did compile the kernel with icc?
What was the exact commandline you compiled the kernel?
I'm just asking, because recently I noticed, that doing a
CC=my-gcc make
for the kernel tree does not work as expected, because the 
Variable definitions in the Makefile have precedence over the 
environment Variables. If you want to override Makefile variables
you should use
make CC=my-gcc
or explicitly instruct make to give environment variables precedence
with the -e option.

> PS Oh yeah, how come it's safer to pass CC & CXX as parameters than
> otherwise? I would have thought it was pretty much equivalent

I can't remember exactly where I've read this, but there might be some
problems with passing variables by environment to configure.
In the autoconf manual is just a short note:

"Variables not defined in a site shell script can be set in the
environment passed to `configure'.  However, some packages may run
configure again during the build, and the customized values of these
variables may be lost.  In order to avoid this problem, you should set
them in the `configure' command line, using `VAR=value'.  For example:

     ./configure CC=/usr/local2/bin/gcc

will cause the specified gcc to be used as the C compiler (unless it is
overridden in the site shell script)."

Matthias

PS: I added alsa-devel again to CC (and posting from my subscription address)


-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
