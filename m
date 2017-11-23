From: Kailang <kailang@realtek.com>
Subject: Re: AMD Raven Platform
Date: Thu, 23 Nov 2017 07:41:29 +0000
Message-ID: <6FAB7C47BCF00940BB0999A99BE3547A183F9B11@RTITMBSV02.realtek.com.tw>
References: <6FAB7C47BCF00940BB0999A99BE3547A183F98A8@RTITMBSV02.realtek.com.tw>
 <s5htvxo6sot.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="_002_6FAB7C47BCF00940BB0999A99BE3547A183F9B11RTITMBSV02realt_"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
 by alsa0.perex.cz (Postfix) with ESMTP id EAE4526780B
 for <alsa-devel@alsa-project.org>; Thu, 23 Nov 2017 08:41:39 +0100 (CET)
In-Reply-To: <s5htvxo6sot.wl-tiwai@suse.de>
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

--_002_6FAB7C47BCF00940BB0999A99BE3547A183F9B11RTITMBSV02realt_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

=20
Hi Takashi,

Attach patch for fix AMD no sound issue.
It also could solve Intel ALC700 no sound issue.
Thanks.

BR,
Kailang

> -----Original Message-----
> From: Takashi Iwai [mailto:tiwai@suse.de]=20
> Sent: Tuesday, November 21, 2017 2:40 PM
> To: Kailang
> Subject: Re: AMD Raven Platform
>=20
> On Tue, 21 Nov 2017 04:13:16 +0100,
> Kailang wrote:
> >=20
> > Hi Takashi,
> >=20
> > AMD guys add below patch. To support their new HDA controller.
> > But it still no sound.
> > This platform codec is ALC701.
> > But ALC701 was worked with Intel platform on Intel site.
> > My test platform was ICH7. ALC701 and ICH7 was also worked=20
> on my site.
> >=20
> > I check alsa-info dump as attach file. It's very well.
> >=20
> > The patch that AMD guys assigned ATI_SB flag.
> > I think no sound issue maybe the HDA controller setting relation.
> >=20
> > Could you can find any difference?
>=20
> First off, if the main target is the onboard analog I/O, I'd=20
> pass index=3D1,0 option to snd-hda-intel module to swap the=20
> HDMI/DP and the analog I/O.  This will allow testing with the=20
> native ALSA API more easily.
>=20
> Did you pass need some COEF setups as we applied for Intel=20
> reference board?  There is even another patch that isn't=20
> still included to upstream (the difference is COEF 0x4a with=20
> bit 0x2000).
>=20
> In the controller side, one thing that comes to my mind about=20
> AMD is the PCI snooping.  Try AZX_DCAPS_PRESET_ATI_HDMI_NS=20
> instead as a test.
> The essential difference with this preset is=20
> AZX_DCAPS_SNOOP_OFF bits.  Other than that, the recent Intel=20
> chip requires the different slot assignment, and=20
> AZX_DCAPS_SEPARATE_STREAM_TAG is used.  But this is set=20
> automatically also when the number of streams is greater than=20
> 15, too.  (You'll see a warning.)
>=20
> Feel free to put me to Cc in the communication with AMD=20
> people directly.
>=20
>=20
> thanks,
>=20
> Takashi
>=20
> >=20
> > Many Thanks.
> > Kailang
> > --- a/sound/pci/hda/hda_intel.c
> > +++ b/sound/pci/hda/hda_intel.c
> > @@ -2454,6 +2454,8 @@ static const struct pci_device_id=20
> azx_ids[] =3D {
> >         /* AMD Hudson */
> >         { PCI_DEVICE(0x1022, 0x780d),
> >           .driver_data =3D AZX_DRIVER_GENERIC |=20
> AZX_DCAPS_PRESET_ATI_SB=20
> > },
> > +       { PCI_DEVICE(0x1022, 0x15e3),
> > +         .driver_data =3D AZX_DRIVER_GENERIC |=20
> AZX_DCAPS_PRESET_ATI_SB=20
> > + },
> >         /* ATI HDMI */
> >         { PCI_DEVICE(0x1002, 0x0002),
> >           .driver_data =3D AZX_DRIVER_ATIHDMI_NS |=20
> > AZX_DCAPS_PRESET_ATI_HDMI_NS },
>=20
> ------Please consider the environment before printing this e-mail.
> =

--_002_6FAB7C47BCF00940BB0999A99BE3547A183F9B11RTITMBSV02realt_
Content-Type: application/octet-stream; name="0000-alc700-no-sound.patch"
Content-Description: 0000-alc700-no-sound.patch
Content-Disposition: attachment; filename="0000-alc700-no-sound.patch";
	size=934; creation-date="Thu, 23 Nov 2017 07:38:23 GMT";
	modification-date="Wed, 22 Nov 2017 07:27:02 GMT"
Content-Transfer-Encoding: base64

RnJvbSBjOTVkYzFhYzU5OTBhZWU1MzEzODkzZGFhZmFiM2RkMjA1ZGM4NGYwIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBLYWlsYW5nIFlhbmcgPGthaWxhbmdAcmVhbHRlay5jb20+CkRh
dGU6IFdlZCwgMjIgTm92IDIwMTcgMTU6MjE6MzIgKzA4MDAKU3ViamVjdDogW1BBVENIXSBBTFNB
OiBoZGEvcmVhbHRlayAtIEZpeCBBTEM3MDAgZmFtaWx5IG5vIHNvdW5kIGlzc3VlCgpJdCBtYXli
ZSB0aGUgdHlwZSBmb3IgQUxDNzAwIHN1cHBvcnQgcGF0Y2guClRvIGZpeCB0aGUgYml0IHZhbHVl
IG9uIHRoaXMgcGF0Y2guCgpTaWduZWQtb2ZmLWJ5OiBLYWlsYW5nIFlhbmcgPGthaWxhbmdAcmVh
bHRlay5jb20+CgpkaWZmIC0tZ2l0IGEvc291bmQvcGNpL2hkYS9wYXRjaF9yZWFsdGVrLmMgYi9z
b3VuZC9wY2kvaGRhL3BhdGNoX3JlYWx0ZWsuYwppbmRleCA1YmI1NjIzLi45MjFhMTBlIDEwMDY0
NAotLS0gYS9zb3VuZC9wY2kvaGRhL3BhdGNoX3JlYWx0ZWsuYworKysgYi9zb3VuZC9wY2kvaGRh
L3BhdGNoX3JlYWx0ZWsuYwpAQCAtNjg5NCw3ICs2ODk0LDcgQEAgc3RhdGljIGludCBwYXRjaF9h
bGMyNjkoc3RydWN0IGhkYV9jb2RlYyAqY29kZWMpCiAJY2FzZSAweDEwZWMwNzAzOgogCQlzcGVj
LT5jb2RlY192YXJpYW50ID0gQUxDMjY5X1RZUEVfQUxDNzAwOwogCQlzcGVjLT5nZW4ubWl4ZXJf
bmlkID0gMDsgLyogQUxDNzAwIGRvZXMgbm90IGhhdmUgYW55IGxvb3BiYWNrIG1peGVyIHBhdGgg
Ki8KLQkJYWxjX3VwZGF0ZV9jb2VmX2lkeChjb2RlYywgMHg0YSwgMCwgMSA8PCAxNSk7IC8qIENv
bWJvIGphY2sgYXV0byB0cmlnZ2VyIGNvbnRyb2wgKi8KKwkJYWxjX3VwZGF0ZV9jb2VmX2lkeChj
b2RlYywgMHg0YSwgMSA8PCAxNSwgMCk7IC8qIENvbWJvIGphY2sgYXV0byB0cmlnZ2VyIGNvbnRy
b2wgKi8KIAkJYnJlYWs7CiAKIAl9Cg==

--_002_6FAB7C47BCF00940BB0999A99BE3547A183F9B11RTITMBSV02realt_
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--_002_6FAB7C47BCF00940BB0999A99BE3547A183F9B11RTITMBSV02realt_--
