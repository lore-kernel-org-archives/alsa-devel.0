From: gimpel <gimpel@sonnenkinder.org>
Subject: kernel 2.6.12 + alsa-kernel CVS
Date: Sun, 10 Jul 2005 19:48:27 +0200
Message-ID: <20050710194827.2fecdcef@SiRiUS.home>
Mime-Version: 1.0
Content-Type: multipart/signed;
 boundary=Signature_Sun__10_Jul_2005_19_48_27_+0200_J1rWWza4+rgkLKj3;
 protocol="application/pgp-signature"; micalg=pgp-sha1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.gmx.net (imap.gmx.net [213.165.64.20])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with SMTP id 2AC951A6
	for <alsa-devel@alsa-project.org>; Sun, 10 Jul 2005 19:48:41 +0200 (MEST)
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
List-Id: alsa-devel@alsa-project.org

--Signature_Sun__10_Jul_2005_19_48_27_+0200_J1rWWza4+rgkLKj3
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Hi there!

I heard some basic ESI Juli@ support is vailable in CVS so i wanted to
create a 2.6.12 kernel with Ingo Molnar's realtime preemption and ALSA
from CVS.
As there where changes from strdup to kstrdup i applied following
patches from 2.6.12-mm1:

create-a-kstrdup-library-function.patch
create-a-kstrdup-library-function-fixes.patch
create-a-kstrdup-library-function-fix-include-slab.patch
create-a-kstrdup-library-function-ppc-fix.patch
kstrdup-convert-a-few-existing-implementations.patch

afterwards i copied over alsa-kernel from a fresh checkout, and got
some compile errors:

...
  CC      sound/sound_core.o
sound/sound_core.c: In function `sound_insert_unit':
sound/sound_core.c:177: Warnung: implizite Deklaration der Funktion
=BBclass_device_create=AB sound/sound_core.c: In function
`sound_remove_unit': sound/sound_core.c:201: Warnung: implizite
Deklaration der Funktion =BBclass_device_destroy=AB sound/sound_core.c: In
function `cleanup_soundcore': sound/sound_core.c:565: Warnung:
implizite Deklaration der Funktion =BBclass_destroy=AB sound/sound_core.c:
In function `init_soundcore': sound/sound_core.c:575: Warnung:
implizite Deklaration der Funktion =BBclass_create=AB sound/
sound_core.c:575: Warnung: Zuweisung erzeugt Zeiger von Ganzzahl ohne
Typkonvertierung CC      sound/sound_firmware.o
...
  CC      sound/core/sound.o
sound/core/sound.c: In function `snd_register_device':
sound/core/sound.c:234: Warnung: implizite Deklaration der Funktion
=BBclass_device_create=AB sound/core/sound.c: In function
`snd_unregister_device': sound/core/sound.c:266: Warnung: implizite
Deklaration der Funktion =BBclass_device_destroy=AB CC      sound/core/
init.o
...
  LD      init/built-in.o
  LD      .tmp_vmlinux1
sound/built-in.o(.text+0x1cb): In function `sound_insert_unit':
: undefined reference to `class_device_create'
sound/built-in.o(.text+0x251): In function `sound_remove_unit':
: undefined reference to `class_device_destroy'
sound/built-in.o(.text+0xf61): In function `snd_register_device':
: undefined reference to `class_device_create'
sound/built-in.o(.text+0x1024): In function `snd_unregister_device':
: undefined reference to `class_device_destroy'
sound/built-in.o(.exit.text+0x20): In function `cleanup_soundcore':
: undefined reference to `class_destroy'
sound/built-in.o(.init.text+0x32): In function `init_soundcore':
: undefined reference to `class_create'
make: *** [.tmp_vmlinux1] Fehler 1


would be nice if someone could point out if that is just some bug in
CVS currently, or if i did something wrong regarding the kstrdup
patches or missed some stuff out. Unfortunately i'm not a coder and
can't take a look myself.

regards
tom

--Signature_Sun__10_Jul_2005_19_48_27_+0200_J1rWWza4+rgkLKj3
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQFC0V+F21TUzfKRUn4RApS7AJ96+7ykVBgaGzR5QREM43jjK5a0TwCfXUsk
e6jkOneFnjWfiSRvjCfluGg=
=D1tG
-----END PGP SIGNATURE-----

--Signature_Sun__10_Jul_2005_19_48_27_+0200_J1rWWza4+rgkLKj3--


-------------------------------------------------------
This SF.Net email is sponsored by the 'Do More With Dual!' webinar happening
July 14 at 8am PDT/11am EDT. We invite you to explore the latest in dual
core and dual graphics technology at this free one hour event hosted by HP, 
AMD, and NVIDIA.  To register visit http://www.hp.com/go/dualwebinar
