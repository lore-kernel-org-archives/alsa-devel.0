From: Willy Tarreau <w@1wt.eu>
Subject: Re: [PATCH] fix emu10k1 build in 1.0.13
Date: Tue, 31 Oct 2006 23:34:21 +0100
Message-ID: <20061031223421.GA3684@1wt.eu>
References: <20061028213441.GA797@1wt.eu> <s5hy7qwtv9t.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from 1wt.eu (1wt.eu [62.212.114.60])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id ECBF12CF
	for <alsa-devel@alsa-project.org>; Tue, 31 Oct 2006 22:33:48 +0100 (MET)
Content-Disposition: inline
In-Reply-To: <s5hy7qwtv9t.wl%tiwai@suse.de>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, "Gabor Z. Papp" <gzp@papp.hu>
List-Id: alsa-devel@alsa-project.org

Hi Takashi !

On Tue, Oct 31, 2006 at 03:27:58PM +0100, Takashi Iwai wrote:
> At Sat, 28 Oct 2006 23:34:41 +0200,
> Willy Tarreau wrote:
> > 
> > Hi guys,
> > 
> > Gabor Z.Papp reported to me that alsa-driver-1.0.13 did not build under
> > 2.4.34-pre4. I found there was a missing export-objs in the emu10k1
> > Makefile. This trivial patch fixes it.
> 
> Strange, this is already set in alsa-driver/pci/emu10k1/Makefile that
> includes alsa-kernel/pci/emu10k1/Makefile.  Your patch would simply
> override it...

Interesting... Here's what I get :

$ ./configure --with-cards=emu10k1 --with-oss=yes --with-sequencer=yes --with-kernel=/lib/modules/2.4.33-wt2/build
...
$ make
...
make[2]: Entering directory `/data/src/audio/alsa/alsa-driver-1.0.13/pci/emu10k1'
make[2]: Circular io.c <- io.c dependency dropped.
gcc -D__KERNEL__ -DMODULE=1 -I/data/src/audio/alsa/alsa-driver-1.0.13/include  -I/lib/modules/2.4.33-wt2/build/include -O2 -mpreferred-stack-boundary=2 -march=i686 -malign-functions=4 -D__SMP__ -DCONFIG_SMP -DLINUX -Wall -Wstrict-prototypes -fomit-frame-pointer -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -pipe -DALSA_BUILD -nostdinc -iwithprefix include  -DKBUILD_BASENAME=io   -c -o io.o io.c
In file included from io.c:2:
../../alsa-kernel/pci/emu10k1/io.c:65: parse error before `this_object_must_be_defined_as_export_objs_in_the_Makefile'
../../alsa-kernel/pci/emu10k1/io.c:65: warning: type defaults to `int' in declaration of `this_object_must_be_defined_as_export_objs_in_the_Makefile'
../../alsa-kernel/pci/emu10k1/io.c:65: warning: data definition has no type or storage class
../../alsa-kernel/pci/emu10k1/io.c:97: parse error before `this_object_must_be_defined_as_export_objs_in_the_Makefile'
../../alsa-kernel/pci/emu10k1/io.c:97: warning: type defaults to `int' in declaration of `this_object_must_be_defined_as_export_objs_in_the_Makefile'
../../alsa-kernel/pci/emu10k1/io.c:97: warning: data definition has no type or storage class
make[2]: *** [io.o] Error 1
make[2]: Leaving directory `/data/src/audio/alsa/alsa-driver-1.0.13/pci/emu10k1'
make[1]: *** [_modsubdir_emu10k1] Error 2
make[1]: Leaving directory `/data/src/audio/alsa/alsa-driver-1.0.13/pci'
make: *** [compile] Error 1


Ah OK just found it, it was just a typo :

--- ./pci/emu10k1/Makefile.orig	Tue Oct 31 23:30:10 2006
+++ ./pci/emu10k1/Makefile	Tue Oct 31 23:30:15 2006
@@ -5,7 +5,7 @@
 include $(SND_TOPDIR)/toplevel.config
 include $(SND_TOPDIR)/Makefile.conf
 
-export-objs  := memory.o voice.o io.c
+export-objs  := memory.o voice.o io.o
 
 include $(SND_TOPDIR)/alsa-kernel/pci/emu10k1/Makefile
 

I've verified that it was the only one in this case. Please
apply this patch instead.

Regards,
Willy


-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
