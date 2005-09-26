From: Martin Klaiber <martinkl@zedat.fu-berlin.de>
Subject: Error when trying to compile code from CVS
Date: Mon, 26 Sep 2005 19:40:31 +0200
Message-ID: <20050926174031.GA7590@martinkl.dialup.fu-berlin.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hello,

when I try to compile the actual code from the CVS, I get the
following error:

   In file included from memory.c:2:
   ../alsa-kernel/core/memory.c:126: error: syntax error before "this_object_must_be_defined_as_export_objs_in_the_Makefile"
   ../alsa-kernel/core/memory.c:126: warning: type defaults to `int' in declaration of `this_object_must_be_defined_as_export_objs_in_the_Makefile'
   ../alsa-kernel/core/memory.c:126: warning: data definition has no type or storage class
   make[1]: *** [memory.o] Error 1
   make[1]: Leaving directory `/home/martinkl/src/sonst/alsa/alsa-driver/acore'
   make: *** [compile] Error 1

Could someone tell me what I am doing wrong? To compile I run the script
./cvscompile, which is included in the code.

If you need any additional information, please let me know. I am using
Debian sarge.

TIA, Martin


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
