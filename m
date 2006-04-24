From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: Remove xrun debugging?
Date: Mon, 24 Apr 2006 10:55:02 +0200 (CEST)
Message-ID: <Pine.LNX.4.61.0604241042280.10174@tm8103.perex-int.cz>
References: <1145767405.21377.20.camel@mindpipe> <20060423174534.1dd2cb44@mango.fruits>
 <1145809115.21377.34.camel@mindpipe> <20060423210329.3725f5c5@mango.fruits>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323584-1602229300-1145868902=:10174"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20060423210329.3725f5c5@mango.fruits>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Florian Schmidt <mista.tapas@gmx.net>
Cc: Lee Revell <rlrevell@joe-job.com>, alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323584-1602229300-1145868902=:10174
Content-Type: TEXT/PLAIN; charset=US-ASCII

On Sun, 23 Apr 2006, Florian Schmidt wrote:

> On Sun, 23 Apr 2006 12:18:34 -0400
> Lee Revell <rlrevell@joe-job.com> wrote:
> 
> > > It still might prove useful for non -rt users. I don't know exactly how
> > > useful, but maybe it's really a documentation bug. Put a note in the
> > > helpfile that much finer debugging can be done with the -rt kernels.
> > 
> > I don't think it's useful at all - any bugs that it could have found
> > were fixed long ago.  I have not seen useful output from it in a year
> > and a half.
> 
> That doesn't mean it won't prove useful in the future. But i don't know.
> Takashi? Jaroslav?

I think that we can make the code optional for now. Patch for review is 
attached.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SUSE Labs
--8323584-1602229300-1145868902=:10174
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="optional-xrun-debug.patch"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.61.0604241055020.10174@tm8103.perex-int.cz>
Content-Description: 
Content-Disposition: attachment; filename="optional-xrun-debug.patch"

ZGlmZiAtciBhM2JkMDQwOTM5MzMgY29yZS9LY29uZmlnDQotLS0gYS9jb3Jl
L0tjb25maWcJRnJpIEFwciAyMSAxNzoyOTozNyAyMDA2ICswMjAwDQorKysg
Yi9jb3JlL0tjb25maWcJTW9uIEFwciAyNCAxMDo1MzozNyAyMDA2ICswMjAw
DQpAQCAtMTcxLDMgKzE3MSwxMyBAQCBjb25maWcgU05EX0RFQlVHX0RFVEVD
VA0KIAloZWxwDQogCSAgU2F5IFkgaGVyZSB0byBlbmFibGUgZXh0cmEtdmVy
Ym9zZSBsb2cgbWVzc2FnZXMgcHJpbnRlZCB3aGVuDQogCSAgZGV0ZWN0aW5n
IGRldmljZXMuDQorDQorY29uZmlnIFNORF9QQ01fWFJVTl9ERUJVRw0KKwli
b29sICJFbmFibGUgUENNIHJpbmcgYnVmZmVyIG92ZXJydW4vdW5kZXJydW4g
ZGVidWdnaW5nIg0KKwlkZWZhdWx0IG4NCisJZGVwZW5kcyBvbiBTTkRfUENN
ICYmIFNORF9ERUJVRw0KKwloZWxwDQorCSAgU2F5IFkgdG8gZW5hYmxlIHRo
ZSBQQ00gcmluZyBidWZmZXIgb3ZlcnJ1bi91bmRlcnJ1biBkZWJ1Z2dpbmcu
DQorCSAgSXQgaXMgbm8gdXN1YWxseSByZXF1aXJlZCwgYnV0IGlmIHlvdSBo
YXZlIHRyb3VibGUgd2l0aA0KKwkgIHNvdW5kIGNsaWNraW5nIHdoZW4gc3lz
dGVtIGlzIGxvYWRlZCwgaXQgbWF5IGhlbHAgdG8gZGV0ZXJtaW5lDQorCSAg
dGhlIHByb2Nlc3Mgb3IgZHJpdmVyIHdoaWNoIGNhdXNlcyB0aGUgc2NoZWR1
bGluZyBnYXBzLg0KZGlmZiAtciBhM2JkMDQwOTM5MzMgY29yZS9wY20uYw0K
LS0tIGEvY29yZS9wY20uYwlGcmkgQXByIDIxIDE3OjI5OjM3IDIwMDYgKzAy
MDANCisrKyBiL2NvcmUvcGNtLmMJTW9uIEFwciAyNCAxMDo1MzozNyAyMDA2
ICswMjAwDQpAQCAtNDM2LDcgKzQzNiw3IEBAIHN0YXRpYyB2b2lkIHNuZF9w
Y21fc3Vic3RyZWFtX3Byb2Nfc3RhdHUNCiAJc25kX2lwcmludGYoYnVmZmVy
LCAiYXBwbF9wdHIgICAgOiAlbGRcbiIsIHJ1bnRpbWUtPmNvbnRyb2wtPmFw
cGxfcHRyKTsNCiB9DQogDQotI2lmZGVmIENPTkZJR19TTkRfREVCVUcNCisj
aWZkZWYgQ09ORklHX1NORF9QQ01fWFJVTl9ERUJVRw0KIHN0YXRpYyB2b2lk
IHNuZF9wY21feHJ1bl9kZWJ1Z19yZWFkKHN0cnVjdCBzbmRfaW5mb19lbnRy
eSAqZW50cnksDQogCQkJCSAgICBzdHJ1Y3Qgc25kX2luZm9fYnVmZmVyICpi
dWZmZXIpDQogew0KQEAgLTQ4MCw3ICs0ODAsNyBAQCBzdGF0aWMgaW50IHNu
ZF9wY21fc3RyZWFtX3Byb2NfaW5pdChzdHJ1DQogCX0NCiAJcHN0ci0+cHJv
Y19pbmZvX2VudHJ5ID0gZW50cnk7DQogDQotI2lmZGVmIENPTkZJR19TTkRf
REVCVUcNCisjaWZkZWYgQ09ORklHX1NORF9QQ01fWFJVTl9ERUJVRw0KIAlp
ZiAoKGVudHJ5ID0gc25kX2luZm9fY3JlYXRlX2NhcmRfZW50cnkocGNtLT5j
YXJkLCAieHJ1bl9kZWJ1ZyIsDQogCQkJCQkJcHN0ci0+cHJvY19yb290KSkg
IT0gTlVMTCkgew0KIAkJZW50cnktPmMudGV4dC5yZWFkX3NpemUgPSA2NDsN
CkBAIC01MDEsNyArNTAxLDcgQEAgc3RhdGljIGludCBzbmRfcGNtX3N0cmVh
bV9wcm9jX2luaXQoc3RydQ0KIA0KIHN0YXRpYyBpbnQgc25kX3BjbV9zdHJl
YW1fcHJvY19kb25lKHN0cnVjdCBzbmRfcGNtX3N0ciAqcHN0cikNCiB7DQot
I2lmZGVmIENPTkZJR19TTkRfREVCVUcNCisjaWZkZWYgQ09ORklHX1NORF9Q
Q01fWFJVTl9ERUJVRw0KIAlpZiAocHN0ci0+cHJvY194cnVuX2RlYnVnX2Vu
dHJ5KSB7DQogCQlzbmRfaW5mb191bnJlZ2lzdGVyKHBzdHItPnByb2NfeHJ1
bl9kZWJ1Z19lbnRyeSk7DQogCQlwc3RyLT5wcm9jX3hydW5fZGVidWdfZW50
cnkgPSBOVUxMOw0KZGlmZiAtciBhM2JkMDQwOTM5MzMgY29yZS9wY21fbGli
LmMNCi0tLSBhL2NvcmUvcGNtX2xpYi5jCUZyaSBBcHIgMjEgMTc6Mjk6Mzcg
MjAwNiArMDIwMA0KKysrIGIvY29yZS9wY21fbGliLmMJTW9uIEFwciAyNCAx
MDo1MzozNyAyMDA2ICswMjAwDQpAQCAtMTMwLDcgKzEzMCw3IEBAIHN0YXRp
YyB2b2lkIHhydW4oc3RydWN0IHNuZF9wY21fc3Vic3RyZWENCiBzdGF0aWMg
dm9pZCB4cnVuKHN0cnVjdCBzbmRfcGNtX3N1YnN0cmVhbSAqc3Vic3RyZWFt
KQ0KIHsNCiAJc25kX3BjbV9zdG9wKHN1YnN0cmVhbSwgU05EUlZfUENNX1NU
QVRFX1hSVU4pOw0KLSNpZmRlZiBDT05GSUdfU05EX0RFQlVHDQorI2lmZGVm
IENPTkZJR19TTkRfUENNX1hSVU5fREVCVUcNCiAJaWYgKHN1YnN0cmVhbS0+
cHN0ci0+eHJ1bl9kZWJ1Zykgew0KIAkJc25kX3ByaW50ZChLRVJOX0RFQlVH
ICJYUlVOOiBwY21DJWREJWQlY1xuIiwNCiAJCQkgICBzdWJzdHJlYW0tPnBj
bS0+Y2FyZC0+bnVtYmVyLA0KQEAgLTIwNCw3ICsyMDQsNyBAQCBzdGF0aWMg
aW5saW5lIGludCBzbmRfcGNtX3VwZGF0ZV9od19wdHJfDQogCWRlbHRhID0g
aHdfcHRyX2ludGVycnVwdCAtIG5ld19od19wdHI7DQogCWlmIChkZWx0YSA+
IDApIHsNCiAJCWlmICgoc25kX3BjbV91ZnJhbWVzX3QpZGVsdGEgPCBydW50
aW1lLT5idWZmZXJfc2l6ZSAvIDIpIHsNCi0jaWZkZWYgQ09ORklHX1NORF9E
RUJVRw0KKyNpZmRlZiBDT05GSUdfU05EX1BDTV9YUlVOX0RFQlVHDQogCQkJ
aWYgKHJ1bnRpbWUtPnBlcmlvZHMgPiAxICYmIHN1YnN0cmVhbS0+cHN0ci0+
eHJ1bl9kZWJ1Zykgew0KIAkJCQlzbmRfcHJpbnRkKEtFUk5fRVJSICJVbmV4
cGVjdGVkIGh3X3BvaW50ZXIgdmFsdWUgWzFdIChzdHJlYW0gPSAlaSwgZGVs
dGE6IC0lbGQsIG1heCBqaXR0ZXIgPSAlbGQpOiB3cm9uZyBpbnRlcnJ1cHQg
YWNrbm93bGVkZ2U/XG4iLCBzdWJzdHJlYW0tPnN0cmVhbSwgKGxvbmcpIGRl
bHRhLCBydW50aW1lLT5idWZmZXJfc2l6ZSAvIDIpOw0KIAkJCQlpZiAoc3Vi
c3RyZWFtLT5wc3RyLT54cnVuX2RlYnVnID4gMSkNCkBAIC0yNDksNyArMjQ5
LDcgQEAgaW50IHNuZF9wY21fdXBkYXRlX2h3X3B0cihzdHJ1Y3Qgc25kX3Bj
bQ0KIAlkZWx0YSA9IG9sZF9od19wdHIgLSBuZXdfaHdfcHRyOw0KIAlpZiAo
ZGVsdGEgPiAwKSB7DQogCQlpZiAoKHNuZF9wY21fdWZyYW1lc190KWRlbHRh
IDwgcnVudGltZS0+YnVmZmVyX3NpemUgLyAyKSB7DQotI2lmZGVmIENPTkZJ
R19TTkRfREVCVUcNCisjaWZkZWYgQ09ORklHX1NORF9QQ01fWFJVTl9ERUJV
Rw0KIAkJCWlmIChydW50aW1lLT5wZXJpb2RzID4gMiAmJiBzdWJzdHJlYW0t
PnBzdHItPnhydW5fZGVidWcpIHsNCiAJCQkJc25kX3ByaW50ZChLRVJOX0VS
UiAiVW5leHBlY3RlZCBod19wb2ludGVyIHZhbHVlIFsyXSAoc3RyZWFtID0g
JWksIGRlbHRhOiAtJWxkLCBtYXggaml0dGVyID0gJWxkKTogd3JvbmcgaW50
ZXJydXB0IGFja25vd2xlZGdlP1xuIiwgc3Vic3RyZWFtLT5zdHJlYW0sIChs
b25nKSBkZWx0YSwgcnVudGltZS0+YnVmZmVyX3NpemUgLyAyKTsNCiAJCQkJ
aWYgKHN1YnN0cmVhbS0+cHN0ci0+eHJ1bl9kZWJ1ZyA+IDEpDQo=

--8323584-1602229300-1145868902=:10174--


-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
