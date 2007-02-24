From: "John Utz" <John.Utz@dmxmusic.com>
Subject: Patch: alsa-driver/hgcompile - check for a user set
 ALSAKERNELDIR first then set default
Date: Fri, 23 Feb 2007 16:07:18 -0800
Message-ID: <F8FB97052F1BEF409F7842E960E49B5AAAF8B3@sea-exch-01.na.corp.dmxmusic.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="----_=_NextPart_001_01C757A7.F2AF0D22"
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

------_=_NextPart_001_01C757A7.F2AF0D22
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_002_01C757A7.F2AF0D22"
Content-Transfer-Encoding: 7bit


------_=_NextPart_002_01C757A7.F2AF0D22
Content-Type: text/plain;
 charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

This patch simplifies the alsa-kernel discovery logic and provides =
better error reporting in the event of not finding $ALSAKERNELDIR/last.c

Signed off by John L. Utz III john.utz@dmxmusic.com
(tho why my uneducated opinion matters is beyond me)

------_=_NextPart_002_01C757A7.F2AF0D22
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
<TITLE>Patch: alsa-driver/hgcompile - check for a user set ALSAKERNELDIR =
first then set default</TITLE>
</HEAD>
<BODY>
<!-- Converted from text/plain format -->

<P><FONT SIZE=3D2>This patch simplifies the alsa-kernel discovery logic =
and provides better error reporting in the event of not finding =
$ALSAKERNELDIR/last.c<BR>
<BR>
Signed off by John L. Utz III john.utz@dmxmusic.com<BR>
(tho why my uneducated opinion matters is beyond me)<BR>
</FONT>
</P>

</BODY>
</HTML>
------_=_NextPart_002_01C757A7.F2AF0D22--

------_=_NextPart_001_01C757A7.F2AF0D22
Content-Type: application/octet-stream;
 name=hgcompile-ALSAKERNELDIR.patch
Content-Transfer-Encoding: base64
Content-Description: hgcompile-ALSAKERNELDIR.patch
Content-Disposition: attachment;
 filename=hgcompile-ALSAKERNELDIR.patch

ZGlmZiAtciA2MmMwZTM5ODkyNDEgaGdjb21waWxlCi0tLSBhL2hnY29tcGlsZQlUaHUgRmViIDIy
IDEzOjI0OjE4IDIwMDcgKzAxMDAKKysrIGIvaGdjb21waWxlCUZyaSBGZWIgMjMgMTU6NTQ6MjQg
MjAwNyAtMDgwMApAQCAtMjcsMTcgKzI3LDI2IEBAIGZpCiAjICBjZCAuLgogI2ZpCiAKLSMgY2hl
Y2sgZm9yIGFsc2Eta2VybmVsIGRpcmVjdG9yeQotaWYgWyAtZCBhbHNhLWtlcm5lbCAtYSAtZiBh
bHNhLWtlcm5lbC9sYXN0LmMgXTsgdGhlbgotICBBTFNBS0VSTkVMRElSPSJhbHNhLWtlcm5lbCIK
LWVsc2UKLSAgdGVzdCAteiAkQUxTQUtFUk5FTERJUiAmJiBBTFNBS0VSTkVMRElSPS4uL2Fsc2Et
a2VybmVsCi0gIGlmIFsgISAtZCAkQUxTQUtFUk5FTERJUiAtbyAhIC1mICRBTFNBS0VSTkVMRElS
L2xhc3QuYyBdOyB0aGVuCi0gICAgZWNobyAiTm8gYWxzYS1rZXJuZWwgaXMgZm91bmQuIgotICAg
IGVjaG8gIlBsZWFzZSBzcGVjaWZ5IHRoZSBjb3JyZWN0IGxvY2F0aW9uIHZpYSBBTFNBS0VSTkVM
RElSIGVudmlyb25tZW50IHZhcmlhYmxlLiIKKyMgY2hlY2sgZm9yIGNhbGxlciBzZXQgYWxzYS1r
ZXJuZWwgZGlyZWN0b3J5LCBpZiBlbXB0eSBzZXQgdG8gZGVmYXVsdAorCitpZiBbIC16ICRBTFNB
S0VSTkVMRElSIF07IHRoZW4KKyAgICBBTFNBS0VSTkVMRElSPS4uL2Fsc2Eta2VybmVsCitmaQor
CitBTFNBQ0hLRklMRT0kQUxTQUtFUk5FTERJUi9sYXN0LmMKKworZWNobyAiQUxTQSBLZXJuZWwg
RGlyZWN0b3J5IGlzOiAkQUxTQUtFUk5FTERJUiwgY2hlY2tpbmcgZm9yIGNoZWNrZmlsZTogJEFM
U0FDSEtGSUxFIgorCitpZiBbICEgLWYgJEFMU0FLQ0hLRklMRSBdCit0aGVuCisgICAgZWNobwor
ICAgIGVjaG8gIkVycm9yISBhbHNhLWtlcm5lbCBzb3VyY2UgZmlsZSAkQUxTQUNIS0ZJTEUgaXMg
bm90IGZvdW5kLiBBbHNhIGNvbXBpbGF0aW9uIHdpbGwgYmUgaW1wb3NzaWJsZS4iCisgICAgZWNo
bworICAgIGVjaG8gIlBsZWFzZSBtYWtlIHN1cmUgdGhhdCB5b3VyIGhhdmUgY29ycmVjdGx5IHBs
YWNlZCB0aGUgLi4vYWxzYS1rZXJuZWwgZGlyZWN0b3J5IgorICAgIGVjaG8gIm9yIHNwZWNpZnkg
dGhlIGNvcnJlY3QgbG9jYXRpb24gZm9yIHlvdXIgZGV2ZWxvcG1lbnQga2VybmVsIGRpcmVjdG9y
eSB2aWEgQUxTQUtFUk5FTERJUiBlbnZpcm9ubWVudCB2YXJpYWJsZS4iCiAgICAgZXhpdCAxCi0g
IGZpCiBmaQorCiBtYWtlIEFMU0FLRVJORUxESVI9IiRBTFNBS0VSTkVMRElSIiBhbGwtZGVwcwog
YWNsb2NhbCAkQUNMT0NBTF9GTEFHUwogYXV0b2NvbmYK

------_=_NextPart_001_01C757A7.F2AF0D22
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
------_=_NextPart_001_01C757A7.F2AF0D22
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

------_=_NextPart_001_01C757A7.F2AF0D22--
