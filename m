From: "Arcady Genkin" <agenkin@thpoon.com>
Subject: Alsa-tools-0.9.5 compilation breakage on gcc 3.3 (patch attached)
Date: 15 Jul 2003 14:14:41 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <uohe5nwtbi.fsf@bashful.cdf.toronto.edu>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Return-path: <alsa-devel-admin@lists.sourceforge.net>
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

--=-=-=

Greetings:

Compilation of alsa-tools (0.9.4 and 0.9.5) breaks with gcc 3.3
because of the multi-line literals issue.  Attached please find a
patch by Jason Rhinelander <jason-gentoo@gossamer-threads.com> that
fixes the trivial problem.  For more info please see:

             http://bugs.gentoo.org/show_bug.cgi?id=22324

Many thanks,
-- 
Arcady Genkin

guilt is the cause of more disauders
than history's most obscene marorders (E.E. Cummings)


--=-=-=
Content-Type: text/x-patch
Content-Disposition: attachment; filename=alsa-tools-0.9.5-gcc3.3.patch
Content-Description: patch for alsa-tools 0.9.5

--- alsa-tools-0.9.4/as10k1/as10k1.c	2003-05-14 23:45:17.000000000 -0700
+++ alsa-tools-0.9.4-gcc33/as10k1/as10k1.c	2003-06-05 20:33:53.000000000 -0700
@@ -43,29 +43,28 @@
 
 char version[]="As10k1 assembler version " VERSION;
 
-char help[]="
-Usage: as10k1 [option...] asmfile
-
-The as10k1 assembler is for the emu10k1 dsp processor
-found in Creative Lab's sblive series of sound cards.
-
-Author: Daniel Bertrand <d.bertrand@ieee.ca>
-
-Options:\n
-     -l [listfile]         Specify a listing file, default is none.
-     -o [emu10k1 file]     Specify an output file, default is based input,
-                           Substituting .asm to .emu10k1
-     -d [dbg_options...]   Turn on debug messages.
-            s              prints all symbols                
-            g              prints defined gprs
-            t              prints tram usage
-            i              prints instructions
-     -h                    Prints this message  
-     -v                    Prints version number. 
-
-This program is distributed under the GPL.
-
-";
+char help[]="\n"
+"Usage: as10k1 [option...] asmfile\n"
+"\n"
+"The as10k1 assembler is for the emu10k1 dsp processor\n"
+"found in Creative Lab's sblive series of sound cards.\n"
+"\n"
+"Author: Daniel Bertrand <d.bertrand@ieee.ca>\n"
+"\n"
+"Options:\n\n"
+"     -l [listfile]         Specify a listing file, default is none.\n"
+"     -o [emu10k1 file]     Specify an output file, default is based input,\n"
+"                           Substituting .asm to .emu10k1\n"
+"     -d [dbg_options...]   Turn on debug messages.\n"
+"            s              prints all symbols                \n"
+"            g              prints defined gprs\n"
+"            t              prints tram usage\n"
+"            i              prints instructions\n"
+"     -h                    Prints this message  \n"
+"     -v                    Prints version number. \n"
+"\n"
+"This program is distributed under the GPL.\n"
+"\n";
 
 //  cli==Command-Line Interface && !Creative Labs Inc.
 

--=-=-=--


-------------------------------------------------------
This SF.Net email sponsored by: Parasoft
Error proof Web apps, automate testing & more.
Download & eval WebKing and get a free book.
www.parasoft.com/bulletproofapps1
