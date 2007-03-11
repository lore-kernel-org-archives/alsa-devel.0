From: Julian Cable <julian_cable@yahoo.com>
Subject: Fw: fine sample rate control for RME hdsp 9632
Date: Sun, 11 Mar 2007 16:54:22 -0700 (PDT)
Message-ID: <786605.74269.qm@web35606.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="0-1699715379-1173657262=:74269"
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
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

--0-1699715379-1173657262=:74269
Content-Type: multipart/alternative; boundary="0-828115078-1173657262=:74269"

--0-828115078-1173657262=:74269
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,=0A=0A  unified diff with header and (Hz) removed as requested.=0A=0AJul=
ian=0A=0A=0A=0A=0A=0A=0A=0A=09=09=0A_______________________________________=
____________________ =0AAll New Yahoo! Mail =96 Tired of unwanted email com=
e-ons? Let our SpamGuard protect you. http://uk.docs.yahoo.com/nowyoucan.ht=
ml
--0-828115078-1173657262=:74269
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

<html><head><style type=3D"text/css"><!-- DIV {margin:0px;} --></style></he=
ad><body><div style=3D"font-family:times new roman, new york, times, serif;=
font-size:12pt"><div style=3D"font-family: times new roman,new york,times,s=
erif; font-size: 12pt;">Hi,<br><div style=3D"font-family: times new roman,n=
ew york,times,serif; font-size: 12pt;"><div style=3D"font-family: times new=
 roman,new york,times,serif; font-size: 12pt;"><div style=3D"font-family: t=
imes new roman,new york,times,serif; font-size: 12pt;"><br>&nbsp; unified d=
iff with header and (Hz) removed as requested.<br><br>Julian<br></div></div=
></div></div></div><br>=0A=09=09<hr size=3D1> =0ANew Yahoo! Mail is the ult=
imate force in competitive emailing. Find out more at the <a href=3D"http:/=
/uk.rd.yahoo.com/mail/uk/taglines/default/championships/games/*http://uk.rd=
.yahoo.com/evt=3D44106/*http://mail.yahoo.net/uk/">Yahoo! Mail Championship=
s</a>. Plus: play games and win prizes.</body></html>
--0-828115078-1173657262=:74269--

--0-1699715379-1173657262=:74269
Content-Type: text/x-diff; name=UNKNOWN_PARAMETER_VALUE
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="=?utf-8?q?hdsp.c.patch?="

W1BBVENIXSBBZGQgc3VwcG9ydCBmb3IgZmluZSB0dW5pbmcgb2Ygc2FtcGxl
IHJhdGUgc3VwcG9ydCB0byBIRFNQIDk2MzIKCkFkZCAiRERTIFNhbXBsZSBS
YXRlIE9mZnNldCIgY29udHJvbC4gQWxsb3dzIHZhbHVlcyBpbiBIeiBmcm9t
IC01MDAwIHRvICs1MDAwLgpUaGUgdmFsdWUgaXMgYWRkZWQgdG8gdGhlIG5v
bWluYWwgc2FtcGxlIHJhdGUgYW5kIHdyaXR0ZW4gdG8gdGhlIEREUyByZWdp
c3Rlci4KClNpZ25lZC1vZmYtYnk6IEp1bGlhbiBDYWJsZSA8anVsaWFuX2Nh
YmxlQHlhaG9vLmNvbT4KCi0tLSBoZHNwLmMJMjAwNy0wMy0wOCAyMDozMToz
OS4wMDAwMDAwMDAgKzAwMDAKKysrIERlc2t0b3AvaGRzcC5jCTIwMDctMDMt
MDkgMjI6MzM6MTMuMDAwMDAwMDAwICswMDAwCkBAIC0yNzUsNiArMjc1LDEx
IEBACiAjZGVmaW5lIEhEU1BfRnJlcXVlbmN5MTI4S0h6ICAgKEhEU1BfUXVh
ZFNwZWVkfEhEU1BfRG91YmxlU3BlZWR8SERTUF9GcmVxdWVuY3kwKQogI2Rl
ZmluZSBIRFNQX0ZyZXF1ZW5jeTE3Nl80S0h6IChIRFNQX1F1YWRTcGVlZHxI
RFNQX0RvdWJsZVNwZWVkfEhEU1BfRnJlcXVlbmN5MSkKICNkZWZpbmUgSERT
UF9GcmVxdWVuY3kxOTJLSHogICAoSERTUF9RdWFkU3BlZWR8SERTUF9Eb3Vi
bGVTcGVlZHxIRFNQX0ZyZXF1ZW5jeTF8SERTUF9GcmVxdWVuY3kwKQorLyog
Uk1FIHNheXMgbiA9IDEwNDg1NzYwMDAwMDAwMCwgYnV0IGluIHRoZSB3aW5k
b3dzIE1BREkgZHJpdmVyLCBJIHNlZToKKwlyZXR1cm4gMTA0ODU3NjAwMDAw
MDAwIC8gcmF0ZTsgLy8gMTAwIE1IegorCXJldHVybiAxMTAxMDA0ODAwMDAw
MDAgLyByYXRlOyAvLyAxMDUgTUh6CisqLwkgICAKKyNkZWZpbmUgRERTX05V
TUVSQVRPUiAxMDQ4NTc2MDAwMDAwMDBVTEw7ICAvKiAgPSAgMl4yMCAqIDEw
XjggKi8KIAogI2RlZmluZSBoZHNwX2VuY29kZV9sYXRlbmN5KHgpICAgICAg
ICgoKHgpPDwxKSAmIEhEU1BfTGF0ZW5jeU1hc2spCiAjZGVmaW5lIGhkc3Bf
ZGVjb2RlX2xhdGVuY3koeCkgICAgICAgKCgoeCkgJiBIRFNQX0xhdGVuY3lN
YXNrKT4+MSkKQEAgLTEwMDEsMTEgKzEwMDYsNyBAQAogCWVsc2UgaWYgKHJh
dGUgPj0gNTYwMDApCiAJCXJhdGUgLz0gMjsKIAotCS8qIFJNRSBzYXlzIG4g
PSAxMDQ4NTc2MDAwMDAwMDAsIGJ1dCBpbiB0aGUgd2luZG93cyBNQURJIGRy
aXZlciwgSSBzZWU6Ci0vLwlyZXR1cm4gMTA0ODU3NjAwMDAwMDAwIC8gcmF0
ZTsgLy8gMTAwIE1IegotCXJldHVybiAxMTAxMDA0ODAwMDAwMDAgLyByYXRl
OyAvLyAxMDUgTUh6Ci0gICAgICAgICovCSAgIAotCW4gPSAxMDQ4NTc2MDAw
MDAwMDBVTEw7ICAvKiAgPSAgMl4yMCAqIDEwXjggKi8KKwluID0gRERTX05V
TUVSQVRPUjsKIAlkaXY2NF8zMigmbiwgcmF0ZSwgJnIpOwogCS8qIG4gc2hv
dWxkIGJlIGxlc3MgdGhhbiAyXjMyIGZvciBiZWluZyB3cml0dGVuIHRvIEZS
RVEgcmVnaXN0ZXIgKi8KIAlzbmRfYXNzZXJ0KChuID4+IDMyKSA9PSAwKTsK
QEAgLTMwODUsMTEgKzMwODYsODMgQEAKIAlyZXR1cm4gMDsKIH0KIAorI2Rl
ZmluZSBIRFNQX0REU19PRkZTRVQoeG5hbWUsIHhpbmRleCkgXAoreyAuaWZh
Y2UgPSBTTkRSVl9DVExfRUxFTV9JRkFDRV9NSVhFUiwgXAorICAubmFtZSA9
IHhuYW1lLCBcCisgIC5pbmRleCA9IHhpbmRleCwgXAorICAuaW5mbyA9IHNu
ZF9oZHNwX2luZm9fZGRzX29mZnNldCwgXAorICAuZ2V0ID0gc25kX2hkc3Bf
Z2V0X2Rkc19vZmZzZXQsIFwKKyAgLnB1dCA9IHNuZF9oZHNwX3B1dF9kZHNf
b2Zmc2V0IFwKK30KKworc3RhdGljIGludCBoZHNwX2Rkc19vZmZzZXQoc3Ry
dWN0IGhkc3AgKmhkc3ApCit7CisJdTY0IG47CisJdTMyIHI7CisJdW5zaWdu
ZWQgaW50IGRkc192YWx1ZSA9IGhkc3AtPmRkc192YWx1ZTsKKwlpbnQgc3lz
dGVtX3NhbXBsZV9yYXRlID0gaGRzcC0+c3lzdGVtX3NhbXBsZV9yYXRlOwor
CisJbiA9IEREU19OVU1FUkFUT1I7CisJLyoKKwkgKiBkZHNfdmFsdWUgPSBu
IC8gcmF0ZQorCSAqIHJhdGUgPSBuIC8gZGRzX3ZhbHVlCisJICovCisJZGl2
NjRfMzIoJm4sIGRkc192YWx1ZSwgJnIpOworCWlmIChzeXN0ZW1fc2FtcGxl
X3JhdGUgPj0gMTEyMDAwKQorCQluICo9IDQ7CisJZWxzZSBpZiAoc3lzdGVt
X3NhbXBsZV9yYXRlID49IDU2MDAwKQorCQluICo9IDI7CisJcmV0dXJuICgo
aW50KW4pIC0gc3lzdGVtX3NhbXBsZV9yYXRlOworfQorCitzdGF0aWMgaW50
IGhkc3Bfc2V0X2Rkc19vZmZzZXQoc3RydWN0IGhkc3AgKmhkc3AsIGludCBv
ZmZzZXRfaHopCit7CisJaW50IHJhdGUgPSBoZHNwLT5zeXN0ZW1fc2FtcGxl
X3JhdGUgKyBvZmZzZXRfaHo7CisJaGRzcF9zZXRfZGRzX3ZhbHVlKGhkc3As
IHJhdGUpOworCXJldHVybiAwOworfQorCitzdGF0aWMgaW50IHNuZF9oZHNw
X2luZm9fZGRzX29mZnNldChzdHJ1Y3Qgc25kX2tjb250cm9sICprY29udHJv
bCwgc3RydWN0IHNuZF9jdGxfZWxlbV9pbmZvICp1aW5mbykKK3sKKwl1aW5m
by0+dHlwZSA9IFNORFJWX0NUTF9FTEVNX1RZUEVfSU5URUdFUjsKKwl1aW5m
by0+Y291bnQgPSAxOworCXVpbmZvLT52YWx1ZS5pbnRlZ2VyLm1pbiA9IC01
MDAwOworCXVpbmZvLT52YWx1ZS5pbnRlZ2VyLm1heCA9IDUwMDA7CisJcmV0
dXJuIDA7Cit9CisKK3N0YXRpYyBpbnQgc25kX2hkc3BfZ2V0X2Rkc19vZmZz
ZXQoc3RydWN0IHNuZF9rY29udHJvbCAqa2NvbnRyb2wsIHN0cnVjdCBzbmRf
Y3RsX2VsZW1fdmFsdWUgKnVjb250cm9sKQoreworCXN0cnVjdCBoZHNwICpo
ZHNwID0gc25kX2tjb250cm9sX2NoaXAoa2NvbnRyb2wpOworCQorCXVjb250
cm9sLT52YWx1ZS5lbnVtZXJhdGVkLml0ZW1bMF0gPSBoZHNwX2Rkc19vZmZz
ZXQoaGRzcCk7CisJcmV0dXJuIDA7Cit9CisKK3N0YXRpYyBpbnQgc25kX2hk
c3BfcHV0X2Rkc19vZmZzZXQoc3RydWN0IHNuZF9rY29udHJvbCAqa2NvbnRy
b2wsIHN0cnVjdCBzbmRfY3RsX2VsZW1fdmFsdWUgKnVjb250cm9sKQorewor
CXN0cnVjdCBoZHNwICpoZHNwID0gc25kX2tjb250cm9sX2NoaXAoa2NvbnRy
b2wpOworCWludCBjaGFuZ2U7CisJaW50IHZhbDsKKwkKKwlpZiAoIXNuZF9o
ZHNwX3VzZV9pc19leGNsdXNpdmUoaGRzcCkpCisJCXJldHVybiAtRUJVU1k7
CisJdmFsID0gdWNvbnRyb2wtPnZhbHVlLmVudW1lcmF0ZWQuaXRlbVswXTsK
KwlzcGluX2xvY2tfaXJxKCZoZHNwLT5sb2NrKTsKKwlpZiAodmFsICE9IGhk
c3BfZGRzX29mZnNldChoZHNwKSkKKwkJY2hhbmdlID0gKGhkc3Bfc2V0X2Rk
c19vZmZzZXQoaGRzcCwgdmFsKSA9PSAwKSA/IDEgOiAwOworCWVsc2UKKwkJ
Y2hhbmdlID0gMDsKKwlzcGluX3VubG9ja19pcnEoJmhkc3AtPmxvY2spOwor
CXJldHVybiBjaGFuZ2U7Cit9CisKIHN0YXRpYyBzdHJ1Y3Qgc25kX2tjb250
cm9sX25ldyBzbmRfaGRzcF85NjMyX2NvbnRyb2xzW10gPSB7CiBIRFNQX0RB
X0dBSU4oIkRBIEdhaW4iLCAwKSwKIEhEU1BfQURfR0FJTigiQUQgR2FpbiIs
IDApLAogSERTUF9QSE9ORV9HQUlOKCJQaG9uZXMgR2FpbiIsIDApLAotSERT
UF9YTFJfQlJFQUtPVVRfQ0FCTEUoIlhMUiBCcmVha291dCBDYWJsZSIsIDAp
CitIRFNQX1hMUl9CUkVBS09VVF9DQUJMRSgiWExSIEJyZWFrb3V0IENhYmxl
IiwgMCksCitIRFNQX0REU19PRkZTRVQoIkREUyBTYW1wbGUgUmF0ZSBPZmZz
ZXQiLCAwKQogfTsKIAogc3RhdGljIHN0cnVjdCBzbmRfa2NvbnRyb2xfbmV3
IHNuZF9oZHNwX2NvbnRyb2xzW10gPSB7Cg==

--0-1699715379-1173657262=:74269
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--0-1699715379-1173657262=:74269
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--0-1699715379-1173657262=:74269--
