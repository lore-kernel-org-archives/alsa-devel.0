From: DSP Tech <dsptech@hotmail.com>
Subject: Error compiling ALSA driver
Date: Fri, 11 Jul 2008 08:42:33 +0530
Message-ID: <BLU139-W43AD56F284262FF5AA1566B2900@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from blu0-omc3-s35.blu0.hotmail.com (blu0-omc3-s35.blu0.hotmail.com
	[65.55.116.110]) by alsa0.perex.cz (Postfix) with ESMTP id C42B32480A
	for <alsa-devel@alsa-project.org>;
	Fri, 11 Jul 2008 05:12:36 +0200 (CEST)
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


Hi All,
 
I am trying to compile ALSA driver for arm platform.  But it keeps complaining that "__LINUX_ARM_ARCH__" is undeclared. 
 
But the linux kernel is properly built. Do I have to include any specific header file for this?
 
The error message is as follows:
==============
/linux-2.6.23//include/linux/calc64.h: In function 'do_div_llr':
/linux-2.6.23//include/linux/calc64.h:25: error: '__LINUX_ARM_ARCH__' undeclared (first use in this function)/linux-2.6.23//include/linux/calc64.h:25: error: (Each undeclared identifier is reported only once==============
 
The environmental variable CROSS_COMPILE is set to /extra/arm-2007q1/bin/arm-none-linux-gnueabi-
 
 
The configuration options provided is:
 
./configure  --target=arm-linux --host=arm-linux --build=i686-pc-linux-gnu --prefix=/modules/sound/alsa-driver-1.0.16/ --exec-prefix=/modules/sound/alsa-driver-1.0.16/ --with-kernel=/linux-2.6.23/ --with-build=/linux-2.6.23/ --with-oss=yes
 
Is ther any mistake in the way I am building?
 
Thanks
_________________________________________________________________
Searching for the best deals on travel? Visit MSN Travel.
http://msn.coxandkings.co.in/cnk/cnk.do
