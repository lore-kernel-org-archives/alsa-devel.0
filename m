From: Alejandro Gonzalez <x0092071@ti.com>
Subject: UCM list 'modifiers' Seg-Fault when list is empty
Date: Wed, 16 Mar 2011 13:40:22 -0600
Message-ID: <1300304422.1650.191.camel@dexx0092071-ubuntu>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-IP2WlWQNWkCqX3Xnbcfr"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from arroyo.ext.ti.com (arroyo.ext.ti.com [192.94.94.40])
	by alsa0.perex.cz (Postfix) with ESMTP id E8B0024582
	for <alsa-devel@alsa-project.org>; Wed, 16 Mar 2011 20:42:30 +0100 (CET)
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
Cc: Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org


--=-IP2WlWQNWkCqX3Xnbcfr
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

Hi, 

I've been testing the Alsa UCM and find that when listing 'modifiers'
there is a segmentation fault if the list is empty.

$ alsaucm -c Panda set _verb HiFi list _modifiers
  Im setting defaults
    list is empty
 Segmentation fault (core dumped)

Using 'gdb' I see that the issue is trying to free a not NULL pointer.
Program received signal SIGSEGV, Segmentation fault.
0x402a096c in free () from /lib/libc.so.6
(gdb) bt
#0  0x402a096c in free () from /lib/libc.so.6
#1  0x40221224 in snd_use_case_free_list () from /usr/lib/libasound.so.2
#2  0x00008d8a in do_one (context=0x13008) at usecase.c:256
#3  do_commands (context=0x13008) at usecase.c:329
#4  0x000091aa in main (argc=<value optimized out>, argv=0xbe9986c4) at
usecase.c:440
(gdb) quit

But this can be easily resolved with the correct initialization of the
'**list' pointer on the 'do_one' function in 'alsaucm/usecase.c'. 

You can find a patch attached to the mail.

Regards, 

Alejandro




--=-IP2WlWQNWkCqX3Xnbcfr
Content-Disposition: attachment; filename="Alsa-UCM-list-modifiers-Segmentation-Fault.patch"
Content-Type: text/x-patch; name="Alsa-UCM-list-modifiers-Segmentation-Fault.patch"; charset="UTF-8"
Content-Transfer-Encoding: 7bit


--- /home/ubuntu/usecase.c	2011-03-16 13:03:07.000000000 -0600
+++ ./alsaucm/usecase.c	2011-03-16 12:45:33.000000000 -0600
@@ -170,7 +170,7 @@
 
 static int do_one(struct context *context, struct cmd *cmd, char **argv)
 {
-	const char **list, *str;
+	const char **list=NULL, *str;
 	long lval;
 	int err, i;




--=-IP2WlWQNWkCqX3Xnbcfr
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--=-IP2WlWQNWkCqX3Xnbcfr--
