Return-Path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id 12BD4265B97
 for <alsa-devel@alsa-project.org>; Wed,  5 Aug 2015 10:13:38 +0200 (CEST)
From: Kailang <kailang@realtek.com>
Date: Wed, 5 Aug 2015 08:13:33 +0000
Message-ID: <6FAB7C47BCF00940BB0999A99BE3547A17A1F7A4@RTITMBSV09.realtek.com.tw>
References: <6FAB7C47BCF00940BB0999A99BE3547A17A1F778@RTITMBSV09.realtek.com.tw>
 <s5hh9oeb4qy.wl-tiwai@suse.de>
 <6FAB7C47BCF00940BB0999A99BE3547A17A1F78C@RTITMBSV09.realtek.com.tw>
 <s5hd1z2b3wh.wl-tiwai@suse.de>
In-Reply-To: <s5hd1z2b3wh.wl-tiwai@suse.de>
Content-Language: zh-TW
Content-Type: multipart/mixed;
 boundary="_002_6FAB7C47BCF00940BB0999A99BE3547A17A1F7A4RTITMBSV09realt_"
MIME-Version: 1.0
Subject: Re: [alsa-devel] Verb for 0x17 pin config
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
List-ID: <alsa-devel@alsa-project.org>

--_002_6FAB7C47BCF00940BB0999A99BE3547A17A1F7A4RTITMBSV09realt_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable


Hi Takashi,

Update patch as attach.
Thanks.

BR,
Kailang
=20

> -----Original Message-----
> From: Takashi Iwai [mailto:tiwai@suse.de]=20
> Sent: Wednesday, August 05, 2015 3:17 PM
> To: Kailang
> Cc: (alsa-devel@alsa-project.org)
> Subject: Re: Verb for 0x17 pin config
>=20
> On Wed, 05 Aug 2015 09:07:06 +0200,
> Kailang wrote:
> >=20
> > =20
> >=20
> > > -----Original Message-----
> > > From: Takashi Iwai [mailto:tiwai@suse.de]
> > > Sent: Wednesday, August 05, 2015 2:59 PM
> > > To: Kailang
> > > Cc: (alsa-devel@alsa-project.org)
> > > Subject: Re: Verb for 0x17 pin config
> > >=20
> > > On Wed, 05 Aug 2015 08:42:03 +0200,
> > > Kailang wrote:
> > > >=20
> > > > Hi Takashi,
> > > > =20
> > > > commit
> > > >=20
> > >=20
> http://git.kernel.org/cgit/linux/kernel/git/tiwai/sound.git/commit/?
> > > id
> > > > =3D977e627684df0f60bdf2a768ec4772f42fe843fc
> > > > ALSA: hda/realtek - Support Dell headset mode for ALC298
> > > >=20
> > > > Dell had use verb to do speaker preset. So, The same SSID
> > > maybe 0x17 verb was different.
> > > >=20
> > > > 0x17 0x90170110
> > > > 0x17 0x90170140
> > > > 0x17 0x90170150
> > > >=20
> > > > Upper verb will show on this case.
> > > >=20
> > > > Could I change it to quirk for SSID?
> > >=20
> > > It would be one option.  OTOH, right now we have a patch to add=20
> > > 0x90170110, so the only missing is 0x90170150.  Just=20
> adding it would=20
> > > be an easier option, I suppose.
> > >=20
> > So, you mean I add as below patch.
> >=20
> > +	SND_HDA_PIN_QUIRK(0x10ec0298, 0x1028, "Dell",=20
> ALC298_FIXUP_DELL1_MIC_NO_PRESENCE,
> > +		ALC298_STANDARD_PINS,
> > +		{0x12, 0x90a60130},
> > +		{0x13, 0x40000000},
> > +		{0x14, 0x411111f0},
> > +		{0x17, 0x90170110},
> > +		{0x1d, 0x4068a36d},
> > +		{0x21, 0x03211020}),
> >=20
> > +	SND_HDA_PIN_QUIRK(0x10ec0298, 0x1028, "Dell",=20
> ALC298_FIXUP_DELL1_MIC_NO_PRESENCE,
> > +		ALC298_STANDARD_PINS,
> > +		{0x12, 0x90a60130},
> > +		{0x13, 0x40000000},
> > +		{0x14, 0x411111f0},
> > +		{0x17, 0x90170150},
> > +		{0x1d, 0x4068a36d},
> > +		{0x21, 0x03211020}),
> >=20
> > Right?
>=20
> With the latest code, only the following would be needed:
>=20
> @@ -5579,6 +5579,9 @@ static const struct snd_hda_pin_quirk=20
> alc269_pin_fixup_tbl[] =3D {
>  	SND_HDA_PIN_QUIRK(0x10ec0298, 0x1028, "Dell",=20
> ALC298_FIXUP_DELL1_MIC_NO_PRESENCE,
>  		ALC298_STANDARD_PINS,
>  		{0x17, 0x90170110}),
> +	SND_HDA_PIN_QUIRK(0x10ec0298, 0x1028, "Dell",=20
> ALC298_FIXUP_DELL1_MIC_NO_PRESENCE,
> +		ALC298_STANDARD_PINS,
> +		{0x17, 0x90170150}),
>  	{}
>  };
> =20
>=20
> Takashi
>=20
> ------Please consider the environment before printing this e-mail.
> =

--_002_6FAB7C47BCF00940BB0999A99BE3547A17A1F7A4RTITMBSV09realt_
Content-Type: application/octet-stream;
	name="0000-new-verb-for-dell-headset-mode-for-alc298.patch"
Content-Description: 0000-new-verb-for-dell-headset-mode-for-alc298.patch
Content-Disposition: attachment;
	filename="0000-new-verb-for-dell-headset-mode-for-alc298.patch"; size=945;
	creation-date="Wed, 05 Aug 2015 08:12:51 GMT";
	modification-date="Wed, 05 Aug 2015 08:11:24 GMT"
Content-Transfer-Encoding: base64

RnJvbSA4NmI1MjU1NmJhMTFkOGMxYTBhOWNiMGZlMDVkZjFlZDJlODI0Y2ZiIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBLYWlsYW5nIFlhbmcgPGthaWxhbmdAcmVhbHRlay5jb20+CkRh
dGU6IFdlZCwgNSBBdWcgMjAxNSAxNTo1Mjo0OCArMDgwMApTdWJqZWN0OiBbUEFUQ0hdIEFMU0E6
IGhkYS9yZWFsdGVrIC0gQWRkIG1vcmUgcXVpcmsgZm9yIERlbGwgaGVhZHNldCBtb2RlIGZvcgog
QUxDMjk4CgpBZGQgMHgxNyAweDkwMTcwMTEwIGFuZCAweDkwMTcwMTUwIGZvciBxdWlyay4KCmNv
bW1pdCA5NzdlNjI3Njg0ZGYwZjYwYmRmMmE3NjhlYzQ3NzJmNDJmZTg0M2ZjCgpTaWduZWQtb2Zm
LWJ5OiBLYWlsYW5nIFlhbmcgPGthaWxhbmdAcmVhbHRlay5jb20+CgpkaWZmIC0tZ2l0IGEvc291
bmQvcGNpL2hkYS9wYXRjaF9yZWFsdGVrLmMgYi9zb3VuZC9wY2kvaGRhL3BhdGNoX3JlYWx0ZWsu
YwppbmRleCBiMjBmMTA0Li42Mzc4YWI1IDEwMDY0NAotLS0gYS9zb3VuZC9wY2kvaGRhL3BhdGNo
X3JlYWx0ZWsuYworKysgYi9zb3VuZC9wY2kvaGRhL3BhdGNoX3JlYWx0ZWsuYwpAQCAtNTU3Myw2
ICs1NTczLDEwIEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3Qgc25kX2hkYV9waW5fcXVpcmsgYWxjMjY5
X3Bpbl9maXh1cF90YmxbXSA9IHsKIAkJezB4MTIsIDB4OTBhNjAxMzB9LAogCQl7MHgxNywgMHg5
MDE3MDE0MH0sCiAJCXsweDIxLCAweDAzMjExMDIwfSksCisJU05EX0hEQV9QSU5fUVVJUksoMHgx
MGVjMDI5OCwgMHgxMDI4LCAiRGVsbCIsIEFMQzI5OF9GSVhVUF9ERUxMMV9NSUNfTk9fUFJFU0VO
Q0UsCisJCXsweDE3LCAweDkwMTcwMTEwfSksCisJU05EX0hEQV9QSU5fUVVJUksoMHgxMGVjMDI5
OCwgMHgxMDI4LCAiRGVsbCIsIEFMQzI5OF9GSVhVUF9ERUxMMV9NSUNfTk9fUFJFU0VOQ0UsCisJ
CXsweDE3LCAweDkwMTcwMTUwfSksCiAJe30KIH07CiAK

--_002_6FAB7C47BCF00940BB0999A99BE3547A17A1F7A4RTITMBSV09realt_
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--_002_6FAB7C47BCF00940BB0999A99BE3547A17A1F7A4RTITMBSV09realt_--
