From: "Markus Bollinger" <bollinger@digigram.com>
Subject: RE: CVS doesn't compile
Date: Mon, 28 Jul 2003 10:16:03 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <08F1D234AF91E540BC1F43889E2A6AA70C1516@digiexch.digigram.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_001_01C354E0.7C988630"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
content-class: urn:content-classes:message
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Martin Langer <martin-langer@gmx.de>, alsa-devel@lists.sourceforge.net
Cc: tiwai@suse.de
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.

------_=_NextPart_001_01C354E0.7C988630
Content-Type: text/plain;
	charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

Sorry,
I didnt know that compilers can get angry with [].
Use the attached patch.

What compiler version are you using ?

Markus.


-----Original Message-----
From:	Martin Langer [mailto:martin-langer@gmx.de]
Sent:	Sun 7/27/2003 11:36 AM
To:	alsa-devel@lists.sourceforge.net
Cc:=09
Subject:	[Alsa-devel] CVS doesn't compile


Sorry to say,

but CVS doesn't compile! Building the mixart driver fails:

make[3]: Entering directory =
/usr/local/src/alsa-cvs/alsa-driver/pci/mixart'
gcc -D__KERNEL__ -DMODULE=3D1 =
-I/usr/local/src/alsa-cvs/alsa-driver/include
-I/lib/modules/2.4.19-rc1/build/include -O2 =
-mpreferred-stack-boundary=3D2
-march=3Di686 -malign-functions=3D4 -DLINUX -Wall -Wstrict-prototypes
-fomit-frame-pointer -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common
-pipe -DALSA_BUILD  -DKBUILD_BASENAME=3Dmixart   -c -o mixart.o mixart.c
In file included from mixart.c:35:
mixart_core.h:292: field streams' has incomplete type
make[3]: *** [mixart.o] Error 1
make[3]: Leaving directory =
/usr/local/src/alsa-cvs/alsa-driver/pci/mixart'
make[2]: *** [_modsubdir_mixart] Error 2
make[2]: Leaving directory /usr/local/src/alsa-cvs/alsa-driver/pci'
make[1]: *** [compile] Error 1


martin


-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100003ave/direct;at.aspnet_072303_01/=
01
_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel



------_=_NextPart_001_01C354E0.7C988630
Content-Type: text/x-diff;
	name="patch"
Content-Transfer-Encoding: base64
Content-Description: patch
Content-Disposition: attachment;
	filename="patch"

LS0tIHBjaS9taXhhcnQtY3ZzL21peGFydF9jb3JlLmgJMjAwMy0wNy0yMiAxNTozOToxMC4wMDAw
MDAwMDAgKzAyMDAKKysrIHBjaS9taXhhcnQvbWl4YXJ0X2NvcmUuaAkyMDAzLTA3LTI4IDA5OjMw
OjE5LjAwMDAwMDAwMCArMDIwMApAQCAtMjg5LDcgKzI4OSw3IEBACiBzdHJ1Y3QgbWl4YXJ0X3Rp
bWVyX25vdGlmeQogewogCXUzMiAgICAgICAgICAgICAgICAgIHN0cmVhbV9jb3VudDsKLQltaXhh
cnRfc2FtcGxlX3Bvc190ICBzdHJlYW1zW107CisJbWl4YXJ0X3NhbXBsZV9wb3NfdCAgc3RyZWFt
c1tNSVhBUlRfTUFYX1NUUkVBTV9QRVJfQ0FSRCAqIE1JWEFSVF9NQVhfQ0FSRFNdOwogfSBfX2F0
dHJpYnV0ZV9fKChwYWNrZWQpKTsKIAogCg==

------_=_NextPart_001_01C354E0.7C988630--


-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100003ave/direct;at.aspnet_072303_01/01
