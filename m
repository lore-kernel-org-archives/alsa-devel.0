From: Peter Plessas <plessas@mur.at>
Subject: ppc CVS compile error
Date: Sat, 12 Nov 2005 21:13:00 +0100
Message-ID: <43764CCC.5010600@mur.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
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


Dear List,

just did a fresh CVS checkout, configured with:
./configure --with-sequencer=yes --with-oss=yes 
--with-cards=hdsp,usb-audio,powermac

running make:
.
.
.
.
   CC [M]  /usr/local/src/cvs/alsa/alsa-driver/ppc/beep.o
In file included from /usr/local/src/cvs/alsa/alsa-driver/ppc/beep.c:6:
/usr/local/src/cvs/alsa/alsa-driver/ppc/../../alsa-kernel/ppc/beep.c: In 
function 's
nd_pmac_attach_beep':
/usr/local/src/cvs/alsa/alsa-driver/ppc/../../alsa-kernel/ppc/beep.c:220: 
warning: i
mplicit declaration of function 'input_allocate_device'
/usr/local/src/cvs/alsa/alsa-driver/ppc/../../alsa-kernel/ppc/beep.c:220: 
warning: a
ssignment makes pointer from integer without a cast
/usr/local/src/cvs/alsa/alsa-driver/ppc/../../alsa-kernel/ppc/beep.c:236: 
error: 'st
ruct input_dev' has no member named 'cdev'
/usr/local/src/cvs/alsa/alsa-driver/ppc/../../alsa-kernel/ppc/beep.c:252: 
warning: i
mplicit declaration of function 'input_free_device'
make[4]: *** [/usr/local/src/cvs/alsa/alsa-driver/ppc/beep.o] Error 1
make[3]: *** [/usr/local/src/cvs/alsa/alsa-driver/ppc] Error 2
make[2]: *** [_module_/usr/local/src/cvs/alsa/alsa-driver] Error 2
make[1]: *** [modules] Error 2
make[1]: Leaving directory `/usr/src/linux-2.6.13'
make: *** [compile] Error 2


Any hints?

cheers, Peter


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
