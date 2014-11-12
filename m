From: Kailang <kailang@realtek.com>
Subject: Re: ALC1150 COEF
Date: Wed, 12 Nov 2014 10:02:33 +0000
Message-ID: <6FAB7C47BCF00940BB0999A99BE3547A179FB052@RTITMBSV09.realtek.com.tw>
References: <s5hr3x9qz5j.wl-tiwai@suse.de>
 <6FAB7C47BCF00940BB0999A99BE3547A179FB004@RTITMBSV09.realtek.com.tw>
 <s5h8ujgrext.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="_002_6FAB7C47BCF00940BB0999A99BE3547A179FB052RTITMBSV09realt_"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id BF72A26530C
 for <alsa-devel@alsa-project.org>; Wed, 12 Nov 2014 11:02:51 +0100 (CET)
In-Reply-To: <s5h8ujgrext.wl-tiwai@suse.de>
Content-Language: zh-TW
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: " (alsa-devel@alsa-project.org)" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

--_002_6FAB7C47BCF00940BB0999A99BE3547A179FB052RTITMBSV09realt_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable


I merge all codec into alc_fill_eapd_coef().
Please see attach.
Many Thanks. ^^

> -----Original Message-----
> From: Takashi Iwai [mailto:tiwai@suse.de]=20
> Sent: Wednesday, November 12, 2014 4:39 PM
> To: Kailang
> Subject: Re: ALC1150 COEF
>=20
> At Wed, 12 Nov 2014 08:27:56 +0000,
> Kailang wrote:
> >=20
> > Hi Takashi,
> >=20
> > I cooked a patch for this issue as attach.=20
> > It is not include ALC26x ALC28x ALC29x.
> > If you agree this patch,
> > could it merge into one patch?
>=20
> Yes, it looks good.  Could you submit it with proper=20
> changelog etc as usual to alsa-devel ML?  Then I'll queue it=20
> for 3.18-rc5.
>=20
>=20
> thanks,
>=20
> Takashi
>=20
> >=20
> > BR,
> > Kailang
> >=20
> > > -----Original Message-----
> > > From: Takashi Iwai [mailto:tiwai@suse.de]
> > > Sent: Wednesday, November 12, 2014 4:08 AM
> > > To: Kailang
> > > Subject: ALC1150 COEF
> > >=20
> > > Hi Kailang,
> > >=20
> > > we've got bug reports about the silent output on mobos=20
> with ALC1150=20
> > > after Windows reboot.  It seems that COEF 0x07 bit
> > > 0x02 plays some role.  Could you check it?
> > > 	https://bugzilla.kernel.org/show_bug.cgi?id=3D87771
> > >=20
> > > thanks,
> > >=20
> > > Takashi
> > >=20
> > > ------Please consider the environment before printing this e-mail.
> > >=20
> > [2 0000-reset-eapd-control.patch <application/octet-stream=20
> (base64)>]
> >=20
> =

--_002_6FAB7C47BCF00940BB0999A99BE3547A179FB052RTITMBSV09realt_
Content-Type: application/octet-stream;
	name="0000-change-eapd-to-verb-control.patch"
Content-Description: 0000-change-eapd-to-verb-control.patch
Content-Disposition: attachment;
	filename="0000-change-eapd-to-verb-control.patch"; size=4416;
	creation-date="Wed, 12 Nov 2014 09:43:37 GMT";
	modification-date="Wed, 12 Nov 2014 09:59:51 GMT"
Content-Transfer-Encoding: base64

RnJvbSA4YzEwYzM2NDBlYmY2MTQwMGM5YzcwM2JhOGRhMjIwMzdhODM4ZDI0IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBLYWlsYW5nIFlhbmcgPGthaWxhbmdAcmVhbHRlay5jb20+CkRh
dGU6IFdlZCwgMTIgTm92IDIwMTQgMTc6Mzg6MDggKzA4MDAKU3ViamVjdDogW1BBVENIXSBBTFNB
OiBoZGEvcmVhbHRlayAtIENoYW5nZSBFQVBEIHRvIHZlcmIgY29udHJvbAoKVGhpcyB3aWxsIGZp
eCBubyBzb3VuZCBpbiBMaW51eCBzeXN0ZW0gYWZ0ZXIgcmVib290IGZyb20gd2luZG93cy4KCkNo
YW5nZSBsb2c6Ci0gYWxjNjYyX2ZpbGxfY29lZigpIGlzIHJlcGxhY2VkIHdpdGggYWxjX2ZpbGxf
ZWFwZF9jb2VmX2lkeCgpIAogIGFuZCBtb3ZlIGludG8gYWxjX2F1dG9faW5pdF9hbXAoKS4KLSBG
b3IgQUxDMjYyLCBBTEMyNjcsIEFMQzI2OCwgQUxDMjY5LCBBTEMyMzMsIEFMQzI1NSwgQUxDMjgw
LCBBTEMyODIsCiAgQUxDMjgzLCBBTEMyODQsIEFMQzI4NSwgQUxDMjg2LCBBTEMyODgsIEFMQzI5
MCwgQUxDMjkyLCBBTEMyOTMsIEFMQzI5NCwKICBBTEM2NjgsIEFMQzg4OFZDLCBBTEM4ODhWRCwg
QUxDODkxLCBBTEM4OTIsIEFMQzg5OCBhbmQgQUxDMTE1MCwgYWRkIHVwZGF0ZQogIENPRUYgY29u
dHJvbCBmb3IgRUFQRCBzZXR0aW5nLgotIFJlbW92ZSBhbGMyNjlfZmlsbF9jb2VmKCkgZm9yIHVw
ZGF0ZSBFQVBEIGNvbnRyb2wgbGluZS4KClNpZ25lZC1vZmYtYnk6IEthaWxhbmcgWWFuZyA8a2Fp
bGFuZ0ByZWFsdGVrLmNvbT4KCmRpZmYgLS1naXQgYS9zb3VuZC9wY2kvaGRhL3BhdGNoX3JlYWx0
ZWsuYyBiL3NvdW5kL3BjaS9oZGEvcGF0Y2hfcmVhbHRlay5jCmluZGV4IGRhMDM2OTMuLjlmYmNi
YmQgMTAwNjQ0Ci0tLSBhL3NvdW5kL3BjaS9oZGEvcGF0Y2hfcmVhbHRlay5jCisrKyBiL3NvdW5k
L3BjaS9oZGEvcGF0Y2hfcmVhbHRlay5jCkBAIC0yODgsNiArMjg4LDgwIEBAIHN0YXRpYyB2b2lk
IGFsYzg4MF91bnNvbF9ldmVudChzdHJ1Y3QgaGRhX2NvZGVjICpjb2RlYywgdW5zaWduZWQgaW50
IHJlcykKIAlzbmRfaGRhX2phY2tfdW5zb2xfZXZlbnQoY29kZWMsIHJlcyA+PiAyKTsKIH0KIAor
LyogQ2hhbmdlIEVBUEQgdG8gdmVyYiBjb250cm9sICovCitzdGF0aWMgdm9pZCBhbGNfZmlsbF9l
YXBkX2NvZWYoc3RydWN0IGhkYV9jb2RlYyAqY29kZWMpCit7CisJaW50IGNvZWY7CisKKwljb2Vm
ID0gYWxjX2dldF9jb2VmMChjb2RlYyk7CisKKwlzd2l0Y2ggKGNvZGVjLT52ZW5kb3JfaWQpIHsK
KwljYXNlIDB4MTBlYzAyNjI6CisJCWFsY191cGRhdGVfY29lZl9pZHgoY29kZWMsIDB4NywgMCwg
MTw8NSk7CisJCWJyZWFrOworCWNhc2UgMHgxMGVjMDI2NzoKKwljYXNlIDB4MTBlYzAyNjg6CisJ
CWFsY191cGRhdGVfY29lZl9pZHgoY29kZWMsIDB4NywgMCwgMTw8MTMpOworCQlicmVhazsKKwlj
YXNlIDB4MTBlYzAyNjk6CisJCWlmICgoY29lZiAmIDB4MDBmMCkgPT0gMHgwMDEwKQorCQkJYWxj
X3VwZGF0ZV9jb2VmX2lkeChjb2RlYywgMHhkLCAwLCAxPDwxNCk7CisJCWlmICgoY29lZiAmIDB4
MDBmMCkgPT0gMHgwMDIwKQorCQkJYWxjX3VwZGF0ZV9jb2VmX2lkeChjb2RlYywgMHg0LCAxPDwx
NSwgMCk7CisJCWlmICgoY29lZiAmIDB4MDBmMCkgPT0gMHgwMDMwKQorCQkJYWxjX3VwZGF0ZV9j
b2VmX2lkeChjb2RlYywgMHgxMCwgMTw8OSwgMCk7CisJCWJyZWFrOworCWNhc2UgMHgxMGVjMDI4
MDoKKwljYXNlIDB4MTBlYzAyODQ6CisJY2FzZSAweDEwZWMwMjkwOgorCWNhc2UgMHgxMGVjMDI5
MjoKKwkJYWxjX3VwZGF0ZV9jb2VmX2lkeChjb2RlYywgMHg0LCAxPDwxNSwgMCk7CisJCWJyZWFr
OworCWNhc2UgMHgxMGVjMDIzMzoKKwljYXNlIDB4MTBlYzAyNTU6CisJY2FzZSAweDEwZWMwMjgy
OgorCWNhc2UgMHgxMGVjMDI4MzoKKwljYXNlIDB4MTBlYzAyODY6CisJY2FzZSAweDEwZWMwMjg4
OgorCQlhbGNfdXBkYXRlX2NvZWZfaWR4KGNvZGVjLCAweDEwLCAxPDw5LCAwKTsKKwkJYnJlYWs7
CisJY2FzZSAweDEwZWMwMjg1OgorCWNhc2UgMHgxMGVjMDI5MzoKKwkJYWxjX3VwZGF0ZV9jb2Vm
X2lkeChjb2RlYywgMHhhLCAxPDwxMywgMCk7CisJCWJyZWFrOworCWNhc2UgMHgxMGVjMDY2MjoK
KwkJaWYgKChjb2VmICYgMHgwMGYwKSA9PSAweDAwMzApCisJCQlhbGNfdXBkYXRlX2NvZWZfaWR4
KGNvZGVjLCAweDQsIDE8PDEwLCAwKTsgLyogRUFQRCBDdHJsICovCisJCWJyZWFrOworCWNhc2Ug
MHgxMGVjMDI3MjoKKwljYXNlIDB4MTBlYzAyNzM6CisJY2FzZSAweDEwZWMwNjYzOgorCWNhc2Ug
MHgxMGVjMDY2NToKKwljYXNlIDB4MTBlYzA2NzA6CisJY2FzZSAweDEwZWMwNjcxOgorCWNhc2Ug
MHgxMGVjMDY3MjoKKwkJYWxjX3VwZGF0ZV9jb2VmX2lkeChjb2RlYywgMHhkLCAwLCAxPDwxNCk7
IC8qIEVBUEQgQ3RybCAqLworCQlicmVhazsKKwljYXNlIDB4MTBlYzA2Njg6CisJCWFsY191cGRh
dGVfY29lZl9pZHgoY29kZWMsIDB4NywgMzw8MTMsIDApOworCQlicmVhazsKKwljYXNlIDB4MTBl
YzA4Njc6CisJCWFsY191cGRhdGVfY29lZl9pZHgoY29kZWMsIDB4NCwgMTw8MTAsIDApOworCQli
cmVhazsKKwljYXNlIDB4MTBlYzA4ODg6CisJCWlmICgoY29lZiAmIDB4MDBmMCkgPT0gMHgwMDIw
IHx8IChjb2VmICYgMHgwMGYwKSA9PSAweDAwMzApCisJCQlhbGNfdXBkYXRlX2NvZWZfaWR4KGNv
ZGVjLCAweDcsIDE8PDUsIDApOworCQlicmVhazsKKwljYXNlIDB4MTBlYzA4OTI6CisJCWFsY191
cGRhdGVfY29lZl9pZHgoY29kZWMsIDB4NywgMTw8NSwgMCk7CisJCWJyZWFrOworCWNhc2UgMHgx
MGVjMDg5OToKKwljYXNlIDB4MTBlYzA5MDA6CisJCWFsY191cGRhdGVfY29lZl9pZHgoY29kZWMs
IDB4NywgMTw8MSwgMCk7CisJCWJyZWFrOworCX0KK30KKwogLyogYWRkaXRpb25hbCBpbml0aWFs
aXphdGlvbiBmb3IgQUxDODg4IHZhcmlhbnRzICovCiBzdGF0aWMgdm9pZCBhbGM4ODhfY29lZl9p
bml0KHN0cnVjdCBoZGFfY29kZWMgKmNvZGVjKQogewpAQCAtMzM5LDYgKzQxMyw3IEBAIHN0YXRp
YyB2b2lkIGFsY19lYXBkX3NodXR1cChzdHJ1Y3QgaGRhX2NvZGVjICpjb2RlYykKIC8qIGdlbmVy
aWMgRUFQRCBpbml0aWFsaXphdGlvbiAqLwogc3RhdGljIHZvaWQgYWxjX2F1dG9faW5pdF9hbXAo
c3RydWN0IGhkYV9jb2RlYyAqY29kZWMsIGludCB0eXBlKQogeworCWFsY19maWxsX2VhcGRfY29l
Zihjb2RlYyk7CiAJYWxjX2F1dG9fc2V0dXBfZWFwZChjb2RlYywgdHJ1ZSk7CiAJc3dpdGNoICh0
eXBlKSB7CiAJY2FzZSBBTENfSU5JVF9HUElPMToKQEAgLTUyMTIsOSArNTI4Nyw2IEBAIHN0YXRp
YyB2b2lkIGFsYzI2OV9maWxsX2NvZWYoc3RydWN0IGhkYV9jb2RlYyAqY29kZWMpCiAJCX0KIAl9
CiAKLQkvKiBDbGFzcyBEICovCi0JYWxjX3VwZGF0ZV9jb2VmX2lkeChjb2RlYywgMHhkLCAwLCAx
PDwxNCk7Ci0KIAkvKiBIUCAqLwogCWFsY191cGRhdGVfY29lZl9pZHgoY29kZWMsIDB4NCwgMCwg
MTw8MTEpOwogfQpAQCAtNjEyNCwyOSArNjE5Niw2IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3Qgc25k
X2hkYV9waW5fcXVpcmsgYWxjNjYyX3Bpbl9maXh1cF90YmxbXSA9IHsKIAl7fQogfTsKIAotc3Rh
dGljIHZvaWQgYWxjNjYyX2ZpbGxfY29lZihzdHJ1Y3QgaGRhX2NvZGVjICpjb2RlYykKLXsKLQlp
bnQgY29lZjsKLQotCWNvZWYgPSBhbGNfZ2V0X2NvZWYwKGNvZGVjKTsKLQotCXN3aXRjaCAoY29k
ZWMtPnZlbmRvcl9pZCkgewotCWNhc2UgMHgxMGVjMDY2MjoKLQkJaWYgKChjb2VmICYgMHgwMGYw
KSA9PSAweDAwMzApCi0JCQlhbGNfdXBkYXRlX2NvZWZfaWR4KGNvZGVjLCAweDQsIDE8PDEwLCAw
KTsgLyogRUFQRCBDdHJsICovCi0JCWJyZWFrOwotCWNhc2UgMHgxMGVjMDI3MjoKLQljYXNlIDB4
MTBlYzAyNzM6Ci0JY2FzZSAweDEwZWMwNjYzOgotCWNhc2UgMHgxMGVjMDY2NToKLQljYXNlIDB4
MTBlYzA2NzA6Ci0JY2FzZSAweDEwZWMwNjcxOgotCWNhc2UgMHgxMGVjMDY3MjoKLQkJYWxjX3Vw
ZGF0ZV9jb2VmX2lkeChjb2RlYywgMHhkLCAwLCAxPDwxNCk7IC8qIEVBUEQgQ3RybCAqLwotCQli
cmVhazsKLQl9Ci19Ci0KIC8qCiAgKi8KIHN0YXRpYyBpbnQgcGF0Y2hfYWxjNjYyKHN0cnVjdCBo
ZGFfY29kZWMgKmNvZGVjKQpAQCAtNjE2OSwxMCArNjIxOCw2IEBAIHN0YXRpYyBpbnQgcGF0Y2hf
YWxjNjYyKHN0cnVjdCBoZGFfY29kZWMgKmNvZGVjKQogCWNhc2UgMHgxMGVjMDY2ODoKIAkJc3Bl
Yy0+aW5pdF9ob29rID0gYWxjNjY4X3Jlc3RvcmVfZGVmYXVsdF92YWx1ZTsKIAkJYnJlYWs7Ci0J
ZGVmYXVsdDoKLQkJc3BlYy0+aW5pdF9ob29rID0gYWxjNjYyX2ZpbGxfY29lZjsKLQkJYWxjNjYy
X2ZpbGxfY29lZihjb2RlYyk7Ci0JCWJyZWFrOwogCX0KIAogCXNuZF9oZGFfcGlja19maXh1cChj
b2RlYywgYWxjNjYyX2ZpeHVwX21vZGVscywK

--_002_6FAB7C47BCF00940BB0999A99BE3547A179FB052RTITMBSV09realt_
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--_002_6FAB7C47BCF00940BB0999A99BE3547A179FB052RTITMBSV09realt_--
