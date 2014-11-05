From: Kailang <kailang@realtek.com>
Subject: Re: Restore hidden register for default value
Date: Wed, 5 Nov 2014 07:20:06 +0000
Message-ID: <6FAB7C47BCF00940BB0999A99BE3547A179FAAFE@RTITMBSV09.realtek.com.tw>
References: <6FAB7C47BCF00940BB0999A99BE3547A179F9CEA@RTITMBSV09.realtek.com.tw>
 <s5hr3y0cz5k.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="_002_6FAB7C47BCF00940BB0999A99BE3547A179FAAFERTITMBSV09realt_"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id 7A0712619DD
 for <alsa-devel@alsa-project.org>; Wed,  5 Nov 2014 08:20:13 +0100 (CET)
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

--_002_6FAB7C47BCF00940BB0999A99BE3547A179FAAFERTITMBSV09realt_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

 Hi Takashi,

 I mail it again.

BR,
Kailang

> -----Original Message-----
> From: Kailang=20
> Sent: Friday, October 31, 2014 3:12 PM
> To: 'Takashi Iwai'
> Cc: (alsa-devel@alsa-project.org)
> Subject: RE: Restore hidden register for default value
>=20
> Hi Takashi,
>=20
> It's just the default value refill in initial state.
> It's only for ALC668(ALC3661).
> The patch was tested pass with issue machine in ODM site.
>=20
> Many Thanks.
>=20
> BR,
> Kailang
>=20
> > -----Original Message-----
> > From: Takashi Iwai [mailto:tiwai@suse.de]
> > Sent: Wednesday, October 22, 2014 4:00 PM
> > To: Kailang
> > Subject: Re: Restore hidden register for default value
> >=20
> > At Wed, 22 Oct 2014 07:56:43 +0000,
> > Kailang wrote:
> > >=20
> > > Hi Takashi,
> > >=20
> > > We want to post ALC668 for hidden register issue.
> > >=20
> > > Could I post like below array for codec initial state?
> > >=20
> > > WORD coefIndexDefault[][2] =3D {{0x1,
> > 0xbebe},{0x2,0xaaaa},{0x3,0x0},{0x4,0x180},{0x6,0x0},
> > >          =20
> > {0x7,0xf80},{0x8,0x31},{0xa,0x60},{0xb,0x0},{0xc,0x7cf7},{0xd,
> >  0x1080},{0xe,0x7f7f},
> > >          =20
> > {0xf,0xcccc},{0x10,0xddcc},{0x11,0x1},{0x13,0x0},{0x14,0x2aa0}
> > ,{0x17,0xA940},
> > >          =20
> > {0x19,0},{0x1A,0},{0x1B,0},{0x1c,0x0},{0x1d,0x0},{0x1e,0x7418}
> > ,{0x1f,0x804},
> > >          =20
> > {0x20,0x4200},{0x21,0x468},{0x22,0x8ccc},{0x23,0x250},{0x24,0x7418},
> > >          =20
> > >=20
> >=20
> {0x27,0x0000},{0x28,0x8ccc},{0x2a,0xff00},{0x2b,0x8000},{0xa7,0xff00}}
> > > ; Because codec sometimes has wrong value for hidden=20
> register after=20
> > > resume back or reboot.
> > > It needed to refill the default value with upper array in
> > initial state.
> > > But the hidden registers was more for 59 records.
> > > Could I post it with no remark? Because it just the default
> > value. Thanks.
> >=20
> > Some comments would be nice, of course, but not mandatory.
> >=20
> > One concern is exactly which codecs should this be applied. =20
> > There are a bunch of codecs compatible with alc668.  It's only for=20
> > ALC668, and not for others (ALC668, 670, whatever).
> >=20
> >=20
> > Takashi
> >=20
> > ------Please consider the environment before printing this e-mail.
> > =

--_002_6FAB7C47BCF00940BB0999A99BE3547A179FAAFERTITMBSV09realt_
Content-Type: application/octet-stream;
	name="0000-alc668-restore-default.patch"
Content-Description: 0000-alc668-restore-default.patch
Content-Disposition: attachment;
	filename="0000-alc668-restore-default.patch"; size=2940;
	creation-date="Fri, 24 Oct 2014 08:30:14 GMT";
	modification-date="Fri, 31 Oct 2014 07:03:36 GMT"
Content-Transfer-Encoding: base64

RnJvbSAxNzM5ZGZjOGQ1NGUwYzVhNzQ3YTAwZWJmODQ5ZTMzNWY3MmU5MTdhIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBLYWlsYW5nIFlhbmcgPGthaWxhbmdAcmVhbHRlay5jb20+CkRh
dGU6IEZyaSwgMjQgT2N0IDIwMTQgMTU6NDM6NDYgKzA4MDAKU3ViamVjdDogW1BBVENIXSBBTFNB
OiBoZGEvcmVhbHRlayAtIFJlc3RvcmUgZGVmYXVsdCB2YWx1ZSBmb3IgQUxDNjY4CgpSZXN0b3Jl
IHRoZSByZWdpc3RlcnMgdG8gcHJldmVudCB0aGUgYWJub3JtYWwgZGlnaXRhbCBwb3dlciBzdXBw
bHkKcmlzaW5nIHJhdGlvL3NlcXVlbmNlIHRvIHRoZSBjb2RlYyBhbmQgY2F1c2luZyB0aGUgaW5j
b3JyZWN0IGRlZmF1bHQKY29kZWMgcmVnaXN0ZXIgcmVzdG9yYXRpb24gZHVyaW5nIGluaXRpYWxp
emF0aW9uLgoKU2lnbmVkLW9mZi1ieTogS2FpbGFuZyBZYW5nIDxrYWlsYW5nQHJlYWx0ZWsuY29t
PgoKZGlmZiAtLWdpdCBhL3NvdW5kL3BjaS9oZGEvcGF0Y2hfcmVhbHRlay5jIGIvc291bmQvcGNp
L2hkYS9wYXRjaF9yZWFsdGVrLmMKaW5kZXggMzRiN2JkYi4uNzUxMWE4MiAxMDA2NDQKLS0tIGEv
c291bmQvcGNpL2hkYS9wYXRjaF9yZWFsdGVrLmMKKysrIGIvc291bmQvcGNpL2hkYS9wYXRjaF9y
ZWFsdGVrLmMKQEAgLTU2NTAsNiArNTY1MCwzNSBAQCBzdGF0aWMgdm9pZCBhbGM2NjJfZml4dXBf
bGVkX2dwaW8xKHN0cnVjdCBoZGFfY29kZWMgKmNvZGVjLAogCX0KIH0KIAorc3RhdGljIHN0cnVj
dCBjb2VmX2Z3IGFsYzY2OF9jb2Vmc1tdID0geworCVdSSVRFX0NPRUYoMHgwMSwgMHhiZWJlKSwg
V1JJVEVfQ09FRigweDAyLCAweGFhYWEpLCBXUklURV9DT0VGKDB4MDMsICAgIDB4MCksCisJV1JJ
VEVfQ09FRigweDA0LCAweDAxODApLCBXUklURV9DT0VGKDB4MDYsICAgIDB4MCksIFdSSVRFX0NP
RUYoMHgwNywgMHgwZjgwKSwKKwlXUklURV9DT0VGKDB4MDgsIDB4MDAzMSksIFdSSVRFX0NPRUYo
MHgwYSwgMHgwMDYwKSwgV1JJVEVfQ09FRigweDBiLCAgICAweDApLAorCVdSSVRFX0NPRUYoMHgw
YywgMHg3Y2Y3KSwgV1JJVEVfQ09FRigweDBkLCAweDEwODApLCBXUklURV9DT0VGKDB4MGUsIDB4
N2Y3ZiksCisJV1JJVEVfQ09FRigweDBmLCAweGNjY2MpLCBXUklURV9DT0VGKDB4MTAsIDB4ZGRj
YyksIFdSSVRFX0NPRUYoMHgxMSwgMHgwMDAxKSwKKwlXUklURV9DT0VGKDB4MTMsICAgIDB4MCks
IFdSSVRFX0NPRUYoMHgxNCwgMHgyYWEwKSwgV1JJVEVfQ09FRigweDE3LCAweGE5NDApLAorCVdS
SVRFX0NPRUYoMHgxOSwgICAgMHgwKSwgV1JJVEVfQ09FRigweDFhLCAgICAweDApLCBXUklURV9D
T0VGKDB4MWIsICAgIDB4MCksCisJV1JJVEVfQ09FRigweDFjLCAgICAweDApLCBXUklURV9DT0VG
KDB4MWQsICAgIDB4MCksIFdSSVRFX0NPRUYoMHgxZSwgMHg3NDE4KSwKKwlXUklURV9DT0VGKDB4
MWYsIDB4MDgwNCksIFdSSVRFX0NPRUYoMHgyMCwgMHg0MjAwKSwgV1JJVEVfQ09FRigweDIxLCAw
eDA0NjgpLAorCVdSSVRFX0NPRUYoMHgyMiwgMHg4Y2NjKSwgV1JJVEVfQ09FRigweDIzLCAweDAy
NTApLCBXUklURV9DT0VGKDB4MjQsIDB4NzQxOCksCisJV1JJVEVfQ09FRigweDI3LCAgICAweDAp
LCBXUklURV9DT0VGKDB4MjgsIDB4OGNjYyksIFdSSVRFX0NPRUYoMHgyYSwgMHhmZjAwKSwKKwlX
UklURV9DT0VGKDB4MmIsIDB4ODAwMCksIFdSSVRFX0NPRUYoMHhhNywgMHhmZjAwKSwgV1JJVEVf
Q09FRigweGE4LCAweDgwMDApLAorCVdSSVRFX0NPRUYoMHhhYSwgMHgyZTE3KSwgV1JJVEVfQ09F
RigweGFiLCAweGEwYzApLCBXUklURV9DT0VGKDB4YWMsICAgIDB4MCksCisJV1JJVEVfQ09FRigw
eGFkLCAgICAweDApLCBXUklURV9DT0VGKDB4YWUsIDB4MmFjNiksIFdSSVRFX0NPRUYoMHhhZiwg
MHhhNDgwKSwKKwlXUklURV9DT0VGKDB4YjAsICAgIDB4MCksIFdSSVRFX0NPRUYoMHhiMSwgICAg
MHgwKSwgV1JJVEVfQ09FRigweGIyLCAgICAweDApLAorCVdSSVRFX0NPRUYoMHhiMywgICAgMHgw
KSwgV1JJVEVfQ09FRigweGI0LCAgICAweDApLCBXUklURV9DT0VGKDB4YjUsIDB4MTA0MCksCisJ
V1JJVEVfQ09FRigweGI2LCAweGQ2OTcpLCBXUklURV9DT0VGKDB4YjcsIDB4OTAyYiksIFdSSVRF
X0NPRUYoMHhiOCwgMHhkNjk3KSwKKwlXUklURV9DT0VGKDB4YjksIDB4OTAyYiksIFdSSVRFX0NP
RUYoMHhiYSwgMHhiOGJhKSwgV1JJVEVfQ09FRigweGJiLCAweGFhYWIpLAorCVdSSVRFX0NPRUYo
MHhiYywgMHhhYWFmKSwgV1JJVEVfQ09FRigweGJkLCAweDZhYWEpLCBXUklURV9DT0VGKDB4YmUs
IDB4MWMwMiksCisJV1JJVEVfQ09FRigweGMwLCAweDAwZmYpLCBXUklURV9DT0VGKDB4YzEsIDB4
MGZhNiksCisJe30KK307CisKK3N0YXRpYyB2b2lkIGFsYzY2OF9yZXN0b3JlX2RlZmF1bHRfdmFs
dWUoc3RydWN0IGhkYV9jb2RlYyAqY29kZWMpCit7CisJYWxjX3Byb2Nlc3NfY29lZl9mdyhjb2Rl
YywgYWxjNjY4X2NvZWZzKTsKK30KKwogZW51bSB7CiAJQUxDNjYyX0ZJWFVQX0FTUElSRSwKIAlB
TEM2NjJfRklYVVBfTEVEX0dQSU8xLApAQCAtNjEyOSw2ICs2MTU4LDEyIEBAIHN0YXRpYyBpbnQg
cGF0Y2hfYWxjNjYyKHN0cnVjdCBoZGFfY29kZWMgKmNvZGVjKQogCWlmIChoYXNfY2RlZmluZV9i
ZWVwKGNvZGVjKSkKIAkJc3BlYy0+Z2VuLmJlZXBfbmlkID0gMHgwMTsKIAorCXN3aXRjaCAoY29k
ZWMtPnZlbmRvcl9pZCkgeworCWNhc2UgMHgxMGVjMDY2ODoKKwkJc3BlYy0+aW5pdF9ob29rID0g
YWxjNjY4X3Jlc3RvcmVfZGVmYXVsdF92YWx1ZTsKKwkJYnJlYWs7CisJfQorCiAJaWYgKChhbGNf
Z2V0X2NvZWYwKGNvZGVjKSAmICgxIDw8IDE0KSkgJiYKIAkgICAgY29kZWMtPmJ1cy0+cGNpICYm
IGNvZGVjLT5idXMtPnBjaS0+c3Vic3lzdGVtX3ZlbmRvciA9PSAweDEwMjUgJiYKIAkgICAgc3Bl
Yy0+Y2RlZmluZS5wbGF0Zm9ybV90eXBlID09IDEpIHsK

--_002_6FAB7C47BCF00940BB0999A99BE3547A179FAAFERTITMBSV09realt_
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--_002_6FAB7C47BCF00940BB0999A99BE3547A179FAAFERTITMBSV09realt_--
