From: "Wallace, Brooke" <brookew@qualcomm.com>
Subject: trouble compiling alsa-drivers
Date: Thu, 2 Aug 2007 16:53:23 -0700
Message-ID: <C7A98C6EB85FFF4FAE03BD695D68EC760123970A@NAEX05.na.qualcomm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ithilien.qualcomm.com (ithilien.qualcomm.com [129.46.51.59])
	by alsa0.perex.cz (Postfix) with ESMTP id 9A527103863
	for <alsa-devel@alsa-project.org>;
	Fri,  3 Aug 2007 01:53:26 +0200 (CEST)
Received: from hamtaro.qualcomm.com (hamtaro.qualcomm.com [129.46.61.157])
	by ithilien.qualcomm.com (8.13.6/8.12.5/1.0) with ESMTP id
	l72NrOjG010379
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL)
	for <alsa-devel@alsa-project.org>; Thu, 2 Aug 2007 16:53:24 -0700
Received: from SANEXCAS03.na.qualcomm.com (sanexcas03.qualcomm.com
	[172.30.32.65])
	by hamtaro.qualcomm.com (8.13.6/8.13.6/1.0) with ESMTP id
	l72NrNPx022080
	for <alsa-devel@alsa-project.org>; Thu, 2 Aug 2007 16:53:24 -0700 (PDT)
Content-class: urn:content-classes:message
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The alsa-drivers INSTALL file tells me:
 
   On 2.6 kernels, the build directory has to be given via
--with-build=<kernel_build_dir> option additionaly, too.
 
What exactly is mean by kernel_build_dir? I should not have to recompile
my kernel because I already have the sourcecore module.
 
Configure seems to work fine and locates my kernel source code:
 
./configure --with-cards=hda-intel --with-sequencer=yes
 
But when I compile, it fails in acore/pcm_native.c line #75,
acore/pcm_native.c line #75 uses the macro DEFINE_RWLOCK which
apparently has not been defined yet.
 
Searching thu the alsa-drivers source, I find that include/adriver.h
defines this macro.
 
What am I doing wrong? Why doesn't adriver.h get included when I compile
acore/pcm_native.c?
 
 
I'm using the latest release - alsa-driver-1.0.14rc4
 
My Kernel sources are: 2.6.9-34.EL-smp-i686
 
Alsa is already working fine on this system using the HDA Intel driver,
its a RHEL- 3.4.5-2 system. I just want to re-compile the latest ALSA
software and start writing a dummy user space driver that prints to a
file or something. I should be able to cmopile all of the latest ALSA
software...
 
Any help is appreciated.
 
-Brooke
