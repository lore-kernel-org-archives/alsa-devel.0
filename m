From: Andre Batista de Oliveira <abo@netvisao.pt>
Subject: card_id() in initval.h
Date: 23 Dec 2003 20:00:37 +0000
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <x7k74nuwwq.fsf@dorian.home.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
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

I'm facing some problems passing the ALSA drivers'
parameters from the kernel command line.

When I try to specify the ID string for the card
(snd-sgalaxy=3D1,0,Waverider,0x220,0x530,10,3),
the kernel just reboots immediately, even before printing anything!

But when I leave the ID string unspecified
(snd-sgalaxy=3D1,0,,0x220,0x530,10,3), it boots and works fine,
and the card gets the default "Galaxy" ID.

I believe this has something to do with the kmalloc() call
in the get_id() function in the initval.h include file.
Perhaps kmalloc() can not be used at this early boot stage?!?
I fixed it by replacing kmalloc() with alloc_bootmem(),
and now it works, but there's probably a better way to do it!

Does this make any sense? Is this a known bug? Is this a bug, at all?
Thanks.

Here's the diff:

--- initval.h.orig      Tue Dec 23 16:56:26 2003
+++ initval.h   Tue Dec 23 18:00:10 2003
@@ -136,25 +136,23 @@
 #if defined(SNDRV_GET_ID) && !defined(MODULE)
 #include <linux/ctype.h>
 #include <linux/init.h>
+#include <linux/bootmem.h>
 static int __init get_id(char **str, char **dst)
 {
-       char *s, *d;
+       char *s;
=20
        if (!(*str) || !(**str))
                return 0;
        for (s =3D *str; isalpha(*s) || isdigit(*s) || *s =3D=3D '_'; s++);
        if (s !=3D *str) {
-               *dst =3D (char *)kmalloc((s - *str) + 1, GFP_KERNEL);
-               s =3D *str; d =3D *dst;
-               while (isalpha(*s) || isdigit(*s) || *s =3D=3D '_') {
-                       if (d !=3D NULL)
-                               *d++ =3D *s;
-                       s++;
-               }
-               if (d !=3D NULL)
+               char *d =3D alloc_bootmem(s - *str + 1);
+               if (d !=3D NULL) {
+                       *dst =3D d;
+                       while (s !=3D *str) *d++ =3D *(*str)++;
                        *d =3D '\0';
+               } else
+                       *str =3D s;
        }
-       *str =3D s;
        if (*s =3D=3D ',') {
                (*str)++;
                return 2;



--=20
Andr=E9 Batista de Oliveira
http://mega.ist.utl.pt/~abo


-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
