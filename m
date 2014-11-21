From: Kailang <kailang@realtek.com>
Subject: Re: HP mute led for ALC286
Date: Fri, 21 Nov 2014 07:56:29 +0000
Message-ID: <6FAB7C47BCF00940BB0999A99BE3547A179FBA32@RTITMBSV09.realtek.com.tw>
References: <s5hr3x9qz5j.wl-tiwai@suse.de>
 <6FAB7C47BCF00940BB0999A99BE3547A179FB004@RTITMBSV09.realtek.com.tw>
 <s5h8ujgrext.wl-tiwai@suse.de>
 <6FAB7C47BCF00940BB0999A99BE3547A179FB7CA@RTITMBSV09.realtek.com.tw>
 <s5h8uj71lci.wl-tiwai@suse.de>
 <6FAB7C47BCF00940BB0999A99BE3547A179FB92A@RTITMBSV09.realtek.com.tw>
 <s5htx1uxk3l.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="_002_6FAB7C47BCF00940BB0999A99BE3547A179FBA32RTITMBSV09realt_"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id A844B265B51
 for <alsa-devel@alsa-project.org>; Fri, 21 Nov 2014 08:56:48 +0100 (CET)
In-Reply-To: <s5htx1uxk3l.wl-tiwai@suse.de>
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

--_002_6FAB7C47BCF00940BB0999A99BE3547A179FBA32RTITMBSV09realt_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi Takashi,

I'm sorry for that. Maybe I had not do git pull.

BR,
Kailang
=20
> -----Original Message-----
> From: Takashi Iwai [mailto:tiwai@suse.de]=20
> Sent: Thursday, November 20, 2014 6:06 PM
> To: Kailang
> Cc: (alsa-devel@alsa-project.org)
> Subject: Re: HP mute led for ALC286
>=20
> At Thu, 20 Nov 2014 07:04:01 +0000,
> Kailang wrote:
> >=20
> > =20
> >=20
> > > -----Original Message-----
> > > From: Takashi Iwai [mailto:tiwai@suse.de]
> > > Sent: Wednesday, November 19, 2014 7:28 PM
> > > To: Kailang
> > > Cc: (alsa-devel@alsa-project.org)
> > > Subject: Re: HP mute led for ALC286
> > >=20
> > > At Wed, 19 Nov 2014 07:13:16 +0000,
> > > Kailang wrote:
> > > >=20
> > > > Hi Takashi,
> > > >=20
> > > > I had sent the discussion mail about the DMI string for HP.
> > > > But no body response.
> > > > So, I just send the patch to fix this issue.
> > >=20
> > > I'd like to avoid the duplicated open codes, so could you try the=20
> > > patch below and rewrite your patch to follow this?  You'd=20
> just need=20
> > > to set like:
> > >   spec->gpio_mute_led_mask =3D 0x02;
> > >   spec->gpio_mic_led_mask =3D 0x20;
> > >   pec->mute_led_polarity =3D 0;
> > > then you can use the existing alc_fixup_gpio_mute_hook and=20
> > > alc_fixup_gpio_mic_mute_hook.
> >=20
> > I modified as attach patch. ^^
>=20
> Oh, no, I meant an additional patch on top of my previous=20
> patch, not folding into that one.
>=20
> For your ease, I applied my patch to for-next branch now, so=20
> that you can rewrite the patch to be applicable to there.
>=20
>=20
> thanks,
>=20
> Takashi
>=20
> ------Please consider the environment before printing this e-mail.
> =

--_002_6FAB7C47BCF00940BB0999A99BE3547A179FBA32RTITMBSV09realt_
Content-Type: application/octet-stream;
	name="0002-supported-HP-mute-led-alc286.patch"
Content-Description: 0002-supported-HP-mute-led-alc286.patch
Content-Disposition: attachment;
	filename="0002-supported-HP-mute-led-alc286.patch"; size=2562;
	creation-date="Fri, 21 Nov 2014 07:53:46 GMT";
	modification-date="Fri, 21 Nov 2014 07:50:55 GMT"
Content-Transfer-Encoding: base64

RnJvbSBjODhiMjNjYWVlNjI4N2Y5YmU0ZWJlNGEzM2FkMGEzYTg2N2RmM2ExIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBLYWlsYW5nIFlhbmcgPGthaWxhbmdAcmVhbHRlay5jb20+CkRh
dGU6IEZyaSwgMjEgTm92IDIwMTQgMTU6NDk6MTEgKzA4MDAKU3ViamVjdDogW1BBVENIXSBBTFNB
OiBoZGEvcmVhbHRlayAtIFN1cHBvcnRlZCBIUCBtdXRlIExlZCBmb3IgQUxDMjg2CgpOZXcgSFAg
bWFjaGluZSBzdXBwb3J0ZWQgb3V0cHV0IG11dGUgbGVkIGFuZCBpbnB1dCBtdXRlIGxlZC4KQUxD
Mjg2OgpHUElPMSB0byBjb250cm9sIG91dHB1dCBtdXRlIGxlZC4KR1BJTzUgdG8gY29udHJvbCBp
bnB1dCBtdXRlIGxlZC4KClNpZ25lZC1vZmYtYnk6IEthaWxhbmcgWWFuZyA8a2FpbGFuZ0ByZWFs
dGVrLmNvbT4KCmRpZmYgLS1naXQgYS9zb3VuZC9wY2kvaGRhL3BhdGNoX3JlYWx0ZWsuYyBiL3Nv
dW5kL3BjaS9oZGEvcGF0Y2hfcmVhbHRlay5jCmluZGV4IGNkMDhkOGEuLjBjMWNhZDUgMTAwNjQ0
Ci0tLSBhL3NvdW5kL3BjaS9oZGEvcGF0Y2hfcmVhbHRlay5jCisrKyBiL3NvdW5kL3BjaS9oZGEv
cGF0Y2hfcmVhbHRlay5jCkBAIC0zMzc0LDYgKzMzNzQsMjcgQEAgc3RhdGljIHZvaWQgYWxjMjY5
X2ZpeHVwX2hwX2dwaW9fbGVkKHN0cnVjdCBoZGFfY29kZWMgKmNvZGVjLAogCX0KIH0KIAorc3Rh
dGljIHZvaWQgYWxjMjg2X2ZpeHVwX2hwX2dwaW9fbGVkKHN0cnVjdCBoZGFfY29kZWMgKmNvZGVj
LAorCQkJCWNvbnN0IHN0cnVjdCBoZGFfZml4dXAgKmZpeCwgaW50IGFjdGlvbikKK3sKKwlzdHJ1
Y3QgYWxjX3NwZWMgKnNwZWMgPSBjb2RlYy0+c3BlYzsKKwlzdGF0aWMgY29uc3Qgc3RydWN0IGhk
YV92ZXJiIGdwaW9faW5pdFtdID0geworCQl7IDB4MDEsIEFDX1ZFUkJfU0VUX0dQSU9fTUFTSywg
MHgyMiB9LAorCQl7IDB4MDEsIEFDX1ZFUkJfU0VUX0dQSU9fRElSRUNUSU9OLCAweDIyIH0sCisJ
CXt9CisJfTsKKworCWlmIChhY3Rpb24gPT0gSERBX0ZJWFVQX0FDVF9QUkVfUFJPQkUpIHsKKwkJ
c3BlYy0+Z2VuLnZtYXN0ZXJfbXV0ZS5ob29rID0gYWxjX2ZpeHVwX2dwaW9fbXV0ZV9ob29rOwor
CQlzcGVjLT5nZW4uY2FwX3N5bmNfaG9vayA9IGFsY19maXh1cF9ncGlvX21pY19tdXRlX2hvb2s7
CisJCXNwZWMtPmdwaW9fbGVkID0gMDsKKwkJc3BlYy0+bXV0ZV9sZWRfcG9sYXJpdHkgPSAwOwor
CQlzcGVjLT5ncGlvX211dGVfbGVkX21hc2sgPSAweDAyOworCQlzcGVjLT5ncGlvX21pY19sZWRf
bWFzayA9IDB4MjA7CisJCXNuZF9oZGFfYWRkX3ZlcmJzKGNvZGVjLCBncGlvX2luaXQpOworCX0K
K30KKwogLyogdHVybiBvbi9vZmYgbWljLW11dGUgTEVEIHBlciBjYXB0dXJlIGhvb2sgKi8KIHN0
YXRpYyB2b2lkIGFsYzI2OV9maXh1cF9ocF9jYXBfbWljX211dGVfaG9vayhzdHJ1Y3QgaGRhX2Nv
ZGVjICpjb2RlYywKIAkJCQkJICAgICAgIHN0cnVjdCBzbmRfa2NvbnRyb2wgKmtjb250cm9sLApA
QCAtNDMxMyw2ICs0MzM0LDcgQEAgZW51bSB7CiAJQUxDMjU1X0ZJWFVQX0RFTExfV01JX01JQ19N
VVRFX0xFRCwKIAlBTEMyODJfRklYVVBfQVNQSVJFX1Y1X1BJTlMsCiAJQUxDMjgwX0ZJWFVQX0hQ
X0dQSU80LAorCUFMQzI4Nl9GSVhVUF9IUF9HUElPX0xFRCwKIH07CiAKIHN0YXRpYyBjb25zdCBz
dHJ1Y3QgaGRhX2ZpeHVwIGFsYzI2OV9maXh1cHNbXSA9IHsKQEAgLTQ3ODIsNiArNDgwNCwxMCBA
QCBzdGF0aWMgY29uc3Qgc3RydWN0IGhkYV9maXh1cCBhbGMyNjlfZml4dXBzW10gPSB7CiAJCS50
eXBlID0gSERBX0ZJWFVQX0ZVTkMsCiAJCS52LmZ1bmMgPSBhbGMyODBfZml4dXBfaHBfZ3BpbzQs
CiAJfSwKKwlbQUxDMjg2X0ZJWFVQX0hQX0dQSU9fTEVEXSA9IHsKKwkJLnR5cGUgPSBIREFfRklY
VVBfRlVOQywKKwkJLnYuZnVuYyA9IGFsYzI4Nl9maXh1cF9ocF9ncGlvX2xlZCwKKwl9LAogfTsK
IAogc3RhdGljIGNvbnN0IHN0cnVjdCBzbmRfcGNpX3F1aXJrIGFsYzI2OV9maXh1cF90YmxbXSA9
IHsKQEAgLTQ4MjAsNiArNDg0Niw3IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3Qgc25kX3BjaV9xdWly
ayBhbGMyNjlfZml4dXBfdGJsW10gPSB7CiAJU05EX1BDSV9RVUlSSygweDEwM2MsIDB4MjI2YSwg
IkhQIiwgQUxDMjY5X0ZJWFVQX0hQX01VVEVfTEVEX01JQzEpLAogCVNORF9QQ0lfUVVJUksoMHgx
MDNjLCAweDIyNmIsICJIUCIsIEFMQzI2OV9GSVhVUF9IUF9NVVRFX0xFRF9NSUMxKSwKIAlTTkRf
UENJX1FVSVJLKDB4MTAzYywgMHgyMjZlLCAiSFAiLCBBTEMyNjlfRklYVVBfSFBfTVVURV9MRURf
TUlDMSksCisJU05EX1BDSV9RVUlSSygweDEwM2MsIDB4MjI3MSwgIkhQIiwgQUxDMjg2X0ZJWFVQ
X0hQX0dQSU9fTEVEKSwKIAlTTkRfUENJX1FVSVJLKDB4MTAzYywgMHgyMjllLCAiSFAiLCBBTEMy
NjlfRklYVVBfSFBfTVVURV9MRURfTUlDMSksCiAJU05EX1BDSV9RVUlSSygweDEwM2MsIDB4MjJi
MiwgIkhQIiwgQUxDMjY5X0ZJWFVQX0hQX01VVEVfTEVEX01JQzEpLAogCVNORF9QQ0lfUVVJUkso
MHgxMDNjLCAweDIyYjcsICJIUCIsIEFMQzI2OV9GSVhVUF9IUF9NVVRFX0xFRF9NSUMxKSwK

--_002_6FAB7C47BCF00940BB0999A99BE3547A179FBA32RTITMBSV09realt_
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--_002_6FAB7C47BCF00940BB0999A99BE3547A179FBA32RTITMBSV09realt_--
