From: Henry Walpool <apkennedy@firstlinux.net>
Subject: [PATCH] Adding support for ST Audio Media 7.1 to hoontech.[ch]
Date: Sun, 8 Dec 2002 15:54:53 -0800 (PST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20021208235454.12DAB405A@sitemail.everyone.net>
Reply-To: apkennedy@firstlinux.net
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="----------=_1039391694-20118-0"
Content-Transfer-Encoding: binary
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format...

------------=_1039391694-20118-0
Content-Type: text/plain
Content-Disposition: inline
Content-Transfer-Encoding: 7bit



_____________________________________________________________
Want a new web-based email account ? ---> http://www.firstlinux.net

_____________________________________________________________
Select your own custom email address for FREE! Get you@yourchoice.com w/No Ads, 6MB, POP & more! http://www.everyone.net/selectmail?campaign=tag

------------=_1039391694-20118-0
Content-Type: text/plain; name="questions_alsa_dev.txt"
Content-Disposition: inline; filename="questions_alsa_dev.txt"
Content-Transfer-Encoding: base64

QmVsb3cgaXMgYSBwYXRjaCB0byBmdWxseSBlbmFibGUgdGhlIEhvb250ZWNo
IFNUIEF1ZGlvIERTUDI0Ck1lZGlhIDcuMS4gIEl0IGFwcGVhcnMgdGhhdCB0
aGlzIGNhcmQgaXMgc3VwcG9ydGVkLiAgSXQgd2FzIG5pY2UKdG8gc2VlIGFs
bCB0aGUgb3V0cHV0IGNvbnRyb2xzIGluIGVudnkyNGNvbnRyb2wuIAoKKioq
IFN0YXJ0IFBhdGNoICoqKgoKCi0tLSBhbHNhY3ZzL2Fsc2Eta2VybmVsL3Bj
aS9pY2UxNzEyL2hvb250ZWNoLmMJVHVlIFNlcCAxNyAwNTo0MjowNyAyMDAy
CisrKyBhbHNhY3ZzX21vZGlmaWVkXzEvYWxzYS1rZXJuZWwvcGNpL2ljZTE3
MTIvaG9vbnRlY2guYwlTYXQgRGVjICA3IDE0OjEwOjQxIDIwMDIKQEAgLTIx
OCw2ICsyMTgsMTEgQEAKIAkJIkhvb250ZWNoIFNvdW5kVHJhY2sgQXVkaW8g
RFNQMjQiLAogCQlzbmRfaWNlMTcxMl9ob29udGVjaF9pbml0LAogCX0sCisJ
eworCQlJQ0UxNzEyX1NVQkRFVklDRV9TVERTUDI0X01FRElBN18xLAorCQki
SG9vbnRlY2ggU1RBIERTUDI0IE1lZGlhIDcuMSIsCisJCXNuZF9pY2UxNzEy
X2hvb250ZWNoX2luaXQsCisJfSwKIAl7IH0gLyogdGVybWluYXRvciAqLwog
fTsKIAotLS0gYWxzYWN2cy9hbHNhLWtlcm5lbC9wY2kvaWNlMTcxMi9ob29u
dGVjaC5oCVR1ZSBTZXAgMTcgMDU6NDI6MDcgMjAwMgorKysgYWxzYWN2c19t
b2RpZmllZF8xL2Fsc2Eta2VybmVsL3BjaS9pY2UxNzEyL2hvb250ZWNoLmgJ
VGh1IERlYyAgNSAwMDoyMToxOSAyMDAyCkBAIC0yNyw2ICsyNyw3IEBACiAj
ZGVmaW5lICBIT09OVEVDSF9ERVZJQ0VfREVTQyAJICAgICAgICJ7SG9vbnRl
Y2ggU291bmRUcmFjayBEU1AgMjR9LCIKIAogI2RlZmluZSBJQ0UxNzEyX1NV
QkRFVklDRV9TVERTUDI0CTB4MTIxNDEyMTcJLyogSG9vbnRlY2ggU291bmRU
cmFjayBBdWRpbyBEU1AgMjQgKi8KKyNkZWZpbmUgSUNFMTcxMl9TVUJERVZJ
Q0VfU1REU1AyNF9NRURJQTdfMQkweDE2MTQxMjE3CS8qIEhvb250ZWNoIFNU
IEF1ZGlvIERTUDI0IE1lZGlhIDcuMSAqLwogCiBleHRlcm4gc3RydWN0IHNu
ZF9pY2UxNzEyX2NhcmRfaW5mbyBzbmRfaWNlMTcxMl9ob29udGVjaF9jYXJk
c1tdOwogCioqKiBFbmQgUGF0Y2ggKioqCgpTb21lIHF1aWNrIHF1ZXN0aW9u
cy4gCgoxKSBBZnRlciByZWFkaW5nIG9sZCBwb3N0cyBpbiB0aGUgbWFpbGlu
ZyBsaXN0cyBpdCBhcHBlYXJzIHRoYXQKdGhlIGhvb250ZWNoIGljZTE3MTIg
Y2FyZHMgZG9uJ3QgaGF2ZSB0aGUgb3B0aW9uIHRvIGNoYW5nZSB0aGUKaW5w
dXQgZ2FpbiAoYW5hbG9nIHZvbHVtZSkgb24gYW5hbG9nIGlucHV0LiBJIHNl
ZSBubyBhbmFsb2cKdm9sdW1lIGNvbnRyb2xzIHdpdGggYW1peGVyLCBvciBl
bnZ5MjRjb250cm9sLiBJcyB0aGlzIHRydWU/IFdoYXQKaWNlMTcxMiBjYXJk
cyBoYXZlIGFuYWxvZyBpbnB1dCB2b2x1bWUvZ2FpbiBjb250cm9sPwoKMikg
RG9lcyBhbnlvbmUga25vdyB0aGUgY29ycmVjdCB3YXkgdG8gc2V0IHRoZSBz
cGRpZiBmb3IKY29uc3VtZXIvcHJvZmVzc2lvbmFsIG1vZGUgb24gdGhpcyBj
YXJkPyAKCjMpIENsYXVzIGF0IHN0IGF1ZGlvIHN1cHBvcnQgc2FpZCB0aGF0
IHRoaXMgY2FyZCB3b3VsZCBub3Qgd29yawppZiBncGlvX3dyaXRlIGNhbGxz
IGluIGhvb250ZWNoLmMgd2VyZSBtYWRlIHRvIGluaXRpbGl6ZSB0aGUgYm94
LgpIb3dldmVyLCBJIHNlZSBubyBkaWZmZXJlbmNlIHVzaW5nIHRoZXNlIGNh
bGxzIG9yIG5vdCB1c2luZyB0aGVzZQpjYWxscy4gRG9lcyBhbnlvbmUga25v
dyBmb3Igc3VyZT8gQ2xhdXMgc2FpZCB0aGF0IHNvbWVvbmUgb24gdGhlCm1h
aWxpbmcgbGlzdCB3b3VsZCBrbm93IHRoZSBhbnN3ZXIuCgo0KSBIb3cgZG9l
cyBvbmUgdHVybiBvZmYgdGhlIGV4dHJhIG91dHB1dCBjaGFubmVscyB3aGVu
IHVzaW5nIG9zcwpzdXBwb3J0ZWQgYXBwbGljYXRpb25zLCBvciB1c2Ugb25s
eSBjZXJ0YWluIG91dHB1dCBjaGFubmVscyB3aGVuCnVzaW5nIG9zcyBzdXBw
b3J0ZWQgYXBwbGljYXRpb25zPwoKNSkgSG93IGRvZXMgb25lIGFjY2Vzcy91
c2UgdGhlIGFjOTcgcGFydCBvZiB0aGlzIGNhcmQ/Cgo2KSBDb21tZW50cyBv
biB0aGUgY2FyZC9leHRlcm5hbCBib3guIFRoZSBSSUFBIHBob25vIHByZS1h
bXAKc3Vja3MgYmlnIHRpbWUuIERvZXMgbm90IGV2ZW4gY29tcGFyZSB3aXRo
IGEgY2hlYXAgcGhvbm8gcHJlLWFtcC4KQ2FuJ3QgcmVjb3JkIGF0IDk2MDAw
SHogd2l0aG91dCBvdmVycnVucyB1c2luZyBsb3cgbGF0ZW5jeSBwYXRjaAph
bmQgZXZlcnkgc2VydmljZSBJIGNvdWxkIGRpc2FibGUuIENhcmQgaGFzIGl0
J3Mgb3duIElSUSBhbHNvLgpNYXkgaGF2ZSBzb21ldGhpbmcgdG8gZG8gd2l0
aCB0aGUgdmlhIEtUMTMzIGJhc2VkIG1vdGhlcmJvYXJkIEkKaGF2ZS4gCgpU
aGFua3MgCgpIZW5yeQo=

------------=_1039391694-20118-0--


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
