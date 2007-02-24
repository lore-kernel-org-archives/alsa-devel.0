From: "John Utz" <John.Utz@dmxmusic.com>
Subject: patch: ac97_patch.c - enable 'Smart 5.1' on VIA
 vt1617a ac97 codec
Date: Fri, 23 Feb 2007 16:44:33 -0800
Message-ID: <F8FB97052F1BEF409F7842E960E49B5AAAF8B4@sea-exch-01.na.corp.dmxmusic.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="----_=_NextPart_001_01C757AC.F3BA79F2"
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Content-class: urn:content-classes:message
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.

------_=_NextPart_001_01C757AC.F3BA79F2
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_002_01C757AC.F3BA79F2"
Content-Transfer-Encoding: 7bit


------_=_NextPart_002_01C757AC.F3BA79F2
Content-Type: text/plain;
 charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable


This patch allows via vt1617a end users to configure what via calls =
Smart 5.1 - a mechanism for controlling the 3 bi-directional analog =
connectors that some OEM's use instead of a larger collection of =
dedicated analog input and output connectors.

As outlined in previous discussion on this list, the outcome matrix for =
togging these bits is somewhat arcane and seemingly lacking in cohesion, =
but with only 3 bits, it's reasonable to expect that a motivated end =
user will be able to eventually configure their own personal setup to =
their needs.

Note that in some instances (such as an epia C7) it is also required to =
disable 'alternate surround out' to get surround to work properly.

Note that this is my first ever alsa patch and after review by wiser =
craniums it may need fixin'. ;-)

plz dont hesitate to ask for such corrections!

tnx!

johnu

------_=_NextPart_002_01C757AC.F3BA79F2
Content-Type: text/html;
 charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<HTML>
<HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Diso-8859-1">
<META NAME=3D"Generator" CONTENT=3D"MS Exchange Server version =
6.5.7638.1">
<TITLE>patch: ac97_patch.c - enable 'Smart 5.1' on VIA vt1617a ac97 =
codec</TITLE>
</HEAD>
<BODY>
<!-- Converted from text/plain format -->
<BR>

<P><FONT SIZE=3D2>This patch allows via vt1617a end users to configure =
what via calls Smart 5.1 - a mechanism for controlling the 3 =
bi-directional analog connectors that some OEM's use instead of a larger =
collection of dedicated analog input and output connectors.<BR>
<BR>
As outlined in previous discussion on this list, the outcome matrix for =
togging these bits is somewhat arcane and seemingly lacking in cohesion, =
but with only 3 bits, it's reasonable to expect that a motivated end =
user will be able to eventually configure their own personal setup to =
their needs.<BR>
<BR>
Note that in some instances (such as an epia C7) it is also required to =
disable 'alternate surround out' to get surround to work properly.<BR>
<BR>
Note that this is my first ever alsa patch and after review by wiser =
craniums it may need fixin'. ;-)<BR>
<BR>
plz dont hesitate to ask for such corrections!<BR>
<BR>
tnx!<BR>
<BR>
johnu<BR>
</FONT>
</P>

</BODY>
</HTML>
------_=_NextPart_002_01C757AC.F3BA79F2--

------_=_NextPart_001_01C757AC.F3BA79F2
Content-Type: application/octet-stream;
 name=ac97_patch_c-1617aSmart51.patch
Content-Transfer-Encoding: base64
Content-Description: ac97_patch_c-1617aSmart51.patch
Content-Disposition: attachment;
 filename=ac97_patch_c-1617aSmart51.patch

ZGlmZiAtciAyOWIwYjQyNDVkMDYgcGNpL2FjOTcvYWM5N19wYXRjaC5jCi0tLSBhL3BjaS9hYzk3
L2FjOTdfcGF0Y2guYwlUaHUgRmViIDIyIDE2OjA3OjIxIDIwMDcgKzAxMDAKKysrIGIvcGNpL2Fj
OTcvYWM5N19wYXRjaC5jCUZyaSBGZWIgMjMgMTY6MjM6MzYgMjAwNyAtMDgwMApAQCAtMzI3Myw4
ICszMjczLDI4IEBAIHN0YXRpYyBpbnQgcGF0Y2hfdnQxNjE2KHN0cnVjdCBzbmRfYWM5NyAKIC8q
CiAgKiBWVDE2MTdBIGNvZGVjCiAgKi8KKworc3RhdGljIGNvbnN0IHN0cnVjdCBzbmRfa2NvbnRy
b2xfbmV3IHNuZF9hYzk3X2NvbnRyb2xzX3Z0MTYxN2FbXSA9IHsKKyAgQUM5N19TSU5HTEUoIkNl
bnRlci9MRkUgRXhjaGFuZ2UiLCAgIDB4NWEsICA4LCAxLCAwKSwKKyAgLyoKKyAgICogVGhlc2Ug
YXJlIHVzZWQgdG8gZW5hYmxlL2Rpc2FibGUgc3Vycm91bmQgc291bmQgb24gbW90aGVyYm9hcmRz
CisgICAqIHRoYXQgaGF2ZSAzIGJpZGlyZWN0aW9uYWwgYW5hbG9nIGphY2tzCisgICAqLworICBB
Qzk3X1NJTkdMRSgiU21hcnQgNS4xIENvbnRyb2wgQSIsIDB4MjAsICA4LCAxLCAwKSwKKyAgQUM5
N19TSU5HTEUoIlNtYXJ0IDUuMSBDb250cm9sIEIiLCAweDdhLCAxNSwgMSwgMCksCisgIEFDOTdf
U0lOR0xFKCJTbWFydCA1LjEgQ29udHJvbCBDIiwgMHg3YSwgMTQsIDEsIDApCit9OworCiBzdGF0
aWMgaW50IHBhdGNoX3Z0MTYxN2Eoc3RydWN0IHNuZF9hYzk3ICogYWM5NykKIHsKKyAgICAgICAg
LyogaW5zdGFudGlhdGUgb3VyIHNwZWNpZmljIGNvbnRyb2xzLCB3ZSBjaG9vc2UgdG8gY29udGlu
dWUgaW4gdGhlIGV2ZW50IG9mIGZhaWx1cmUKKwkgICBiZWNhdXNlIHdlIHdpc2ggdG8gYWxsb3cg
dGhlIG90aGVyIGFjdGlvbnMgdG8gY29udGludWUgKi8KKworCWludCBlcnIgPSAwOworCisJZXJy
ID0gcGF0Y2hfYnVpbGRfY29udHJvbHMoYWM5NywgJnNuZF9hYzk3X2NvbnRyb2xzX3Z0MTYxN2Fb
MF0sCisJCQkJICAgQVJSQVlfU0laRShzbmRfYWM5N19jb250cm9sc192dDE2MTdhKSk7CisKIAkv
KiBicmluZyBhbmFsb2cgcG93ZXIgY29uc3VtcHRpb24gdG8gbm9ybWFsLCBsaWtlIFdpblhQIGRy
aXZlcgogCSAqIGZvciBFUElBIFNQCiAJICovCkBAIC0zMjgyLDcgKzMzMDIsNyBAQCBzdGF0aWMg
aW50IHBhdGNoX3Z0MTYxN2Eoc3RydWN0IHNuZF9hYzk3CiAJYWM5Ny0+ZXh0X2lkIHw9IEFDOTdf
RUlfU1BESUY7CS8qIGZvcmNlIHRoZSBkZXRlY3Rpb24gb2Ygc3BkaWYgKi8KIAlhYzk3LT5yYXRl
c1tBQzk3X1JBVEVTX1NQRElGXSA9IFNORFJWX1BDTV9SQVRFXzQ0MTAwIHwgU05EUlZfUENNX1JB
VEVfNDgwMDA7CiAJYWM5Ny0+YnVpbGRfb3BzID0gJnBhdGNoX3Z0MTYxNl9vcHM7Ci0JcmV0dXJu
IDA7CisJcmV0dXJuIGVycjsKIH0KIAogLyoK

------_=_NextPart_001_01C757AC.F3BA79F2
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
------_=_NextPart_001_01C757AC.F3BA79F2
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

------_=_NextPart_001_01C757AC.F3BA79F2--
