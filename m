From: Carlo Wood <carlo@alinoe.com>
Subject: ALSA (CVS) doesn't compile on recent linux (alsa-driver)
Date: Fri, 18 Jul 2003 14:31:33 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030718123133.GB9756@alinoe.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
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
Cc: "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

gcc -D__KERNEL__ -DMODULE=1 -I/usr/src/alsa/alsa-driver/include  -I/lib/modules/2.5.74-debug/build/include -O2 -mpreferred-stack-boundary=2 -march=athlon -I/lib/modules/2.5.74-debug/build/include/asm-i386/mach-default -DLINUX -Wall -Wstrict-prototypes -fomit-frame-pointer -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -pipe -DALSA_BUILD  -DKBUILD_BASENAME=serialmidi   -c -o serialmidi.o serialmidi.c
serialmidi.c:46: warning: type defaults to `int' in declaration of `EXPORT_NO_SYMBOLS'
serialmidi.c:46: warning: data definition has no type or storage class
serialmidi.c: In function `open_tty':
serialmidi.c:139: warning: passing arg 2 of `set_bit' from incompatible pointer type
serialmidi.c:153: request for member `set_termios' in something not a structure or union
serialmidi.c:218: request for member `set_termios' in something not a structure or union
serialmidi.c:234: warning: passing arg 2 of `set_bit' from incompatible pointer type
serialmidi.c: In function `close_tty':
serialmidi.c:255: warning: passing arg 2 of `clear_bit' from incompatible pointer type
serialmidi.c:256: warning: passing arg 2 of `constant_test_bit' from incompatible pointer type
serialmidi.c:256: warning: passing arg 2 of `variable_test_bit' from incompatible pointer type
serialmidi.c: In function `ldisc_receive_buf':
serialmidi.c:283: warning: passing arg 2 of `constant_test_bit' from incompatible pointer type
serialmidi.c:283: warning: passing arg 2 of `variable_test_bit' from incompatible pointer type
serialmidi.c: In function `tx_loop':
serialmidi.c:298: request for member `write_room' in something not a structure or union
serialmidi.c:306: request for member `write' in something not a structure or union
serialmidi.c: In function `snd_serialmidi_output_trigger':
serialmidi.c:328: warning: passing arg 2 of `set_bit' from incompatible pointer type
serialmidi.c:333: warning: passing arg 2 of `clear_bit' from incompatible pointer type
serialmidi.c: In function `snd_serialmidi_input_trigger':
serialmidi.c:342: warning: passing arg 2 of `set_bit' from incompatible pointer type
serialmidi.c:344: warning: passing arg 2 of `clear_bit' from incompatible pointer type
make[1]: *** [serialmidi.o] Error 1
make[1]: Leaving directory `/usr/src/alsa/alsa-driver/drivers'
make: *** [compile] Error 1

-- 
Carlo Wood <carlo@alinoe.com>


-------------------------------------------------------
This SF.net email is sponsored by: VM Ware
With VMware you can run multiple operating systems on a single machine.
WITHOUT REBOOTING! Mix Linux / Windows / Novell virtual machines at the
same time. Free trial click here: http://www.vmware.com/wl/offer/345/0
