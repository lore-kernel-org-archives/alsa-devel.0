From: "John Utz" <John.Utz@dmx.com>
Subject: Patch actually attached! RE: [PATCH] ac97_patch.c -
 enable 'Smart 5.1' on VIA vt1617a ac97 codec - Version 3
Date: Fri, 9 Mar 2007 13:42:00 -0800
Message-ID: <F8FB97052F1BEF409F7842E960E49B5AAAF8C9@sea-exch-01.na.corp.dmxmusic.com>
References: <F8FB97052F1BEF409F7842E960E49B5AAAF8C8@sea-exch-01.na.corp.dmxmusic.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="----_=_NextPart_001_01C76293.F1657969"
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
To: John Utz <John.Utz@dmx.com>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.

------_=_NextPart_001_01C76293.F1657969
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_002_01C76293.F1657969"
Content-Transfer-Encoding: 7bit


------_=_NextPart_002_01C76293.F1657969
Content-Type: text/plain;
 charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

gyahh! i forgot the patch!

go too involved in formatting the mail :-)

-----Original Message-----
From: alsa-devel-bounces@lists.sourceforge.net on behalf of John Utz
Sent: Fri 3/9/2007 12:55 PM
To: alsa-devel@lists.sourceforge.net
Subject: [Alsa-devel] [PATCH] ac97_patch.c - enable 'Smart 5.1' on VIA =
vt1617a ac97 codec - Version 3
=20

This version superseeds the patches presented 070223 and 070228

Setting this new control to the setting 'Surr LFE/C Mic3' allows 6 =
channel output to be played using the following command:

aplay -Dhw:0,1 chan-id.wav

Note that the existing control Alternate Level to Surround Out may have =
to be disabled to hear the surround output.

Changelog Entry

=3D=3D=3D=3D

[PATCH] ALSA: Smart 5.1 for VIA 1617a codec

This patch provides a single 8 way enum called 'Smart 5.1 Select' with =
some reasonable names for each enum that allows the user to choose which =
of the 8 possible settings for vt1617a's version of what via calls =
'Smart 5.1'.

Signed-off-by: John Utz <john.utz@dmx.com>



------_=_NextPart_002_01C76293.F1657969
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
<TITLE>Patch actually attached! RE: [Alsa-devel] [PATCH] ac97_patch.c - =
enable 'Smart 5.1' on VIA vt1617a ac97 codec - Version 3</TITLE>
</HEAD>
<BODY>
<!-- Converted from text/plain format -->

<P><FONT SIZE=3D2>gyahh! i forgot the patch!<BR>
<BR>
go too involved in formatting the mail :-)<BR>
<BR>
-----Original Message-----<BR>
From: alsa-devel-bounces@lists.sourceforge.net on behalf of John Utz<BR>
Sent: Fri 3/9/2007 12:55 PM<BR>
To: alsa-devel@lists.sourceforge.net<BR>
Subject: [Alsa-devel] [PATCH] ac97_patch.c - enable 'Smart 5.1' on VIA =
vt1617a ac97 codec - Version 3<BR>
<BR>
<BR>
This version superseeds the patches presented 070223 and 070228<BR>
<BR>
Setting this new control to the setting 'Surr LFE/C Mic3' allows 6 =
channel output to be played using the following command:<BR>
<BR>
aplay -Dhw:0,1 chan-id.wav<BR>
<BR>
Note that the existing control Alternate Level to Surround Out may have =
to be disabled to hear the surround output.<BR>
<BR>
Changelog Entry<BR>
<BR>
=3D=3D=3D=3D<BR>
<BR>
[PATCH] ALSA: Smart 5.1 for VIA 1617a codec<BR>
<BR>
This patch provides a single 8 way enum called 'Smart 5.1 Select' with =
some reasonable names for each enum that allows the user to choose which =
of the 8 possible settings for vt1617a's version of what via calls =
'Smart 5.1'.<BR>
<BR>
Signed-off-by: John Utz &lt;john.utz@dmx.com&gt;<BR>
<BR>
<BR>
</FONT>
</P>

</BODY>
</HTML>
------_=_NextPart_002_01C76293.F1657969--

------_=_NextPart_001_01C76293.F1657969
Content-Type: application/octet-stream;
 name=ac97_patch-vt1617a-func.patch3
Content-Transfer-Encoding: base64
Content-Description: ac97_patch-vt1617a-func.patch3
Content-Disposition: attachment;
 filename=ac97_patch-vt1617a-func.patch3

ZGlmZiAtciBkYjIxOTc3YTQwN2MgcGNpL2FjOTcvYWM5N19wYXRjaC5jCi0tLSBhL3BjaS9hYzk3
L2FjOTdfcGF0Y2guYwlGcmkgTWFyIDA5IDE2OjE1OjA2IDIwMDcgKzAxMDAKKysrIGIvcGNpL2Fj
OTcvYWM5N19wYXRjaC5jCUZyaSBNYXIgMDkgMTE6NTk6NTAgMjAwNyAtMDgwMApAQCAtMzI3Niwx
NiArMzI3NiwxMTEgQEAgc3RhdGljIGludCBwYXRjaF92dDE2MTYoc3RydWN0IHNuZF9hYzk3IAog
LyoKICAqIFZUMTYxN0EgY29kZWMKICAqLwotc3RhdGljIGludCBwYXRjaF92dDE2MTdhKHN0cnVj
dCBzbmRfYWM5NyAqIGFjOTcpCi17Ci0JLyogYnJpbmcgYW5hbG9nIHBvd2VyIGNvbnN1bXB0aW9u
IHRvIG5vcm1hbCwgbGlrZSBXaW5YUCBkcml2ZXIKLQkgKiBmb3IgRVBJQSBTUAorCisvKgorICog
dW5mb3J0dW5hdGVseSwgdGhlIHZ0MTYxN2Egc3Rhc2hlcyB0aGUgdHdpZGRsZXJzIHJlcXVpcmVk
IGZvcgorICogbm9vZGluZyB0aGUgaS9vIGphY2tzIG9uIDIgZGlmZmVyZW50IHJlZ3MuICogdGhh
bWVhbnMgdGhhdCB3ZSBjYW50CisgKiB1c2UgdGhlIGVhc3kgd2F5IHByb3ZpZGVkIGJ5IEFDOTdf
RU5VTV9ET1VCTEUoKSB3ZSBoYXZlIHRvIHdyaXRlCisgKiBhcmUgb3duIGZ1bmNzLgorICoKKyAq
IE5COiB0aGlzIGlzIGFic29sdXRlbHkgYW5kIHV0dGVybHkgZGlmZmVyZW50IGZyb20gdGhlIHZ0
MTYxOC4gZHVubm8KKyAqIGFib3V0IHRoZSAxNjE2LgorICovCisKKy8qIGNvcGllZCBmcm9tIGFj
OTdfc3Vycm91bmRfamFja19tb2RlX2luZm8oKSAqLworc3RhdGljIGludCBzbmRfYWM5N192dDE2
MTdhX3NtYXJ0NTFfaW5mbyhzdHJ1Y3Qgc25kX2tjb250cm9sICprY29udHJvbCwKKwkJCQkJIHN0
cnVjdCBzbmRfY3RsX2VsZW1faW5mbyAqdWluZm8pCit7CisJLyogb3JkZXJpbmcgaW4gdGhpcyBs
aXN0IHJlZmxlY3RzIHZ0MTYxN2EgZG9jcyBmb3IgUmVnIDIwIGFuZAorCSAqIDdhIGFuZCBUYWJs
ZSA2IHRoYXQgbGF5cyBvdXQgdGhlIG1hdHJpeCBOQiBXUlQgVGFibGU2OiBTTTUxCisJICogaXMg
U001MUVOICpBTkQqIGl0J3MgQml0MTQsIG5vdCBCaXQxNSBzbyB0aGUgdGFibGUgaXMgdmVyeQor
CSAqIGNvdW50ZXItaW50dWl0aXZlICovIAorCisJc3RhdGljIGNvbnN0IGNoYXIqIHRleHRzW10g
PSB7ICJMaW5lSW4gTWljMSIsICJMaW5lSW4gTWljMSBNaWMzIiwKKwkJCQkgICAgICAgIlN1cnIg
TEZFL0MgTWljMyIsICJMaW5lSW4gTEZFL0MgTWljMyIsCisJCQkJICAgICAgICJMaW5lSW4gTWlj
MiIsICJMaW5lSW4gTWljMiBNaWMxIiwKKwkJCQkgICAgICAgIlN1cnIgTEZFIE1pYzEiLCAiU3Vy
ciBMRkUgTWljMSBNaWMyIn07CisJcmV0dXJuIGFjOTdfZW51bV90ZXh0X2luZm8oa2NvbnRyb2ws
IHVpbmZvLCB0ZXh0cywgOCk7Cit9CisKK3N0YXRpYyBpbnQgc25kX2FjOTdfdnQxNjE3YV9zbWFy
dDUxX2dldChzdHJ1Y3Qgc25kX2tjb250cm9sICprY29udHJvbCwKKwkJCQkJc3RydWN0IHNuZF9j
dGxfZWxlbV92YWx1ZSAqdWNvbnRyb2wpCit7CisJdXNob3J0IHVzU001MSwgdXNNUzsgIAorCisJ
c3RydWN0IHNuZF9hYzk3ICpwYWM5NzsKKwkKKwlwYWM5NyA9IHNuZF9rY29udHJvbF9jaGlwKGtj
b250cm9sKTsgLyogZ3JhYiBjb2RlYyBoYW5kbGUgKi8KKworCS8qIGdyYWIgb3VyIGRlc2lyZWMg
Yml0cywgdGhlbiBtYXNoIHRoZW0gdG9nZXRoZXIgaW4gYSBtYW5uZXIKKwkgKiBjb25zaXN0ZW50
IHdpdGggVGFibGUgNiBvbiBwYWdlIDE3IGluIHRoZSAxNjE3YSBkb2NzICovCisgCisJdXNTTTUx
ID0gc25kX2FjOTdfcmVhZChwYWM5NywgMHg3YSkgPj4gMTQ7CisJdXNNUyAgID0gc25kX2FjOTdf
cmVhZChwYWM5NywgMHgyMCkgPj4gODsKKyAgCisJdWNvbnRyb2wtPnZhbHVlLmVudW1lcmF0ZWQu
aXRlbVswXSA9ICh1c1NNNTEgPDwgMSkgKyB1c01TOworCisJcmV0dXJuIDA7Cit9CisKK3N0YXRp
YyBpbnQgc25kX2FjOTdfdnQxNjE3YV9zbWFydDUxX3B1dChzdHJ1Y3Qgc25kX2tjb250cm9sICpr
Y29udHJvbCwKKwkJCQkJc3RydWN0IHNuZF9jdGxfZWxlbV92YWx1ZSAqdWNvbnRyb2wpCit7CisJ
dXNob3J0IHVzU001MSwgdXNNUywgdXNSZWc7ICAKKworCXN0cnVjdCBzbmRfYWM5NyAqcGFjOTc7
CisKKwlwYWM5NyA9IHNuZF9rY29udHJvbF9jaGlwKGtjb250cm9sKTsgLyogZ3JhYiBjb2RlYyBo
YW5kbGUgKi8KKworCXVzU001MSA9IHVjb250cm9sLT52YWx1ZS5lbnVtZXJhdGVkLml0ZW1bMF0g
Pj4gMTsKKwl1c01TICAgPSB1Y29udHJvbC0+dmFsdWUuZW51bWVyYXRlZC5pdGVtWzBdICYgIDE7
CisKKwkvKiBwdXNoIG91ciB2YWx1ZXMgaW50byB0aGUgcmVnaXN0ZXIgLSBjb25zaWRlciB0aGF0
IHRoaW5ncyB3aWxsIGJlIGxlZnQKKwkgKiBpbiBhIGZ1bmt5IHN0YXRlIGlmIHRoZSB3cml0ZSBm
YWlscyAqLworCisJdXNSZWcgPSBzbmRfYWM5N19yZWFkKHBhYzk3LCAweDdhKTsKKwlzbmRfYWM5
N193cml0ZV9jYWNoZShwYWM5NywgMHg3YSwgKHVzUmVnICYgMHgzRkZGKSArICh1c1NNNTEgPDwg
MTQpKTsKKwl1c1JlZyA9IHNuZF9hYzk3X3JlYWQocGFjOTcsIDB4MjApOworCXNuZF9hYzk3X3dy
aXRlX2NhY2hlKHBhYzk3LCAweDIwLCAodXNSZWcgJiAweEZFRkYpICsgKHVzTVMgICA8PCAgOCkp
OworCisJcmV0dXJuIDA7Cit9CisKK3N0YXRpYyBjb25zdCBzdHJ1Y3Qgc25kX2tjb250cm9sX25l
dyBzbmRfYWM5N19jb250cm9sc192dDE2MTdhW10gPSB7CisKKwlBQzk3X1NJTkdMRSgiQ2VudGVy
L0xGRSBFeGNoYW5nZSIsIDB4NWEsIDgsIDEsIDApLAorCS8qCisJICogVGhlc2UgYXJlIHVzZWQg
dG8gZW5hYmxlL2Rpc2FibGUgc3Vycm91bmQgc291bmQgb24gbW90aGVyYm9hcmRzCisJICogdGhh
dCBoYXZlIDMgYmlkaXJlY3Rpb25hbCBhbmFsb2cgamFja3MKKwkgKi8KKwl7CisJCS5pZmFjZSAg
ICAgICAgID0gU05EUlZfQ1RMX0VMRU1fSUZBQ0VfTUlYRVIsCisJCS5uYW1lICAgICAgICAgID0g
IlNtYXJ0IDUuMSBTZWxlY3QiLAorCQkuaW5mbyAgICAgICAgICA9IHNuZF9hYzk3X3Z0MTYxN2Ff
c21hcnQ1MV9pbmZvLAorCQkuZ2V0ICAgICAgICAgICA9IHNuZF9hYzk3X3Z0MTYxN2Ffc21hcnQ1
MV9nZXQsCisJCS5wdXQgICAgICAgICAgID0gc25kX2FjOTdfdnQxNjE3YV9zbWFydDUxX3B1dCwK
Kwl9LAorfTsKKworaW50IHBhdGNoX3Z0MTYxN2Eoc3RydWN0IHNuZF9hYzk3ICogYWM5NykKK3sK
KwlpbnQgZXJyID0gMDsKKworCS8qIHdlIGNob29zZSB0byBub3QgZmFpbCBvdXQgYXQgdGhpcyBw
b2ludCwgYnV0IHdlIHRlbGwgdGhlCisJICAgY2FsbGVyIHdoZW4gd2UgcmV0dXJuICovCisKKwll
cnIgPSBwYXRjaF9idWlsZF9jb250cm9scyhhYzk3LCAmc25kX2FjOTdfY29udHJvbHNfdnQxNjE3
YVswXSwKKwkJCQkgICBBUlJBWV9TSVpFKHNuZF9hYzk3X2NvbnRyb2xzX3Z0MTYxN2EpKTsKKwor
CS8qIGJyaW5nIGFuYWxvZyBwb3dlciBjb25zdW1wdGlvbiB0byBub3JtYWwgYnkgdHVybmluZyBv
ZmYgdGhlCisJICogaGVhZHBob25lIGFtcGxpZmllciwgbGlrZSBXaW5YUCBkcml2ZXIgZm9yIEVQ
SUEgU1AKIAkgKi8KIAlzbmRfYWM5N193cml0ZV9jYWNoZShhYzk3LCAweDVjLCAweDIwKTsKIAlh
Yzk3LT5leHRfaWQgfD0gQUM5N19FSV9TUERJRjsJLyogZm9yY2UgdGhlIGRldGVjdGlvbiBvZiBz
cGRpZiAqLwogCWFjOTctPnJhdGVzW0FDOTdfUkFURVNfU1BESUZdID0gU05EUlZfUENNX1JBVEVf
NDQxMDAgfCBTTkRSVl9QQ01fUkFURV80ODAwMDsKIAlhYzk3LT5idWlsZF9vcHMgPSAmcGF0Y2hf
dnQxNjE2X29wczsKLQlyZXR1cm4gMDsKKworCXJldHVybiBlcnI7CiB9CiAKIC8qCg==

------_=_NextPart_001_01C76293.F1657969
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
------_=_NextPart_001_01C76293.F1657969
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

------_=_NextPart_001_01C76293.F1657969--
