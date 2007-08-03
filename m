From: "Wallace, Brooke" <brookew@qualcomm.com>
Subject: Re: trouble compiling alsa-drivers
Date: Fri, 3 Aug 2007 14:29:47 -0700
Message-ID: <C7A98C6EB85FFF4FAE03BD695D68EC7601239914@NAEX05.na.qualcomm.com>
References: <C7A98C6EB85FFF4FAE03BD695D68EC760123970A@NAEX05.na.qualcomm.com>
	<1186104048.21191.220.camel@razman.gruemaster.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from numenor.qualcomm.com (numenor.qualcomm.com [129.46.51.58])
	by alsa0.perex.cz (Postfix) with ESMTP id 506002437E
	for <Alsa-devel@alsa-project.org>;
	Fri,  3 Aug 2007 23:29:52 +0200 (CEST)
Content-class: urn:content-classes:message
In-Reply-To: <1186104048.21191.220.camel@razman.gruemaster.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Tobin Davis <tdavis@dsl-only.net>
Cc: Alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Package alsa-driver-1.0.14.tar.b2z also fails to compile with the same
error.
 
Is there a particualr version of the Kernel that is recommended to use?
 
I don't think the issue is with including the macro itself, it is
defined in adriver.h and including that file directly generates the same
error. Seems that MARCO depends on another MACRO "RW_LOCK_UNLOCKED" and
somewhere down the line there is a syntax error....
 
make[1]: Entering directory `/usr/src/kernels/2.6.9-34.EL-smp-i686'
  CC [M]
/local/mnt/views/brookew/alsa/workspace/alsa-driver-1.0.14/acore/memallo
c.o
  CC [M]
/local/mnt/views/brookew/alsa/workspace/alsa-driver-1.0.14/acore/sgbuf.o
  CC [M]
/local/mnt/views/brookew/alsa/workspace/alsa-driver-1.0.14/acore/memory_
wrapper.o
  CC [M]
/local/mnt/views/brookew/alsa/workspace/alsa-driver-1.0.14/acore/pcm.o
  CC [M]
/local/mnt/views/brookew/alsa/workspace/alsa-driver-1.0.14/acore/pcm_nat
ive.o
/local/mnt/views/brookew/alsa/workspace/alsa-driver-1.0.14/acore/pcm_nat
ive.c:75: error: syntax error before "snd_pcm_link_rwlock"
... [Many more similar errors] ...
make[4]: ***
[/local/mnt/views/brookew/alsa/workspace/alsa-driver-1.0.14/acore/pcm_na
tive.o] Error 1
make[3]: ***
[/local/mnt/views/brookew/alsa/workspace/alsa-driver-1.0.14/acore] Error
2
make[2]: ***
[_module_/local/mnt/views/brookew/alsa/workspace/alsa-driver-1.0.14]
Error 2
make[1]: *** [modules] Error 2
make[1]: Leaving directory `/usr/src/kernels/2.6.9-34.EL-smp-i686'
make: *** [compile] Error 2
 
I will do some more digging around, but I don't want to go off the
deep-end hacking software I don't understand, at least not yet.
 
-Brooke
 


________________________________

	From: Tobin Davis [mailto:tdavis@dsl-only.net] 
	Sent: Thursday, August 02, 2007 6:21 PM
	To: Wallace, Brooke
	Subject: Re: [alsa-devel] trouble compiling alsa-drivers
	
	
	Alsa 1.0.14rc4 is NOT the latest.  1.0.14 went final a few weeks
after, and there was a patch to fix build issues on Redhat's broken
kernels that went into it.
	
	Tobin
	
	On Thu, 2007-08-02 at 16:53 -0700, Wallace, Brooke wrote: 

		The alsa-drivers INSTALL file tells me:
		 
		   On 2.6 kernels, the build directory has to be given
via
		--with-build=<kernel_build_dir> option additionaly, too.
		 
		What exactly is mean by kernel_build_dir? I should not
have to recompile
		my kernel because I already have the sourcecore module.
		 
		Configure seems to work fine and locates my kernel
source code:
		 
		./configure --with-cards=hda-intel --with-sequencer=yes
		 
		But when I compile, it fails in acore/pcm_native.c line
#75,
		acore/pcm_native.c line #75 uses the macro DEFINE_RWLOCK
which
		apparently has not been defined yet.
		 
		Searching thu the alsa-drivers source, I find that
include/adriver.h
		defines this macro.
		 
		What am I doing wrong? Why doesn't adriver.h get
included when I compile
		acore/pcm_native.c?
		 
		
		I'm using the latest release - alsa-driver-1.0.14rc4
		 
		My Kernel sources are: 2.6.9-34.EL-smp-i686
		 
		Alsa is already working fine on this system using the
HDA Intel driver,
		its a RHEL- 3.4.5-2 system. I just want to re-compile
the latest ALSA
		software and start writing a dummy user space driver
that prints to a
		file or something. I should be able to cmopile all of
the latest ALSA
		software...
		 
		Any help is appreciated.
		 
		-Brooke
		_______________________________________________
		Alsa-devel mailing list
		Alsa-devel@alsa-project.org
	
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

-- Tobin Davis 


Laetrile is the pits.
