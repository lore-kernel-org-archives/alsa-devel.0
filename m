From: =?iso-8859-1?q?Sylvain=20Petreolle?= <spetreolle@yahoo.fr>
Subject: Current CVS doesnt compile on latest RedHat
Date: Fri, 7 Nov 2003 12:07:45 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20031107110745.86961.qmail@web10101.mail.yahoo.com>
Reply-To: spetreolle@users.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Hi,
I tried to compile today's alsa CVS and got this fault 

[syl@wine drivers]$ make
ccache gcc -D__KERNEL__ -DMODULE=1 -I/home/alsa/alsa-driver/include 
-I/lib/modules/2.4.22-1.2115.nptl/build/include -O2
-mpreferred-stack-boundary=2 -march=athlon -DLINUX -Wall
-Wstrict-prototypes -fomit-frame-pointer -Wno-trigraphs -O2
-fno-strict-aliasing -fno-common -pipe -DALSA_BUILD 
-DKBUILD_BASENAME=serialmidi   -c -o serialmidi.o serialmidi.c
serialmidi.c: In function `open_tty':
serialmidi.c:164: error: invalid operands to binary >
make: *** [serialmidi.o] Error 1

You can see that I use ccache gcc,  but I tried without it and got the
same result.
I even tried a downgrade to the previous gcc 3.2.2-5 (same output.)
Has someone any clue ?

=====
Sylvain Petreolle (spetreolle_at_users_dot_sourceforge_dot_net)
 ICQ #170597259
Say NO to software patents
Dites NON aux brevets logiciels

"What if tomorrow the War could be over ?" Morpheus, in "Reloaded".

___________________________________________________________
Do You Yahoo!? -- Une adresse @yahoo.fr gratuite et en français !
Yahoo! Mail : http://fr.mail.yahoo.com


-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?   SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
