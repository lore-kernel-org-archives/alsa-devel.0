From: Andrei Boros <andrei@srr.ro>
Subject: driver cvscompile with k-2.2.24
Date: Mon, 22 Sep 2003 11:42:07 +0300
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3F6EB5DF.6F11E29@srr.ro>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
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


Trying cvscompile on the cvs tree updated 30min ago :


make[2]: Entering directory
`/serve/install/alsa-cvs/alsa-driver/usb/us428'
gcc -D__KERNEL__ -DMODULE=1
-I/serve/install/alsa-cvs/alsa-driver/include  -I/us
r/src/linux/include -O2 -mpreferred-stack-boundary=2 -march=i586 -DLINUX
-Wall -
Wstrict-prototypes -fomit-frame-pointer -Wno-trigraphs -O2
-fno-strict-aliasing
-fno-common -pipe -DALSA_BUILD  -DKBUILD_BASENAME=usbus428   -c -o
usbus428.o us
bus428.c
In file included from /usr/src/linux/include/linux/usb.h:130,
                 from usbus428.h:3,
                 from usbus428.c:71:
/usr/src/linux/include/linux/kcomp.h:12: warning: `pci_enable_device'
redefined
/serve/install/alsa-cvs/alsa-driver/include/compat_22.h:214: warning:
this is th
e location of the previous definition
/usr/src/linux/include/linux/kcomp.h:48: warning: `IORESOURCE_IO'
redefined
/serve/install/alsa-cvs/alsa-driver/include/linux/isapnp.h:154: warning:
this is
 the location of the previous definition
/usr/src/linux/include/linux/kcomp.h:53: warning: `pci_resource_flags'
redefined
/serve/install/alsa-cvs/alsa-driver/include/compat_22.h:246: warning:
this is th
e location of the previous definition
In file included from usbus428.h:5,
                 from usbus428.c:71:
usbus428ctldefs.h:121: warning: unnamed struct/union that defines no
instances
In file included from usbus428.c:71:
usbus428.h:10: redefinition of `urb_t'
/usr/src/linux/include/linux/usb.h:395: `urb_t' previously declared here
usbus428.h:11: redefinition of `purb_t'
/usr/src/linux/include/linux/usb.h:395: `purb_t' previously declared
here
usbus428.c: In function `snd_us428_In04Int':
usbus428.c:170: warning: implicit declaration of function
`usb_fill_bulk_urb'
usbus428.c:171: structure has no member named `vol'
usbus428.c: At top level:
usbus428.c:202: elements of array `snd_us428_usb_id_table' have
incomplete type
usbus428.c:204: unknown field `match_flags' specified in initializer
usbus428.c:204: `USB_DEVICE_ID_MATCH_DEVICE' undeclared here (not in a
function)
usbus428.c:204: warning: excess elements in struct initializer
usbus428.c:204: warning: (near initialization for
`snd_us428_usb_id_table[0]')
usbus428.c:205: unknown field `idVendor' specified in initializer
usbus428.c:205: warning: excess elements in struct initializer
usbus428.c:205: warning: (near initialization for
`snd_us428_usb_id_table[0]')
usbus428.c:206: unknown field `idProduct' specified in initializer
usbus428.c:207: warning: excess elements in struct initializer
usbus428.c:207: warning: (near initialization for
`snd_us428_usb_id_table[0]')
usbus428.c:209: invalid use of undefined type `struct usb_device_id'
usbus428.c: In function `snd_us428_create_card':
usbus428.c:241: invalid use of undefined type `struct usb_device_id'
usbus428.c:241: invalid use of undefined type `struct usb_device_id'
usbus428.c: At top level:
usbus428.c:274: sizeof applied to an incomplete type
usbus428.c:277: warning: initialization from incompatible pointer type
usbus428.c:279: unknown field `id_table' specified in initializer
usbus428.c:279: warning: missing braces around initializer
usbus428.c:279: warning: (near initialization for
`snd_us428_usb_driver.driver_l
ist')
usbus428.c:279: warning: initialization from incompatible pointer type
usbus428.c:280: unknown field `driver_list' specified in initializer
usbus428.c:280: warning: braces around scalar initializer
usbus428.c:280: warning: (near initialization for
`snd_us428_usb_driver.driver_l
ist.prev')
usbus428.c:280: warning: excess elements in scalar initializer
usbus428.c:280: warning: (near initialization for
`snd_us428_usb_driver.driver_l
ist.prev')
make[2]: *** [usbus428.o] Error 1
make[2]: Leaving directory
`/serve/install/alsa-cvs/alsa-driver/usb/us428'
make[1]: *** [_modsubdir_us428] Error 2
make[1]: Leaving directory `/serve/install/alsa-cvs/alsa-driver/usb'
make: *** [compile] Error 1




-- 
ing. Andrei Boros
mailto:andrei@srr.ro / +40-21-303-1870
Centrul pt. Tehnologia Informatiei
Societatea Romana de Radiodifuziune


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
