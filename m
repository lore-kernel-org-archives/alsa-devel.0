From: Julian Cable <julian_cable@yahoo.com>
Subject: fine sample rate control for RME hdsp 9632
Date: Thu, 8 Mar 2007 12:33:56 -0800 (PST)
Message-ID: <557316.48905.qm@web35603.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="0-595376096-1173386036=:48905"
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

--0-595376096-1173386036=:48905
Content-Type: multipart/alternative; boundary="0-1041839256-1173386036=:48905"

--0-1041839256-1173386036=:48905
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,=0A=0A  I've added a control to the hdsp driver to control the dds regis=
ter on the 9632. This allows fine tuning of the sample rate as is supported=
 by the windows driver. The feature is implemented as an offset to the curr=
ent sample rate, since most of the code assumes only discrete sample rates =
are supported. So the sample rate will always be selected and indicated as =
one of the standard supported sample rates but may actually be a few % high=
er or lower. It seems to work very well.=0A=0AOne possible application is t=
o discipline the sample rate from the system clock or a GPS receiver to pro=
vide a long term accurate precise frequency source without expensive refere=
nce clocks.=0A=0AThe patch is against alsa-driver-1.0.14rc3=0A=0AJulian=0A=
=0A  =0A=0A=0A=0A=0A=09=09=0A______________________________________________=
_____________ =0AInbox full of unwanted email? Get leading protection and 1=
GB storage with All New Yahoo! Mail. http://uk.docs.yahoo.com/nowyoucan.htm=
l
--0-1041839256-1173386036=:48905
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

<html><head><style type=3D"text/css"><!-- DIV {margin:0px;} --></style></he=
ad><body><div style=3D"font-family:times new roman, new york, times, serif;=
font-size:12pt"><div>Hi,<br><br>&nbsp; I've added a control to the hdsp dri=
ver to control the dds register on the 9632. This allows fine tuning of the=
 sample rate as is supported by the windows driver. The feature is implemen=
ted as an offset to the current sample rate, since most of the code assumes=
 only discrete sample rates are supported. So the sample rate will always b=
e selected and indicated as one of the standard supported sample rates but =
may actually be a few % higher or lower. It seems to work very well.<br><br=
>One possible application is to discipline the sample rate from the system =
clock or a GPS receiver to provide a long term accurate precise frequency s=
ource without expensive reference clocks.<br><br>The patch is against alsa-=
driver-1.0.14rc3<br><br>Julian<br><br>&nbsp; <br></div></div><br>=0A=09=09<=
hr size=3D1> =0ANow you can <a href=3D"http://us.rd.yahoo.com/mail/uk/tagli=
nes/default/nowyoucan/reading_pane/*http://us.rd.yahoo.com/evt=3D40565/*htt=
p://uk.docs.yahoo.com/nowyoucan.html">scan emails quickly with a reading pa=
ne</a>. Get the new <a href=3D"http://us.rd.yahoo.com/mail/uk/taglines/defa=
ult/nowyoucan/reading_pane/*http://us.rd.yahoo.com/evt=3D40565/*http://uk.d=
ocs.yahoo.com/nowyoucan.html">Yahoo! Mail</a>.</body></html>
--0-1041839256-1173386036=:48905--

--0-595376096-1173386036=:48905
Content-Type: text/x-diff; name="=?utf-8?q?hdsp.c.patch?="
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="=?utf-8?q?hdsp.c.patch?="

Mjc3YTI3OCwyODIKPiAvKiBSTUUgc2F5cyBuID0gMTA0ODU3NjAwMDAwMDAw
LCBidXQgaW4gdGhlIHdpbmRvd3MgTUFESSBkcml2ZXIsIEkgc2VlOgo+IAly
ZXR1cm4gMTA0ODU3NjAwMDAwMDAwIC8gcmF0ZTsgLy8gMTAwIE1Iego+IAly
ZXR1cm4gMTEwMTAwNDgwMDAwMDAwIC8gcmF0ZTsgLy8gMTA1IE1Iego+ICov
CSAgIAo+ICNkZWZpbmUgRERTX05VTUVSQVRPUiAxMDQ4NTc2MDAwMDAwMDBV
TEw7ICAvKiAgPSAgMl4yMCAqIDEwXjggKi8KMTAwNCwxMDA4YzEwMDkKPCAJ
LyogUk1FIHNheXMgbiA9IDEwNDg1NzYwMDAwMDAwMCwgYnV0IGluIHRoZSB3
aW5kb3dzIE1BREkgZHJpdmVyLCBJIHNlZToKPCAvLwlyZXR1cm4gMTA0ODU3
NjAwMDAwMDAwIC8gcmF0ZTsgLy8gMTAwIE1Iego8IAlyZXR1cm4gMTEwMTAw
NDgwMDAwMDAwIC8gcmF0ZTsgLy8gMTA1IE1Iego8ICAgICAgICAgKi8JICAg
CjwgCW4gPSAxMDQ4NTc2MDAwMDAwMDBVTEw7ICAvKiAgPSAgMl4yMCAqIDEw
XjggKi8KLS0tCj4gCW4gPSBERFNfTlVNRVJBVE9SOwozMDg3YTMwODksMzE1
OQo+ICNkZWZpbmUgSERTUF9ERFNfT0ZGU0VUKHhuYW1lLCB4aW5kZXgpIFwK
PiB7IC5pZmFjZSA9IFNORFJWX0NUTF9FTEVNX0lGQUNFX01JWEVSLCBcCj4g
ICAubmFtZSA9IHhuYW1lLCBcCj4gICAuaW5kZXggPSB4aW5kZXgsIFwKPiAg
IC5pbmZvID0gc25kX2hkc3BfaW5mb19kZHNfb2Zmc2V0LCBcCj4gICAuZ2V0
ID0gc25kX2hkc3BfZ2V0X2Rkc19vZmZzZXQsIFwKPiAgIC5wdXQgPSBzbmRf
aGRzcF9wdXRfZGRzX29mZnNldCBcCj4gfQo+IAo+IHN0YXRpYyBpbnQgaGRz
cF9kZHNfb2Zmc2V0KHN0cnVjdCBoZHNwICpoZHNwKQo+IHsKPiAJdTY0IG47
Cj4gCXUzMiByOwo+IAl1bnNpZ25lZCBpbnQgZGRzX3ZhbHVlID0gaGRzcC0+
ZGRzX3ZhbHVlOwo+IAlpbnQgc3lzdGVtX3NhbXBsZV9yYXRlID0gaGRzcC0+
c3lzdGVtX3NhbXBsZV9yYXRlOwo+IAo+IAluID0gRERTX05VTUVSQVRPUjsK
PiAJLyoKPiAJICogZGRzX3ZhbHVlID0gbiAvIHJhdGUKPiAJICogcmF0ZSA9
IG4gLyBkZHNfdmFsdWUKPiAJICovCj4gCWRpdjY0XzMyKCZuLCBkZHNfdmFs
dWUsICZyKTsKPiAJaWYgKHN5c3RlbV9zYW1wbGVfcmF0ZSA+PSAxMTIwMDAp
Cj4gCQluICo9IDQ7Cj4gCWVsc2UgaWYgKHN5c3RlbV9zYW1wbGVfcmF0ZSA+
PSA1NjAwMCkKPiAJCW4gKj0gMjsKPiAJcmV0dXJuICgoaW50KW4pIC0gc3lz
dGVtX3NhbXBsZV9yYXRlOwo+IH0KPiAKPiBzdGF0aWMgaW50IGhkc3Bfc2V0
X2Rkc19vZmZzZXQoc3RydWN0IGhkc3AgKmhkc3AsIGludCBvZmZzZXRfaHop
Cj4gewo+IAlpbnQgcmF0ZSA9IGhkc3AtPnN5c3RlbV9zYW1wbGVfcmF0ZSAr
IG9mZnNldF9oejsKPiAJaGRzcF9zZXRfZGRzX3ZhbHVlKGhkc3AsIHJhdGUp
Owo+IAlyZXR1cm4gMDsKPiB9Cj4gCj4gc3RhdGljIGludCBzbmRfaGRzcF9p
bmZvX2Rkc19vZmZzZXQoc3RydWN0IHNuZF9rY29udHJvbCAqa2NvbnRyb2ws
IHN0cnVjdCBzbmRfY3RsX2VsZW1faW5mbyAqdWluZm8pCj4gewo+IAl1aW5m
by0+dHlwZSA9IFNORFJWX0NUTF9FTEVNX1RZUEVfSU5URUdFUjsKPiAJdWlu
Zm8tPmNvdW50ID0gMTsKPiAJdWluZm8tPnZhbHVlLmludGVnZXIubWluID0g
LTUwMDA7Cj4gCXVpbmZvLT52YWx1ZS5pbnRlZ2VyLm1heCA9IDUwMDA7Cj4g
CXJldHVybiAwOwo+IH0KPiAKPiBzdGF0aWMgaW50IHNuZF9oZHNwX2dldF9k
ZHNfb2Zmc2V0KHN0cnVjdCBzbmRfa2NvbnRyb2wgKmtjb250cm9sLCBzdHJ1
Y3Qgc25kX2N0bF9lbGVtX3ZhbHVlICp1Y29udHJvbCkKPiB7Cj4gCXN0cnVj
dCBoZHNwICpoZHNwID0gc25kX2tjb250cm9sX2NoaXAoa2NvbnRyb2wpOwo+
IAkKPiAJdWNvbnRyb2wtPnZhbHVlLmVudW1lcmF0ZWQuaXRlbVswXSA9IGhk
c3BfZGRzX29mZnNldChoZHNwKTsKPiAJcmV0dXJuIDA7Cj4gfQo+IAo+IHN0
YXRpYyBpbnQgc25kX2hkc3BfcHV0X2Rkc19vZmZzZXQoc3RydWN0IHNuZF9r
Y29udHJvbCAqa2NvbnRyb2wsIHN0cnVjdCBzbmRfY3RsX2VsZW1fdmFsdWUg
KnVjb250cm9sKQo+IHsKPiAJc3RydWN0IGhkc3AgKmhkc3AgPSBzbmRfa2Nv
bnRyb2xfY2hpcChrY29udHJvbCk7Cj4gCWludCBjaGFuZ2U7Cj4gCWludCB2
YWw7Cj4gCQo+IAlpZiAoIXNuZF9oZHNwX3VzZV9pc19leGNsdXNpdmUoaGRz
cCkpCj4gCQlyZXR1cm4gLUVCVVNZOwo+IAl2YWwgPSB1Y29udHJvbC0+dmFs
dWUuZW51bWVyYXRlZC5pdGVtWzBdOwo+IAlzcGluX2xvY2tfaXJxKCZoZHNw
LT5sb2NrKTsKPiAJaWYgKHZhbCAhPSBoZHNwX2Rkc19vZmZzZXQoaGRzcCkp
Cj4gCQljaGFuZ2UgPSAoaGRzcF9zZXRfZGRzX29mZnNldChoZHNwLCB2YWwp
ID09IDApID8gMSA6IDA7Cj4gCWVsc2UKPiAJCWNoYW5nZSA9IDA7Cj4gCXNw
aW5fdW5sb2NrX2lycSgmaGRzcC0+bG9jayk7Cj4gCXJldHVybiBjaGFuZ2U7
Cj4gfQo+IAozMDkyYzMxNjQsMzE2NQo8IEhEU1BfWExSX0JSRUFLT1VUX0NB
QkxFKCJYTFIgQnJlYWtvdXQgQ2FibGUiLCAwKQotLS0KPiBIRFNQX1hMUl9C
UkVBS09VVF9DQUJMRSgiWExSIEJyZWFrb3V0IENhYmxlIiwgMCksCj4gSERT
UF9ERFNfT0ZGU0VUKCJERFMgU2FtcGxlIFJhdGUgT2Zmc2V0IChIeikiLCAw
KQo=

--0-595376096-1173386036=:48905
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--0-595376096-1173386036=:48905
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--0-595376096-1173386036=:48905--
