From: Gerhard Dirschl <gerhard.dirschl@gmx.de>
Subject: [PATCH] pcm_dmix fix
Date: Wed, 9 Jul 2003 14:11:14 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030709121114.GA11712@euh11a303.stud.uni-karlsruhe.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="y0ulUmNC+osPPQO6"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


--y0ulUmNC+osPPQO6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

 Hi,

found a small bug in MIX_AREAS2 (pcm_dmix_i386.h):
>        "\tmovl $0, %%eax\n"
>        "\tmovl $1, %%ecx\n"
>        "\tmovl (%%ebx), %%edx\n"
>        "\t" LOCK_PREFIX "cmpxchgl %%ecx, (%%edi)\n"
>        "\tjnz 2f\n"
>        "\tmovl (%%esi), %%ecx\n"
>        "\tshr $8, %%ecx\n"
>        "\tsubl %%edx, %%ecx\n"
>        "2:"
>        "\tmovl (%%esi), %%ecx\n"
>        "\tshr $8, %%ecx\n"
>        "\t" LOCK_PREFIX "addl %%ecx, (%%ebx)\n"

- subl %edx, %ecx has no effect (result is overwritten by the next ops)
- we have signed values so we have to use "sarl" (sign-extend) instead 
  of "shr".

A patch is appended.

 ciao 
    gd...

-- 
Gerhard Dirschl               !! See you at the LinuxTag 2003 !!
Karlsruhe
Germany

--y0ulUmNC+osPPQO6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="dmix.patch"

--- alsa-lib.old/src/pcm/pcm_dmix_i386.h	2003-03-18 19:00:20.000000000 +0100
+++ alsa-lib/src/pcm/pcm_dmix_i386.h	2003-07-09 13:47:35.000000000 +0200
@@ -283,16 +283,13 @@
 		 *   xadd(*sum, sample);
 		 */
 		"\tmovl $0, %%eax\n"
-		"\tmovl $1, %%ecx\n"
-		"\tmovl (%%ebx), %%edx\n"
-		"\t" LOCK_PREFIX "cmpxchgl %%ecx, (%%edi)\n"
-		"\tjnz 2f\n"
+		"\tmovl $1, %%edx\n"
 		"\tmovl (%%esi), %%ecx\n"
-		"\tshr $8, %%ecx\n"
-		"\tsubl %%edx, %%ecx\n"
+		"\tsarl $8, %%ecx\n"
+		"\t" LOCK_PREFIX "cmpxchgl %%edx, (%%edi)\n"
+		"\tjnz 2f\n"
+		"\tsubl (%%ebx), %%ecx\n"
 		"2:"
-		"\tmovl (%%esi), %%ecx\n"
-		"\tshr $8, %%ecx\n"
 		"\t" LOCK_PREFIX "addl %%ecx, (%%ebx)\n"
 
 		/*
@@ -310,7 +307,7 @@
 		"\tcmpl $-0x800000,%%ecx\n"
 		"\tjl 5f\n"
 		"\tmov %%ecx, %%eax\n"
-		"\tshl $8, %%eax\n"
+		"\tshll $8, %%eax\n"
 		"\tmovl %%eax, (%%edi)\n"
 		"\tcmpl %%ecx, (%%ebx)\n"
 		"\tjnz 3b\n"

--y0ulUmNC+osPPQO6--


-------------------------------------------------------
This SF.Net email sponsored by: Parasoft
Error proof Web apps, automate testing & more.
Download & eval WebKing and get a free book.
www.parasoft.com/bulletproofapps
