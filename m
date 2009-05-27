From: Sentinel <sentinel@optonline.net>
Subject: spdif/iec958 outputs at VT1708S not recognized
Date: Tue, 26 May 2009 22:57:31 -0400
Message-ID: <000f01c9de76$e100e810$a302b830$@net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mta5.srv.hcvlny.cv.net (mta5.srv.hcvlny.cv.net [167.206.4.200])
	by alsa0.perex.cz (Postfix) with ESMTP id 34EE92454D
	for <alsa-devel@alsa-project.org>;
	Wed, 27 May 2009 04:57:32 +0200 (CEST)
Received: from HPGame2 (ool-4571dd92.dyn.optonline.net [69.113.221.146])
	by mta5.srv.hcvlny.cv.net
	(Sun Java System Messaging Server 6.2-8.04 (built Feb 28 2007))
	with ESMTP id <0KKA00L1Q87R43D0@mta5.srv.hcvlny.cv.net> for
	alsa-devel@alsa-project.org; Tue, 26 May 2009 22:57:31 -0400 (EDT)
Content-language: en-us
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

Okay I figured out my own problem. 

 

This is specific to those who run 64bit OS.

 

for anyone who is getting register_sound_special_device error when
attempting to compile ALSA, on a 64 bit OS make sure your running your
configure properly.  Most likely your distro has ALSA libraries located in
the /usr/lib64 path not in /usr/lib and most likely the ld.so.conf is set to
look in /usr/lib64 before it searches /usr/lib which is the default for  the
configure script.  As a warning I'd not try to change that order especially
if you have built any 32bit compatibility drivers into /usr/lib

 

./configure -prefix=/usr/lib64

 

Although it wouldn't be a bad idea for the configure to detect that if
possible.
