From: Martin Langer <martin-langer@gmx.de>
Subject: Re: sscape_ioctl.h not found!
Date: Mon, 23 Sep 2002 21:03:50 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20020923190350.GE1405@tuba.home>
References: <3D8F49F2.7030607@cs.auc.dk>
Reply-To: martin-langer@gmx.de
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <3D8F49F2.7030607@cs.auc.dk>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=alsa-devel>
To: Emmanuel Fleury <fleury@cs.auc.dk>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Mon, Sep 23, 2002 at 07:05:54PM +0200, Emmanuel Fleury wrote:
> Hi,
> 
> I get the last CVS snapshot (from today) of alsa-driver
> and I try to compile it on my new machine with a 2.4.19
> kernel.
> 
> At the beginning, I had hard to figure out that the
> directory alsa-kernel was missing.
> 
> Ok, I get it from the rc3 release.
> 
> Then, I tried the following command line:
> ./cvscompile --with-cards=cmipci --with-sequencer=yes --with-oss=yes 
> -with-isapnp=no --with-debug=none
> 
> But then, during the dependencies building, I get:
> 
> gcc -M -D__KERNEL__ -DMODULE=1 
> -I/home/fleury/install/src/alsa-driver/include 
> -I/lib/modules/2.4.19custom/build/include -O2 
> -mpreferred-stack-boundary=2 -march=i686 -DLINUX -Wall 
> -Wstrict-prototypes -fomit-frame-pointer -pipe -DALSA_BUILD  als100.c 
> azt2320.c cmi8330.c dt019x.c es18xx.c opl3sa2.c sgalaxy.c sscape.c > .depend
> sscape.c:41: sound/sscape_ioctl.h: No such file or directory
> make[1]: *** [fastdep] Error 1
> make[1]: Leaving directory `/home/fleury/install/src/alsa-driver/isa'
> make: *** [dep] Error 1
> 
> Actually, I didn't find any sound/sscape_ioctl.h anywhere... :-/
> 

The file sscape_ioctl.h is in alsa-kernel/include/ and I can get it via CVS
update. Is it fixed in the meantime? Your mix of cvs and rc3 is a bad
choice. Try to use a clean cvs or a clean rc3 tree instead. 


martin


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
