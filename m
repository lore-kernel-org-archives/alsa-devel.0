From: <Dirk.Kalis@nextiraone.de>
Subject: RE: ice1712 Card ID problem
Date: Thu, 9 Sep 2004 10:28:02 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <E3DC5887246ABD48BFE0B3CA0183FC25010164CB@SLBENF.ebdmail.alcatel.de>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_001_01C49646.EBFE2AE0"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
content-class: urn:content-classes:message
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

This is a multi-part message in MIME format.

------_=_NextPart_001_01C49646.EBFE2AE0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_002_01C49646.EBFE2AE0"


------_=_NextPart_002_01C49646.EBFE2AE0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hello Ross,

first the 8 outputs are pcm channels only. the analog inputs/outputs are =
set to 0 because in the driver the values for
num_total_dacs and num_total_adcs are set to 0 if the Card ID is not =
known.
Try this 2 patches recompile the driver and envy24control.
the patch for envy24control is not necessary because no special handling =
for delta44 in envy24control

best regards
Dirk Kalis
 <<delta.dif>>  <<envy24control.dif>>=20

------_=_NextPart_002_01C49646.EBFE2AE0
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<HTML>
<HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Diso-8859-1">
<META NAME=3D"Generator" CONTENT=3D"MS Exchange Server version =
6.0.6396.0">
<TITLE>RE: ice1712 Card ID problem</TITLE>
</HEAD>
<BODY>
<!-- Converted from text/rtf format -->

<P><FONT SIZE=3D2 FACE=3D"Arial">Hello Ross,</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Arial">first the 8 outputs are pcm channels =
only. the analog inputs/outputs are set to 0 because in the driver the =
values for</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">num_total_dacs and num_total_adcs are =
set to 0 if the Card ID is not known.</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Try this 2 patches recompile the =
driver and envy24control.</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">the patch for envy24control is not =
necessary because no special handling for delta44 in =
envy24control</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Arial">best regards</FONT>

<BR><B><FONT SIZE=3D2 FACE=3D"Courier New">Dirk Kalis</FONT></B>

<BR><FONT FACE=3D"Arial" SIZE=3D2 COLOR=3D"#000000"> =
&lt;&lt;delta.dif&gt;&gt; </FONT><FONT FACE=3D"Arial" SIZE=3D2 =
COLOR=3D"#000000"> &lt;&lt;envy24control.dif&gt;&gt; </FONT>
</P>

</BODY>
</HTML>
------_=_NextPart_002_01C49646.EBFE2AE0--

------_=_NextPart_001_01C49646.EBFE2AE0
Content-Type: application/octet-stream;
	name="delta.dif"
Content-Transfer-Encoding: base64
Content-Description: delta.dif
Content-Disposition: attachment;
	filename="delta.dif"

LS0tIGRlbHRhLmgub3JpCVRodSBTZXAgIDkgMTA6MDQ6NTQgMjAwNAorKysgZGVsdGEuaAlUaHUg
U2VwICA5IDA5OjQ5OjIxIDIwMDQKQEAgLTMxLDYgKzMxLDcgQEAKIAkJIntNaWRpTWFuIE0gQXVk
aW8sRGVsdGEgRGlPIDI0OTZ9LCJcCiAJCSJ7TWlkaU1hbiBNIEF1ZGlvLERlbHRhIDY2fSwiXAog
CQkie01pZGlNYW4gTSBBdWRpbyxEZWx0YSA0NH0sIlwKKwkJIntNaWRpTWFuIE0gQXVkaW8sRGVs
dGEgNDQtMn0sIlwKIAkJIntNaWRpTWFuIE0gQXVkaW8sQXVkaW9waGlsZSAyNC85Nn0sIlwKIAkJ
IntEaWdpZ3JhbSxWWDQ0Mn0sIgogCkBAIC0zOCw2ICszOSw3IEBACiAjZGVmaW5lIElDRTE3MTJf
U1VCREVWSUNFX0RFTFRBRElPMjQ5NgkweDEyMTQzMWQ2CiAjZGVmaW5lIElDRTE3MTJfU1VCREVW
SUNFX0RFTFRBNjYJMHgxMjE0MzJkNgogI2RlZmluZSBJQ0UxNzEyX1NVQkRFVklDRV9ERUxUQTQ0
CTB4MTIxNDMzZDYKKyNkZWZpbmUgSUNFMTcxMl9TVUJERVZJQ0VfREVMVEE0NF8yCTB4MTIxNDMz
YTAKICNkZWZpbmUgSUNFMTcxMl9TVUJERVZJQ0VfQVVESU9QSElMRQkweDEyMTQzNGQ2CiAjZGVm
aW5lIElDRTE3MTJfU1VCREVWSUNFX0RFTFRBNDEwCTB4MTIxNDM4ZDYKICNkZWZpbmUgSUNFMTcx
Ml9TVUJERVZJQ0VfREVMVEExMDEwTFQJMHgxMjE0M2JkNgotLS0gZGVsdGEuYy5vcmkJVGh1IFNl
cCAgOSAxMDowMzo1NiAyMDA0CisrKyBkZWx0YS5jCVRodSBTZXAgIDkgMDk6NDg6NTggMjAwNApA
QCAtNTIwLDYgKzUyMCw3IEBACiAJCWljZS0+bnVtX3RvdGFsX2FkY3MgPSAyOwogCQlicmVhazsK
IAljYXNlIElDRTE3MTJfU1VCREVWSUNFX0RFTFRBNDQ6CisJY2FzZSBJQ0UxNzEyX1NVQkRFVklD
RV9ERUxUQTQ0XzI6CiAJY2FzZSBJQ0UxNzEyX1NVQkRFVklDRV9ERUxUQTY2OgogCQlpY2UtPm51
bV90b3RhbF9kYWNzID0gaWNlLT5vbW5pID8gOCA6IDQ7CiAJCWljZS0+bnVtX3RvdGFsX2FkY3Mg
PSBpY2UtPm9tbmkgPyA4IDogNDsKQEAgLTU5Myw2ICs1OTQsNyBAQAogCQlicmVhazsKIAljYXNl
IElDRTE3MTJfU1VCREVWSUNFX0RFTFRBNjY6CiAJY2FzZSBJQ0UxNzEyX1NVQkRFVklDRV9ERUxU
QTQ0OgorCWNhc2UgSUNFMTcxMl9TVUJERVZJQ0VfREVMVEE0NF8yOgogCQllcnIgPSBzbmRfaWNl
MTcxMl9ha200eHh4X2luaXQoYWssICZha21fZGVsdGE0NCwgJmFrbV9kZWx0YTQ0X3ByaXYsIGlj
ZSk7CiAJCWJyZWFrOwogCWNhc2UgSUNFMTcxMl9TVUJERVZJQ0VfVlg0NDI6CkBAIC02NzcsNiAr
Njc5LDcgQEAKIAljYXNlIElDRTE3MTJfU1VCREVWSUNFX0FVRElPUEhJTEU6CiAJY2FzZSBJQ0Ux
NzEyX1NVQkRFVklDRV9ERUxUQTQxMDoKIAljYXNlIElDRTE3MTJfU1VCREVWSUNFX0RFTFRBNDQ6
CisJY2FzZSBJQ0UxNzEyX1NVQkRFVklDRV9ERUxUQTQ0XzI6CiAJY2FzZSBJQ0UxNzEyX1NVQkRF
VklDRV9ERUxUQTY2OgogCWNhc2UgSUNFMTcxMl9TVUJERVZJQ0VfVlg0NDI6CiAJCWVyciA9IHNu
ZF9pY2UxNzEyX2FrbTR4eHhfYnVpbGRfY29udHJvbHMoaWNlKTsKQEAgLTcxNyw2ICs3MjAsMTQg
QEAKIAl7CiAJCS5zdWJ2ZW5kb3IgPSBJQ0UxNzEyX1NVQkRFVklDRV9ERUxUQTQ0LAogCQkubmFt
ZSA9ICJNIEF1ZGlvIERlbHRhIDQ0IiwKKwkJLm1vZGVsID0gImRlbHRhNDQiLAorCQkuY2hpcF9p
bml0ID0gc25kX2ljZTE3MTJfZGVsdGFfaW5pdCwKKwkJLmJ1aWxkX2NvbnRyb2xzID0gc25kX2lj
ZTE3MTJfZGVsdGFfYWRkX2NvbnRyb2xzLAorCQkubm9fbXB1NDAxID0gMSwKKwl9LAorCXsKKwkJ
LnN1YnZlbmRvciA9IElDRTE3MTJfU1VCREVWSUNFX0RFTFRBNDRfMiwKKwkJLm5hbWUgPSAiTSBB
dWRpbyBEZWx0YSA0NC0yIiwKIAkJLm1vZGVsID0gImRlbHRhNDQiLAogCQkuY2hpcF9pbml0ID0g
c25kX2ljZTE3MTJfZGVsdGFfaW5pdCwKIAkJLmJ1aWxkX2NvbnRyb2xzID0gc25kX2ljZTE3MTJf
ZGVsdGFfYWRkX2NvbnRyb2xzLAo=

------_=_NextPart_001_01C49646.EBFE2AE0
Content-Type: application/octet-stream;
	name="envy24control.dif"
Content-Transfer-Encoding: base64
Content-Description: envy24control.dif
Content-Disposition: attachment;
	filename="envy24control.dif"

LS0tIGVudnkyNGNvbnRyb2wuaC5vcmkJVGh1IFNlcCAgOSAxMDowMjo1MCAyMDA0CisrKyBlbnZ5
MjRjb250cm9sLmgJVGh1IFNlcCAgOSAwOTo1MDo0MiAyMDA0CkBAIC0zMSw2ICszMSw3IEBACiAj
ZGVmaW5lIElDRTE3MTJfU1VCREVWSUNFX0RFTFRBRElPMjQ5NgkweDEyMTQzMWQ2CiAjZGVmaW5l
IElDRTE3MTJfU1VCREVWSUNFX0RFTFRBNjYJMHgxMjE0MzJkNgogI2RlZmluZSBJQ0UxNzEyX1NV
QkRFVklDRV9ERUxUQTQ0CTB4MTIxNDMzZDYKKyNkZWZpbmUgSUNFMTcxMl9TVUJERVZJQ0VfREVM
VEE0NC0yCTB4MTIxNDMzYTAKICNkZWZpbmUgSUNFMTcxMl9TVUJERVZJQ0VfQVVESU9QSElMRSAg
ICAweDEyMTQzNGQ2CiAjZGVmaW5lIElDRTE3MTJfU1VCREVWSUNFX0RFTFRBNDEwICAgICAgMHgx
MjE0MzhkNgogI2RlZmluZSBJQ0UxNzEyX1NVQkRFVklDRV9ERUxUQTEwMTBMVCAgIDB4MTIxNDNi
ZDYK

------_=_NextPart_001_01C49646.EBFE2AE0--


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click
