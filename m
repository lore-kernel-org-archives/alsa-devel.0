From: "John Utz" <John.Utz@dmxmusic.com>
Subject: patch: ac97_patch.c - enable 'Smart 5.1' on VIA
 vt1617a ac97 codec - Version 2
Date: Wed, 28 Feb 2007 12:52:26 -0800
Message-ID: <F8FB97052F1BEF409F7842E960E49B5AAAF8BC@sea-exch-01.na.corp.dmxmusic.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="----_=_NextPart_001_01C75B7A.5A3C07B5"
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

------_=_NextPart_001_01C75B7A.5A3C07B5
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_002_01C75B7A.5A3C07B5"
Content-Transfer-Encoding: 7bit


------_=_NextPart_002_01C75B7A.5A3C07B5
Content-Type: text/plain;
 charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

Greetings;

This version superseeds the patch presented 070223 (that patch was not =
accepted)

This patch provides a single 8 way enum called 'Smart 5.1 Select' with =
some reasonable names for each enum that allows the user to choose which =
of the 8 possible settings for vt1617a's version of what via calls =
'Smart 5.1'.

Setting this new control to the setting 'Surr LFE/C Mic3' allows 6 =
channel output to be played using the following command:

aplay -Dhw:0,1 chan-id.wav

Note that the existing control Alternate Level to Surround Out may have =
to be disabled to hear the surround output.

Signed off by John Utz

------_=_NextPart_002_01C75B7A.5A3C07B5
Content-Type: text/html;
 charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<HTML>
<HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Diso-8859-1">
<META NAME=3D"Generator" CONTENT=3D"MS Exchange Server version =
6.5.7651.59">
<TITLE>patch: ac97_patch.c - enable 'Smart 5.1' on VIA vt1617a ac97 =
codec - Version 2</TITLE>
</HEAD>
<BODY>
<!-- Converted from text/plain format -->

<P><FONT SIZE=3D2>Greetings;<BR>
<BR>
This version superseeds the patch presented 070223 (that patch was not =
accepted)<BR>
<BR>
This patch provides a single 8 way enum called 'Smart 5.1 Select' with =
some reasonable names for each enum that allows the user to choose which =
of the 8 possible settings for vt1617a's version of what via calls =
'Smart 5.1'.<BR>
<BR>
Setting this new control to the setting 'Surr LFE/C Mic3' allows 6 =
channel output to be played using the following command:<BR>
<BR>
aplay -Dhw:0,1 chan-id.wav<BR>
<BR>
Note that the existing control Alternate Level to Surround Out may have =
to be disabled to hear the surround output.<BR>
<BR>
Signed off by John Utz<BR>
</FONT>
</P>

</BODY>
</HTML>
------_=_NextPart_002_01C75B7A.5A3C07B5--

------_=_NextPart_001_01C75B7A.5A3C07B5
Content-Type: application/octet-stream;
 name=ac97_patch-vt1617a-func.patch
Content-Transfer-Encoding: base64
Content-Description: ac97_patch-vt1617a-func.patch
Content-Disposition: attachment;
 filename=ac97_patch-vt1617a-func.patch

ZGlmZiAtciBiZjE5MzcwMWE4MTIgcGNpL2FjOTcvYWM5N19wYXRjaC5jCi0tLSBhL3BjaS9hYzk3
L2FjOTdfcGF0Y2guYwlNb24gRmViIDI2IDE2OjA3OjQyIDIwMDcgKzAxMDAKKysrIGIvcGNpL2Fj
OTcvYWM5N19wYXRjaC5jCVdlZCBGZWIgMjggMTI6Mzk6MDkgMjAwNyAtMDgwMApAQCAtMzI3Myw4
ICszMjczLDEwOSBAQCBzdGF0aWMgaW50IHBhdGNoX3Z0MTYxNihzdHJ1Y3Qgc25kX2FjOTcgCiAv
KgogICogVlQxNjE3QSBjb2RlYwogICovCisKKy8qCisgKiB1bmZvcnR1bmF0ZWx5LCB0aGUgdnQx
NjE3YSBzdGFzaGVzIHRoZSB0d2lkZGxlcnMgcmVxdWlyZWQgZm9yIG5vb2RpbmcgdGhlIGkvbyBq
YWNrcyBvbiAyIGRpZmZlcmVudCByZWdzLiAqCisgKiB0aGFtZWFucyB0aGF0IHdlIGNhbnQgdXNl
IHRoZSBlYXN5IHdheSBwcm92aWRlZCBieSBBQzk3X0VOVU1fRE9VQkxFKCkgd2UgaGF2ZSB0byB3
cml0ZSBhcmUgb3duIGZ1bmNzLgorICoKKyAqIE5COiB0aGlzIGlzIGFic29sdXRlbHkgYW5kIHV0
dGVybHkgZGlmZmVyZW50IGZyb20gdGhlIHZ0MTYxOC4gZHVubm8gYWJvdXQgdGhlIDE2MTYuCisg
Ki8KKworLyogY29waWVkIGZyb20gYWM5N19zdXJyb3VuZF9qYWNrX21vZGVfaW5mbygpIHdoeSBk
b2VzbnQgZXZlcnlib2R5IGRvIGl0IHRoaXMgd2F5ID8gKi8KK3N0YXRpYyBpbnQgc25kX2FjOTdf
dnQxNjE3YV9zbWFydDUxX2luZm8oc3RydWN0IHNuZF9rY29udHJvbCAqa2NvbnRyb2wsIHN0cnVj
dCBzbmRfY3RsX2VsZW1faW5mbyAqdWluZm8pCit7CisgIC8qIG9yZGVyaW5nIGluIHRoaXMgbGlz
dCByZWZsZWN0cyB2dDE2MTdhIGRvY3MgZm9yIFJlZyAyMCBhbmQgN2EgYW5kIFRhYmxlIDYgdGhh
dCBsYXlzIG91dCB0aGUgbWF0cml4IAorICAgKiBOQiBXUlQgVGFibGU2OiAgU001MSBpcyBTTTUx
RU4gKkFORCogaXQncyBCaXQxNCwgbm90IEJpdDE1IHNvIHRoZSB0YWJsZSBpcyB2ZXJ5IGNvdW50
ZXItaW50dWl0aXZlICovIAorCisgIHN0YXRpYyBjb25zdCBjaGFyKiB0ZXh0c1tdID0geyAiTGlu
ZUluIE1pYzEiLCAiTGluZUluIE1pYzEgTWljMyIsICJTdXJyIExGRS9DIE1pYzMiLCAiTGluZUlu
IExGRS9DIE1pYzMiLAorCQkJCSAiTGluZUluIE1pYzIiLCAiTGluZUluIE1pYzIgTWljMSIsICJT
dXJyIExGRSBNaWMxIiwgIlN1cnIgTEZFIE1pYzEgTWljMiJ9OworICByZXR1cm4gYWM5N19lbnVt
X3RleHRfaW5mbyhrY29udHJvbCwgdWluZm8sIHRleHRzLCA4KTsKK30KKworc3RhdGljIGludCBz
bmRfYWM5N192dDE2MTdhX3NtYXJ0NTFfZ2V0KHN0cnVjdCBzbmRfa2NvbnRyb2wgKmtjb250cm9s
LCBzdHJ1Y3Qgc25kX2N0bF9lbGVtX3ZhbHVlICp1Y29udHJvbCkKK3sKKyAgLyogMCBpcyB0aGUg
ZGVmYXVsdCB2YWx1ZSBmb3IgR1BJTyBTdGF0dXMgUmVnaXN0ZXIgKDB4N2EpIGFuZCBHZW5lcmFs
CisgICAqICBQdXJwb3NlIFJlZ2lzdGVyICgweDIwKSwgc28gaXQncyBhIGdvb2Qgc3RhcnQgKi8K
KworICB1c2hvcnQgdXNTTTUxID0gMCwgdXNNUyA9IDA7ICAKKworICBzdHJ1Y3Qgc25kX2FjOTcg
KnBhYzk3ID0gTlVMTDsKKworICBpZihOVUxMPT1rY29udHJvbCkgcmV0dXJuIC0xOworICBpZihO
VUxMPT11Y29udHJvbCkgcmV0dXJuIC0yOworCisgIHBhYzk3ID0gc25kX2tjb250cm9sX2NoaXAo
a2NvbnRyb2wpOyAvKiBncmFiIGNvZGVjIGhhbmRsZSAqLworCisgIGlmKE5VTEw9PXBhYzk3KSBy
ZXR1cm4gLTM7IC8qIHdoeSBhbSBpIHRoZSBvbmx5IHBlcnNvbiBjaGVja2luZyBmb3IgTlVMTD8g
Ki8KKworICAvKiBncmFiIG91ciBkZXNpcmVjIGJpdHMsIHRoZW4gbWFzaCB0aGVtIHRvZ2V0aGVy
IGluIGEgbWFubmVyCisgICAqIGNvbnNpc3RlbnQgd2l0aCBUYWJsZSA2IG9uIHBhZ2UgMTcgaW4g
dGhlIDE2MTdhIGRvY3MgKi8KKyAKKyAgdXNTTTUxID0gc25kX2FjOTdfcmVhZChwYWM5NywgMHg3
YSkgPj4gMTQ7CisgIHVzTVMgICA9IHNuZF9hYzk3X3JlYWQocGFjOTcsIDB4MjApID4+IDg7Cisg
IAorICB1Y29udHJvbC0+dmFsdWUuZW51bWVyYXRlZC5pdGVtWzBdID0gKHVzU001MSA8PCAxKSAr
IHVzTVM7CisKKyAgcmV0dXJuIDA7Cit9CisKK3N0YXRpYyBpbnQgc25kX2FjOTdfdnQxNjE3YV9z
bWFydDUxX3B1dChzdHJ1Y3Qgc25kX2tjb250cm9sICprY29udHJvbCwgc3RydWN0IHNuZF9jdGxf
ZWxlbV92YWx1ZSAqdWNvbnRyb2wpCit7CisgIC8qIDAgaXMgdGhlIGRlZmF1bHQgdmFsdWUgZm9y
IEdQSU8gU3RhdHVzIFJlZ2lzdGVyICgweDdhKSBhbmQgR2VuZXJhbAorICAgKiAgUHVycG9zZSBS
ZWdpc3RlciAoMHgyMCksIHNvIGl0J3MgYSBnb29kIHN0YXJ0ICovCisKKyAgdXNob3J0IHVzU001
MSA9IDAsIHVzTVMgPSAwLCB1c1JlZyA9IDA7ICAKKworICBzdHJ1Y3Qgc25kX2FjOTcgKnBhYzk3
ID0gTlVMTDsKKworICBpZihOVUxMPT1rY29udHJvbCkgcmV0dXJuIC0xOworICBpZihOVUxMPT11
Y29udHJvbCkgcmV0dXJuIC0yOworCisgIHBhYzk3ID0gc25kX2tjb250cm9sX2NoaXAoa2NvbnRy
b2wpOyAvKiBncmFiIGNvZGVjIGhhbmRsZSAqLworCisgIGlmKE5VTEw9PXBhYzk3KSByZXR1cm4g
LTM7IC8qIHdoeSBhbSBpIHRoZSBvbmx5IHBlcnNvbiBjaGVja2luZyBmb3IgTlVMTD8gKi8KKwor
ICB1c1NNNTEgPSB1Y29udHJvbC0+dmFsdWUuZW51bWVyYXRlZC5pdGVtWzBdID4+IDE7CisgIHVz
TVMgICA9IHVjb250cm9sLT52YWx1ZS5lbnVtZXJhdGVkLml0ZW1bMF0gJiAgMTsKKworICAvKiBw
dXNoIG91ciB2YWx1ZXMgaW50byB0aGUgcmVnaXN0ZXIgLSBjb25zaWRlciB0aGF0IHRoaW5ncyB3
aWxsIGJlIGxlZnQKKyAgICogaW4gYSBmdW5reSBzdGF0ZSBpZiB0aGUgd3JpdGUgZmFpbHMgKi8K
KyAgdXNSZWcgPSBzbmRfYWM5N19yZWFkKHBhYzk3LCAweDdhKTsKKyAgc25kX2FjOTdfd3JpdGVf
Y2FjaGUocGFjOTcsIDB4N2EsICh1c1JlZyAmIDB4M0ZGRikgKyAodXNTTTUxIDw8IDE0KSk7Cisg
IHVzUmVnID0gc25kX2FjOTdfcmVhZChwYWM5NywgMHgyMCk7CisgIHNuZF9hYzk3X3dyaXRlX2Nh
Y2hlKHBhYzk3LCAweDIwLCAodXNSZWcgJiAweEZFRkYpICsgKHVzTVMgICA8PCAgOCkpOworCisg
IHJldHVybiAwOworfQorCisKK3N0YXRpYyBjb25zdCBzdHJ1Y3Qgc25kX2tjb250cm9sX25ldyBz
bmRfYWM5N19jb250cm9sc192dDE2MTdhW10gPSB7CisgIEFDOTdfU0lOR0xFKCJDZW50ZXIvTEZF
IEV4Y2hhbmdlIiwgMHg1YSwgOCwgMSwgMCksCisKKyAgLyoKKyAgICogVGhlc2UgYXJlIHVzZWQg
dG8gZW5hYmxlL2Rpc2FibGUgc3Vycm91bmQgc291bmQgb24gbW90aGVyYm9hcmRzCisgICAqIHRo
YXQgaGF2ZSAzIGJpZGlyZWN0aW9uYWwgYW5hbG9nIGphY2tzCisgICAqLworICB7CisgICAgLmlm
YWNlICAgICAgICAgPSBTTkRSVl9DVExfRUxFTV9JRkFDRV9NSVhFUiwKKyAgICAubmFtZSAgICAg
ICAgICA9ICJTbWFydCA1LjEgU2VsZWN0IiwKKyAgICAuaW5mbyAgICAgICAgICA9IHNuZF9hYzk3
X3Z0MTYxN2Ffc21hcnQ1MV9pbmZvLAorICAgIC5nZXQgICAgICAgICAgID0gc25kX2FjOTdfdnQx
NjE3YV9zbWFydDUxX2dldCwKKyAgICAucHV0ICAgICAgICAgICA9IHNuZF9hYzk3X3Z0MTYxN2Ff
c21hcnQ1MV9wdXQsCisgIH0sCit9OworCisKIHN0YXRpYyBpbnQgcGF0Y2hfdnQxNjE3YShzdHJ1
Y3Qgc25kX2FjOTcgKiBhYzk3KQogeworCWludCBlcnIgPSAwOworCisJLyogd2UgY2hvb3NlIHRv
IG5vdCBmYWlsIG91dCBhdCB0aGlzIHBvaW50LCBidXQgd2UgdGVsbCB0aGUKKwkgICBjYWxsZXIg
d2hlbiB3ZSByZXR1cm4gKi8KKworCWVyciA9IHBhdGNoX2J1aWxkX2NvbnRyb2xzKGFjOTcsICZz
bmRfYWM5N19jb250cm9sc192dDE2MTdhWzBdLAorCQkJCSAgIEFSUkFZX1NJWkUoc25kX2FjOTdf
Y29udHJvbHNfdnQxNjE3YSkpOworCiAJLyogYnJpbmcgYW5hbG9nIHBvd2VyIGNvbnN1bXB0aW9u
IHRvIG5vcm1hbCwgbGlrZSBXaW5YUCBkcml2ZXIKIAkgKiBmb3IgRVBJQSBTUAogCSAqLwpAQCAt
MzI4Miw3ICszMzgzLDggQEAgc3RhdGljIGludCBwYXRjaF92dDE2MTdhKHN0cnVjdCBzbmRfYWM5
NwogCWFjOTctPmV4dF9pZCB8PSBBQzk3X0VJX1NQRElGOwkvKiBmb3JjZSB0aGUgZGV0ZWN0aW9u
IG9mIHNwZGlmICovCiAJYWM5Ny0+cmF0ZXNbQUM5N19SQVRFU19TUERJRl0gPSBTTkRSVl9QQ01f
UkFURV80NDEwMCB8IFNORFJWX1BDTV9SQVRFXzQ4MDAwOwogCWFjOTctPmJ1aWxkX29wcyA9ICZw
YXRjaF92dDE2MTZfb3BzOwotCXJldHVybiAwOworCisJcmV0dXJuIGVycjsKIH0KIAogLyoK

------_=_NextPart_001_01C75B7A.5A3C07B5
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
------_=_NextPart_001_01C75B7A.5A3C07B5
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

------_=_NextPart_001_01C75B7A.5A3C07B5--
