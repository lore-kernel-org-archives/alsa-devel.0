From: Kailang <kailang@realtek.com>
Subject: Re: Add new Dell platform
Date: Wed, 24 Apr 2019 08:41:46 +0000
Message-ID: <6FAB7C47BCF00940BB0999A99BE3547A18DBE04F@RTITEXDAG02.realtek.com.tw>
References: <6FAB7C47BCF00940BB0999A99BE3547A18DBD75D@RTITEXDAG02.realtek.com.tw>
 <s5hlg04ocj1.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="_002_6FAB7C47BCF00940BB0999A99BE3547A18DBE04FRTITEXDAG02real_"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id AEB6FF89618
 for <alsa-devel@alsa-project.org>; Wed, 24 Apr 2019 10:41:58 +0200 (CEST)
In-Reply-To: <s5hlg04ocj1.wl-tiwai@suse.de>
Content-Language: zh-TW
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Takashi Iwai <tiwai@suse.de>
Cc: " (alsa-devel@alsa-project.org)" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

--_002_6FAB7C47BCF00940BB0999A99BE3547A18DBE04FRTITEXDAG02real_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi Takashi,

This two platform, the Dmic was connected to PCH.
So, codec will not fill verb on Dmic(0x12) pin.
Attach new patch for check Dmic.
ALC295 patch was not cover by others.

BR,
Kailang

> -----Original Message-----
> From: Takashi Iwai <tiwai@suse.de>
> Sent: Sunday, April 21, 2019 12:41 AM
> To: Kailang <kailang@realtek.com>
> Cc: (alsa-devel@alsa-project.org) <alsa-devel@alsa-project.org>
> Subject: Re: Add new Dell platform
>=20
> On Fri, 19 Apr 2019 10:41:02 +0200,
> Kailang wrote:
> >
> > Hi Takashi,
> >
> > Attach was enable patch for headset mode.
>=20
> Both should have been already covered by the recent patch from Hui.
> Please check the latest sound git tree.
>=20
>=20
> thanks,
>=20
> Takashi
>=20
> ------Please consider the environment before printing this e-mail.

--_002_6FAB7C47BCF00940BB0999A99BE3547A18DBE04FRTITEXDAG02real_
Content-Type: application/octet-stream; name="0001-new-dell-platform.patch"
Content-Description: 0001-new-dell-platform.patch
Content-Disposition: attachment; filename="0001-new-dell-platform.patch";
	size=1431; creation-date="Wed, 24 Apr 2019 08:36:01 GMT";
	modification-date="Wed, 24 Apr 2019 08:35:40 GMT"
Content-Transfer-Encoding: base64

RnJvbSBlYzMxMmM3MmIxMGQ5NDMzNzUxMTUxZWQwYjQ3ZWM4MzdlNjQ5MWQyIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBLYWlsYW5nIFlhbmcgPGthaWxhbmdAcmVhbHRlay5jb20+CkRh
dGU6IFdlZCwgMjQgQXByIDIwMTkgMTY6MzQ6MjUgKzA4MDAKU3ViamVjdDogW1BBVENIXSBBTFNB
OiBoZGEvcmVhbHRlayAtIEFkZCBuZXcgRGVsbCBwbGF0Zm9ybSBmb3IgaGVhZHNldCBtb2RlCgpB
ZGQgdHdvIERlbGwgcGxhdGZvcm0gZm9yIGhlYWRzZXQgbW9kZS4KClNpZ25lZC1vZmYtYnk6IEth
aWxhbmcgWWFuZyA8a2FpbGFuZ0ByZWFsdGVrLmNvbT4KCmRpZmYgLS1naXQgYS9zb3VuZC9wY2kv
aGRhL3BhdGNoX3JlYWx0ZWsuYyBiL3NvdW5kL3BjaS9oZGEvcGF0Y2hfcmVhbHRlay5jCmluZGV4
IGY1YjUxMGYxMTllZC4uMDcwNzQ5YjUwZWZmIDEwMDY0NAotLS0gYS9zb3VuZC9wY2kvaGRhL3Bh
dGNoX3JlYWx0ZWsuYworKysgYi9zb3VuZC9wY2kvaGRhL3BhdGNoX3JlYWx0ZWsuYwpAQCAtNzI2
OCw2ICs3MjY4LDEwIEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3Qgc25kX2hkYV9waW5fcXVpcmsgYWxj
MjY5X3Bpbl9maXh1cF90YmxbXSA9IHsKIAkJezB4MjEsIDB4MDIyMTEwMjB9KSwKIAlTTkRfSERB
X1BJTl9RVUlSSygweDEwZWMwMjM2LCAweDEwMjgsICJEZWxsIiwgQUxDMjU1X0ZJWFVQX0RFTEwx
X01JQ19OT19QUkVTRU5DRSwKIAkJezB4MjEsIDB4MDIyMTEwMjB9KSwKKwlTTkRfSERBX1BJTl9R
VUlSSygweDEwZWMwMjM2LCAweDEwMjgsICJEZWxsIiwgQUxDMjU1X0ZJWFVQX0RFTEwxX01JQ19O
T19QUkVTRU5DRSwKKwkJezB4MTIsIDB4NDAwMDAwMDB9LAorCQl7MHgxNCwgMHg5MDE3MDExMH0s
CisJCXsweDIxLCAweDAyMjExMDIwfSksCiAJU05EX0hEQV9QSU5fUVVJUksoMHgxMGVjMDI1NSwg
MHgxMDI4LCAiRGVsbCIsIEFMQzI1NV9GSVhVUF9ERUxMMl9NSUNfTk9fUFJFU0VOQ0UsCiAJCXsw
eDE0LCAweDkwMTcwMTEwfSwKIAkJezB4MjEsIDB4MDIyMTEwMjB9KSwKQEAgLTc1NDEsNiArNzU0
NSw5IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3Qgc25kX2hkYV9waW5fcXVpcmsgYWxjMjY5X3Bpbl9m
aXh1cF90YmxbXSA9IHsKIAkJezB4MTIsIDB4OTBhNjAxMzB9LAogCQl7MHgxNywgMHg5MDE3MDEx
MH0sCiAJCXsweDIxLCAweDA0MjExMDIwfSksCisJU05EX0hEQV9QSU5fUVVJUksoMHgxMGVjMDI5
NSwgMHgxMDI4LCAiRGVsbCIsIEFMQzI2OV9GSVhVUF9ERUxMMV9NSUNfTk9fUFJFU0VOQ0UsCisJ
CXsweDE0LCAweDkwMTcwMTEwfSwKKwkJezB4MjEsIDB4MDQyMTEwMjB9KSwKIAlTTkRfSERBX1BJ
Tl9RVUlSSygweDEwZWMwMjk1LCAweDEwMjgsICJEZWxsIiwgQUxDMjY5X0ZJWFVQX0RFTEwxX01J
Q19OT19QUkVTRU5DRSwKIAkJQUxDMjk1X1NUQU5EQVJEX1BJTlMsCiAJCXsweDE3LCAweDIxMDE0
MDIwfSwK

--_002_6FAB7C47BCF00940BB0999A99BE3547A18DBE04FRTITEXDAG02real_
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--_002_6FAB7C47BCF00940BB0999A99BE3547A18DBE04FRTITEXDAG02real_--
