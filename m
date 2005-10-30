From: Magnar Haaland <magnarh@lyse.net>
Subject: I am not able to compile alsa-driver-0.9.6 (on 1985Linux.zip )
Date: Sun, 30 Oct 2005 17:42:50 +0100
Message-ID: <200510301742.50518.magnarh@lyse.net>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
	boundary="Boundary-00=_KgPZDoAw0ftvWZA"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from asav1.lyse.net (asav1.lyse.net [213.167.96.68])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 760B9189
	for <alsa-devel@alsa-project.org>; Sun, 30 Oct 2005 15:42:20 +0100 (MET)
Received: from asav1.lyse.net (asav1.lyse.net [127.0.0.1])
	by localhost.lyse.net (Postfix) with ESMTP id BB8CE90836
	for <alsa-devel@alsa-project.org>; Sun, 30 Oct 2005 15:42:17 +0100 (CET)
Received: from mail1.lyse.net (unknown [192.168.42.2])by asav1.lyse.net (Pos
	tfix) with ESMTP id AA69790825for <alsa-devel@alsa-project.org>; Sun, 30 Oc
	t 2005 15:42:17 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@alsa-project.org
Cc: magnarh@lyse.net
List-Id: alsa-devel@alsa-project.org

--Boundary-00=_KgPZDoAw0ftvWZA
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


Hi !

I tried to compile alsa-driver-0.9.6 , but was not able to do so .

I tried ./configure   ( look at attached file )  but somthing went wrong

checking for GCC version... Kernel compiler: GCC 3.3.5 (Debian 1:3.3.5-13) 
Used compiler: gcc (GCC) 3.3.5 (Debian 1:3.3.5-13)
Fatal error: Compiler type does not match
Decoded kernel compiler: type= version=3.3.5
Decoded used compiler: type=gcc version=3.3.5



I am using debian 3.1 and kernel 2.6.14  and an intel 686 cpu .

Could you please give me some advice about the compilation ?

Thanks

Magnar Haaland




--Boundary-00=_KgPZDoAw0ftvWZA
Content-Type: text/plain;
  charset="us-ascii";
  name="alsa.out"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="alsa.out"

checking for gcc... gcc
checking for C compiler default output... a.out
checking whether the C compiler works... yes
checking whether we are cross compiling... no
checking for executable suffix... 
checking for object suffix... o
checking whether we are using the GNU C compiler... yes
checking whether gcc accepts -g... yes
checking for ranlib... ranlib
checking for a BSD compatible install... /usr/bin/install -c
checking how to run the C preprocessor... gcc -E
checking for ANSI C header files... yes
checking for gcc option to accept ANSI C... none needed
checking for an ANSI C-conforming const... yes
checking for inline... inline
checking whether time.h and sys/time.h may both be included... yes
checking whether gcc needs -traditional... no
checking for current directory... /home/magnarh/Linux/alsa-driver-0.9.6
checking cross compile... 
checking for directory with kernel source... /lib/modules/2.6.14/build
checking for kernel version... 2.6.14
checking for GCC version... Kernel compiler: GCC 3.3.5 (Debian 1:3.3.5-13) Used compiler: gcc (GCC) 3.3.5 (Debian 1:3.3.5-13)
Fatal error: Compiler type does not match
Decoded kernel compiler: type= version=3.3.5
Decoded used compiler: type=gcc version=3.3.5
Please, send ./configure output to <alsa-devel@alsa-project.org>

--Boundary-00=_KgPZDoAw0ftvWZA--


-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.
Get Certified Today * Register for a JBoss Training Course
Free Certification Exam for All Training Attendees Through End of 2005
Visit http://www.jboss.com/services/certification for more information
