From: Erik Mouw <J.A.K.Mouw@its.tudelft.nl>
Subject: Re: sb 16 pro + alsa 0.5.12a + k 2.4.17
Date: Sun, 10 Feb 2002 23:35:04 +0100
Message-ID: <20020210223504.GD22208@arthur.ubicom.tudelft.nl>
References: <3C66C614.3000709@free.fr> <20020210204243.GA22208@arthur.ubicom.tudelft.nl> <3C66E9D1.1020302@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Received: from duteinh.et.tudelft.nl (root@duteinh.et.tudelft.nl [130.161.42.1])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id XAA19951
	for <alsa-devel@alsa-project.org>; Sun, 10 Feb 2002 23:35:16 +0100
Content-Disposition: inline
In-Reply-To: <3C66E9D1.1020302@free.fr>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Ludovic Drolez <ldrolez@free.fr>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Sun, Feb 10, 2002 at 10:44:49PM +0100, Ludovic Drolez wrote:
> Erik Mouw wrote:
> >Very clear error message: please supply proper parameters for the
> >snd-card-sb16 module. "modinfo snd-card-sb16" will tell you what
> >parameters the module accepts.
> 
> I have supplied all parameters you can imagine. And my launch script is the 
> same for k 2.2.19, and for 2.4.17...

And did you run "update-modules && depmod -a"?

> >I don't think so. I think you either forgot to specify the correct
> >module parameters, or you somehow loaded the kernel Soundblaster
> >driver.
> >
> 
> lsmod |grep sb
> > nothing

It could also be that it is compiled into the kernel itself. See
/proc/ioports to see which driver claims the ports.

> >Did you read the file Documentation/Changes in the kernel source tree?
> >The linux-2.4 kernels need quite some new userland programs to work
> >properly.
> 
> Yes, I have upgraded dozen of packages (a Debian 2.2 with bunk's packages).

OK, Adrian Bunk's packages work fine.

> What I find strange is: the kernel is scanning for pnp card although I told 
> alsa to ignore pnp card....

You told the kernel that you want ISA PnP support, so the kernel will
scan for cards. Recompile your kernel and disable PnP support.


Erik
[who prefers to be CC'ed on mailing lists messages]

-- 
J.A.K. (Erik) Mouw, Information and Communication Theory Group, Faculty
of Information Technology and Systems, Delft University of Technology,
PO BOX 5031, 2600 GA Delft, The Netherlands  Phone: +31-15-2783635
Fax: +31-15-2781843  Email: J.A.K.Mouw@its.tudelft.nl
WWW: http://www-ict.its.tudelft.nl/~erik/

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel
