From: Kailang <kailang@realtek.com>
Subject: Re: hp_pin was NULL value
Date: Tue, 29 Jan 2019 08:05:48 +0000
Message-ID: <6FAB7C47BCF00940BB0999A99BE3547A18DB7442@RTITMBSVM07.realtek.com.tw>
References: <6FAB7C47BCF00940BB0999A99BE3547A18420E8B@RTITMBSV02.realtek.com.tw>
 <s5htviigoa5.wl-tiwai@suse.de>
 <6FAB7C47BCF00940BB0999A99BE3547A18420EBD@RTITMBSV02.realtek.com.tw>
 <s5hlg3ux9x9.wl-tiwai@suse.de>
 <6FAB7C47BCF00940BB0999A99BE3547A184210B1@RTITMBSV02.realtek.com.tw>
 <s5hh8eah1fj.wl-tiwai@suse.de>
 <6FAB7C47BCF00940BB0999A99BE3547A184210E5@RTITMBSV02.realtek.com.tw>
 <s5h5zuqgxv2.wl-tiwai@suse.de>
 <6FAB7C47BCF00940BB0999A99BE3547A184210FC@RTITMBSV02.realtek.com.tw>
 <s5h1s5eguwz.wl-tiwai@suse.de>
 <6FAB7C47BCF00940BB0999A99BE3547A1842112F@RTITMBSV02.realtek.com.tw>
 <s5hwon6ffg9.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="_002_6FAB7C47BCF00940BB0999A99BE3547A18DB7442RTITMBSVM07real_"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
 by alsa0.perex.cz (Postfix) with ESMTP id 25F7626749A
 for <alsa-devel@alsa-project.org>; Tue, 29 Jan 2019 09:05:53 +0100 (CET)
In-Reply-To: <s5hwon6ffg9.wl-tiwai@suse.de>
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

--_002_6FAB7C47BCF00940BB0999A99BE3547A18DB7442RTITMBSVM07real_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi Takashi,

I ask our AE for this function.
We also prefer to run it only one time on boot time. S3 resume back not nee=
d to run this function.
Because it will take about 650ms times to initial.

Attach was the new patch.
Reject commit or use attach patch to commit. Which is better?

BR,
Kailang

-----Original Message-----
From: Takashi Iwai <tiwai@suse.de>=20
Sent: Tuesday, January 15, 2019 5:17 PM
To: Kailang <kailang@realtek.com>
Cc: (alsa-devel@alsa-project.org) <alsa-devel@alsa-project.org>
Subject: Re: hp_pin was NULL value

On Tue, 15 Jan 2019 10:06:58 +0100,
Kailang wrote:
>=20
> >>>Is it about that alc225_hp_init() gets called at resume in addition to=
 the boot time?
>=20
> alc225_hp_init() =3D=3D> it only need to call one time at boot time.
> This HP initial code doesn't need to call at resume.
> If system boot, HP initial code just need to call it at boot time.
> S3 state was not need to call this function.

But S4 resume must call this function: that's my point.

So the question is whether calling alc225_hp_init() at S3 resume is signifi=
cantly harmful or not.  If not, we can move it there.  If it's harmful, we =
need to distinguish S3 and S4, and introduce either some flag or a new call=
back, which will be a much more work than simply patching the codec code.


thanks,

Takashi

> Sorry!! Maybe I describe it confuse you.
>=20
> -----Original Message-----
> From: Takashi Iwai <tiwai@suse.de>
> Sent: Tuesday, January 15, 2019 4:58 PM
> To: Kailang <kailang@realtek.com>
> Cc: (alsa-devel@alsa-project.org) <alsa-devel@alsa-project.org>
> Subject: Re: hp_pin was NULL value
>=20
> On Tue, 15 Jan 2019 09:17:24 +0100,
> Kailang wrote:
> >=20
> >=20
> > Hi Takashi,
> >=20
> > Sorry!! Maybe I don't understand what you mean.=09
> > Please see below.
> >=20
> > --- patch_realtek.c.orig	2019-01-11 16:28:43.745957854 +0800
> > +++ patch_realtek.c	2019-01-15 16:09:56.017873567 +0800
> > @@ -3221,12 +3221,29 @@ static void alc256_shutup(struct hda_cod
> >  	snd_hda_shutup_pins(codec);
> >  }
> > =20
> > +static void alc225_hp_init(struct hda_codec *codec) {
> > +	struct alc_spec *spec =3D codec->spec;
> > +	hda_nid_t hp_pin =3D spec->gen.autocfg.hp_pins[0];
> > +	int i, val;
> > +	int coef38, coef0d, coef36;
> > +	printk("%s-start hp=3D0x%x\n",__func__,hp_pin);
> > +	if (!hp_pin)
> > +		return;
> > +
> > +	alc_update_coef_idx(codec, 0x4a, 1<<15, 1<<15);
> > +	msleep(50);
> > +	alc_update_coef_idx(codec, 0x4a, 1<<15, 0);
> > +	printk("%s-end hp=3D0x%x\n",__func__,hp_pin); }
> > +
> >  static void alc225_init(struct hda_codec *codec)  {
> >  	struct alc_spec *spec =3D codec->spec;
> >  	hda_nid_t hp_pin =3D spec->gen.autocfg.hp_pins[0];
> >  	bool hp1_pin_sense, hp2_pin_sense;
> > =20
> > +	alc225_hp_init(codec);
> >  	if (!hp_pin)
> >  		return;
> > =20
> > @@ -3262,6 +3279,7 @@ static void alc225_init(struct hda_codec
> > =20
> >  	alc_update_coef_idx(codec, 0x4a, 3 << 10, 0);
> >  	alc_update_coefex_idx(codec, 0x57, 0x04, 0x0007, 0x4); /* Hight=20
> > power */
> > +	printk("%s hp=3D0x%x\n",__func__,hp_pin);
> >  }
>=20
> ... and I don't understand what's your problem.
>=20
> Is it about that alc255_hp_init() gets called at resume in addition to th=
e boot time?  If so, this is the intended behavior.
>=20
>=20
> thanks,
>=20
> Takashi
>=20
> >=20
> > -----Original Message-----
> > From: Takashi Iwai <tiwai@suse.de>
> > Sent: Tuesday, January 15, 2019 3:54 PM
> > To: Kailang <kailang@realtek.com>
> > Cc: (alsa-devel@alsa-project.org) <alsa-devel@alsa-project.org>
> > Subject: Re: hp_pin was NULL value
> >=20
> > On Tue, 15 Jan 2019 08:43:40 +0100,
> > Kailang wrote:
> > >=20
> > >=20
> > > No, it not expected.
> > > It will enter two times after boot ready.
> > > I think it could add a flag in alc225_hp_init().=20
> > > To make sure it only excute one time. How do you think about?
> >=20
> > Where was it called, actually?  The call of patch_ops.init is found in =
several places: once in snd_hda_codec_build_controls() just before creating=
 controls (which is the boot time init), and at resume, alc269_resume().
> >=20
> > And, as already explained, we have to call this at resume, because it's=
 not guaranteed that it's been already called in the case of hibernation.
> >=20
> >=20
> > thanks,
> >=20
> > Takashi
> >=20
> > >=20
> > > -----Original Message-----
> > > From: Takashi Iwai <tiwai@suse.de>
> > > Sent: Tuesday, January 15, 2019 2:37 PM
> > > To: Kailang <kailang@realtek.com>
> > > Cc: (alsa-devel@alsa-project.org) <alsa-devel@alsa-project.org>
> > > Subject: Re: hp_pin was NULL value
> > >=20
> > > On Tue, 15 Jan 2019 03:31:33 +0100, Kailang wrote:
> > > >=20
> > > > Hi Takashi,
> > > >=20
> > > > Could you receive this email?
> > > >=20
> > > > BR,
> > > > Kailang
> > > >=20
> > > > -----Original Message-----
> > > > From: Kailang
> > > > Sent: Thursday, January 10, 2019 11:14 AM
> > > > To: 'Takashi Iwai' <tiwai@suse.de>
> > > > Cc: (alsa-devel@alsa-project.org) <alsa-devel@alsa-project.org>
> > > > Subject: RE: hp_pin was NULL value
> > > >=20
> > > > Hi Takashi,
> > > >=20
> > > > I simulate test your prefer function.
> > > > I put alc225_hp_init() in alc225_init().
> > > > If system boot ready, I write 1 to power_save of /sys/module/....
> > > > The print message as below. It called two times until boot ready.
> > > > If System enter to power save, play stream will wake up codec. It a=
lso call alc225_hp_init().
> > > >=20
> > > > [   21.497524] alc225_init hp_pin=3D0x21
> > > > [   21.497526] alc225_hp_init-s hp=3D0x21
> > > > [   22.140076] alc225_hp_init-e hp=3D0x21
> > > > [   22.183496] snd_hda_codec_realtek hdaudioC0D2: Headset jack set =
to unplugged mode.
> > > > [   22.184681] snd_hda_codec_realtek hdaudioC0D2: Headset jack set =
to unplugged mode.
> > > > [   22.186846] alc225_shutup hp_pin=3D0x21
> > > > [   22.187831] input: HDA Intel Line Out as /devices/pci0000:00/000=
0:00:1b.0/sound/card0/input5
> > > > [   22.188055] input: HDA Intel Headphone as /devices/pci0000:00/00=
00:00:1b.0/sound/card0/input6
> > > > [   22.205104] alc225_init hp_pin=3D0x21
> > > > [   22.205108] alc225_hp_init-s hp=3D0x21
> > > > [   22.852123] alc225_hp_init-e hp=3D0x21
> > > > [   22.894772] snd_hda_codec_realtek hdaudioC0D2: Headset jack set =
to unplugged mode.
> > > > ############  Boot ready ############## [  116.832084]=20
> > > > alc225_shutup
> > > > hp_pin=3D0x21  =3D=3D> echo 1 to power_save
> > > > [  120.002582] alc225_init hp_pin=3D0x21     =3D=3D> play system so=
und
> > > > [  120.002586] alc225_hp_init-s hp=3D0x21 [  120.644128]=20
> > > > alc225_hp_init-e hp=3D0x21
> > >=20
> > > It wasn't clear to me whether you meant this as a success or a failur=
e...  Did the patch work as expected, no?
> > >=20
> > >=20
> > > thanks,
> > >=20
> > > Takashi
> > >=20
> > > ------Please consider the environment before printing this e-mail.
> > >=20
> >=20
>=20

--_002_6FAB7C47BCF00940BB0999A99BE3547A18DB7442RTITMBSVM07real_
Content-Type: application/octet-stream;
	name="0000-alc294-hp-init-again.patch"
Content-Description: 0000-alc294-hp-init-again.patch
Content-Disposition: attachment; filename="0000-alc294-hp-init-again.patch";
	size=3944; creation-date="Tue, 29 Jan 2019 07:41:08 GMT";
	modification-date="Tue, 29 Jan 2019 07:55:49 GMT"
Content-Transfer-Encoding: base64

RnJvbSBmYmI5NGEzNDUwMDQ4NDRhZDg4NThhMWNhZWNlMDAwNzEzYTRmOWNmIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBLYWlsYW5nIFlhbmcgPGthaWxhbmdAcmVhbHRlay5jb20+CkRh
dGU6IFR1ZSwgMjkgSmFuIDIwMTkgMTU6Mzg6MjEgKzA4MDAKU3ViamVjdDogW1BBVENIXSBBTFNB
OiBoZGEvcmVhbHRlayAtIEZpeGVkIGhwX3BpbiBubyB2YWx1ZQoKRml4IGhwX3BpbiBhbHdheXMg
bm8gdmFsdWUuCgpGaXhlczogYmRlMWE3NDU5NjIzYTY2YzJhYmVjNGQwYTg0MWU0YjA2Y2M4OGQ5
YSAoJ0FMU0E6IGhkYS9yZWFsdGVrIC0gRml4ZWQgaGVhZHBob25lIGlzc3VlIGZvciBBTEM3MDAn
KQpTaWduZWQtb2ZmLWJ5OiBLYWlsYW5nIFlhbmcgPGthaWxhbmdAcmVhbHRlay5jb20+CgpkaWZm
IC0tZ2l0IGEvc291bmQvcGNpL2hkYS9wYXRjaF9yZWFsdGVrLmMgYi9zb3VuZC9wY2kvaGRhL3Bh
dGNoX3JlYWx0ZWsuYwppbmRleCBiNGY0NzIxLi40MTM5YWNlIDEwMDY0NAotLS0gYS9zb3VuZC9w
Y2kvaGRhL3BhdGNoX3JlYWx0ZWsuYworKysgYi9zb3VuZC9wY2kvaGRhL3BhdGNoX3JlYWx0ZWsu
YwpAQCAtMTE3LDYgKzExNyw3IEBAIHN0cnVjdCBhbGNfc3BlYyB7CiAJaW50IGNvZGVjX3Zhcmlh
bnQ7CS8qIGZsYWcgZm9yIG90aGVyIHZhcmlhbnRzICovCiAJdW5zaWduZWQgaW50IGhhc19hbGM1
NTA1X2RzcDoxOwogCXVuc2lnbmVkIGludCBub19kZXBvcF9kZWxheToxOworCXVuc2lnbmVkIGlu
dCBkb25lX2hwX2luaXQ6MTsKIAogCS8qIGZvciBQTEwgZml4ICovCiAJaGRhX25pZF90IHBsbF9u
aWQ7CkBAIC0zMzcyLDYgKzMzNzMsNDggQEAgc3RhdGljIHZvaWQgYWxjX2RlZmF1bHRfc2h1dHVw
KHN0cnVjdCBoZGFfY29kZWMgKmNvZGVjKQogCXNuZF9oZGFfc2h1dHVwX3BpbnMoY29kZWMpOwog
fQogCitzdGF0aWMgdm9pZCBhbGMyOTRfaHBfaW5pdChzdHJ1Y3QgaGRhX2NvZGVjICpjb2RlYykK
K3sKKwlzdHJ1Y3QgYWxjX3NwZWMgKnNwZWMgPSBjb2RlYy0+c3BlYzsKKwloZGFfbmlkX3QgaHBf
cGluID0gc3BlYy0+Z2VuLmF1dG9jZmcuaHBfcGluc1swXTsKKwlpbnQgaSwgdmFsOworCisJaWYg
KCFocF9waW4pCisJCXJldHVybjsKKworCXNuZF9oZGFfY29kZWNfd3JpdGUoY29kZWMsIGhwX3Bp
biwgMCwKKwkJCSAgICBBQ19WRVJCX1NFVF9BTVBfR0FJTl9NVVRFLCBBTVBfT1VUX01VVEUpOwor
CisJbXNsZWVwKDEwMCk7CisKKwlzbmRfaGRhX2NvZGVjX3dyaXRlKGNvZGVjLCBocF9waW4sIDAs
CisJCQkgICAgQUNfVkVSQl9TRVRfUElOX1dJREdFVF9DT05UUk9MLCAweDApOworCisJYWxjX3Vw
ZGF0ZV9jb2VmX2lkeChjb2RlYywgMHg2ZiwgMHgwMDBmLCAwKTsvKiBTZXQgSFAgZGVwb3AgdG8g
bWFudWFsIG1vZGUgKi8KKwlhbGNfdXBkYXRlX2NvZWZleF9pZHgoY29kZWMsIDB4NTgsIDB4MDAs
IDB4ODAwMCwgMHg4MDAwKTsgLyogSFAgZGVwb3AgcHJvY2VkdXJlIHN0YXJ0ICovCisKKwkvKiBX
YWl0IGZvciBkZXBvcCBwcm9jZWR1cmUgZmluaXNoICAqLworCXZhbCA9IGFsY19yZWFkX2NvZWZl
eF9pZHgoY29kZWMsIDB4NTgsIDB4MDEpOworCWZvciAoaSA9IDA7IGkgPCAyMCAmJiB2YWwgJiAw
eDAwODA7IGkrKykgeworCQltc2xlZXAoNTApOworCQl2YWwgPSBhbGNfcmVhZF9jb2VmZXhfaWR4
KGNvZGVjLCAweDU4LCAweDAxKTsKKwl9CisJLyogU2V0IEhQIGRlcG9wIHRvIGF1dG8gbW9kZSAq
LworCWFsY191cGRhdGVfY29lZl9pZHgoY29kZWMsIDB4NmYsIDB4MDAwZiwgMHgwMDBiKTsKKwlt
c2xlZXAoNTApOworfQorCitzdGF0aWMgdm9pZCBhbGMyOTRfaW5pdChzdHJ1Y3QgaGRhX2NvZGVj
ICpjb2RlYykKK3sKKwlzdHJ1Y3QgYWxjX3NwZWMgKnNwZWMgPSBjb2RlYy0+c3BlYzsKKworCWlm
ICghc3BlYy0+ZG9uZV9ocF9pbml0KSB7CisJCWFsYzI5NF9ocF9pbml0KGNvZGVjKTsKKwkJc3Bl
Yy0+ZG9uZV9ocF9pbml0ID0gdHJ1ZTsKKwl9CisJYWxjX2RlZmF1bHRfaW5pdChjb2RlYyk7Cit9
CisKIHN0YXRpYyB2b2lkIGFsYzU1MDVfY29lZl9zZXQoc3RydWN0IGhkYV9jb2RlYyAqY29kZWMs
IHVuc2lnbmVkIGludCBpbmRleF9yZWcsCiAJCQkgICAgIHVuc2lnbmVkIGludCB2YWwpCiB7CkBA
IC03MzczLDM3ICs3NDE2LDYgQEAgc3RhdGljIHZvaWQgYWxjMjY5X2ZpbGxfY29lZihzdHJ1Y3Qg
aGRhX2NvZGVjICpjb2RlYykKIAlhbGNfdXBkYXRlX2NvZWZfaWR4KGNvZGVjLCAweDQsIDAsIDE8
PDExKTsKIH0KIAotc3RhdGljIHZvaWQgYWxjMjk0X2hwX2luaXQoc3RydWN0IGhkYV9jb2RlYyAq
Y29kZWMpCi17Ci0Jc3RydWN0IGFsY19zcGVjICpzcGVjID0gY29kZWMtPnNwZWM7Ci0JaGRhX25p
ZF90IGhwX3BpbiA9IHNwZWMtPmdlbi5hdXRvY2ZnLmhwX3BpbnNbMF07Ci0JaW50IGksIHZhbDsK
LQotCWlmICghaHBfcGluKQotCQlyZXR1cm47Ci0KLQlzbmRfaGRhX2NvZGVjX3dyaXRlKGNvZGVj
LCBocF9waW4sIDAsCi0JCQkgICAgQUNfVkVSQl9TRVRfQU1QX0dBSU5fTVVURSwgQU1QX09VVF9N
VVRFKTsKLQotCW1zbGVlcCgxMDApOwotCi0Jc25kX2hkYV9jb2RlY193cml0ZShjb2RlYywgaHBf
cGluLCAwLAotCQkJICAgIEFDX1ZFUkJfU0VUX1BJTl9XSURHRVRfQ09OVFJPTCwgMHgwKTsKLQot
CWFsY191cGRhdGVfY29lZl9pZHgoY29kZWMsIDB4NmYsIDB4MDAwZiwgMCk7LyogU2V0IEhQIGRl
cG9wIHRvIG1hbnVhbCBtb2RlICovCi0JYWxjX3VwZGF0ZV9jb2VmZXhfaWR4KGNvZGVjLCAweDU4
LCAweDAwLCAweDgwMDAsIDB4ODAwMCk7IC8qIEhQIGRlcG9wIHByb2NlZHVyZSBzdGFydCAqLwot
Ci0JLyogV2FpdCBmb3IgZGVwb3AgcHJvY2VkdXJlIGZpbmlzaCAgKi8KLQl2YWwgPSBhbGNfcmVh
ZF9jb2VmZXhfaWR4KGNvZGVjLCAweDU4LCAweDAxKTsKLQlmb3IgKGkgPSAwOyBpIDwgMjAgJiYg
dmFsICYgMHgwMDgwOyBpKyspIHsKLQkJbXNsZWVwKDUwKTsKLQkJdmFsID0gYWxjX3JlYWRfY29l
ZmV4X2lkeChjb2RlYywgMHg1OCwgMHgwMSk7Ci0JfQotCS8qIFNldCBIUCBkZXBvcCB0byBhdXRv
IG1vZGUgKi8KLQlhbGNfdXBkYXRlX2NvZWZfaWR4KGNvZGVjLCAweDZmLCAweDAwMGYsIDB4MDAw
Yik7Ci0JbXNsZWVwKDUwKTsKLX0KLQogLyoKICAqLwogc3RhdGljIGludCBwYXRjaF9hbGMyNjko
c3RydWN0IGhkYV9jb2RlYyAqY29kZWMpCkBAIC03NTI5LDcgKzc1NDEsNyBAQCBzdGF0aWMgaW50
IHBhdGNoX2FsYzI2OShzdHJ1Y3QgaGRhX2NvZGVjICpjb2RlYykKIAkJc3BlYy0+Y29kZWNfdmFy
aWFudCA9IEFMQzI2OV9UWVBFX0FMQzI5NDsKIAkJc3BlYy0+Z2VuLm1peGVyX25pZCA9IDA7IC8q
IEFMQzJ4NCBkb2VzIG5vdCBoYXZlIGFueSBsb29wYmFjayBtaXhlciBwYXRoICovCiAJCWFsY191
cGRhdGVfY29lZl9pZHgoY29kZWMsIDB4NmIsIDB4MDAxOCwgKDE8PDQpIHwgKDE8PDMpKTsgLyog
VUFKIE1JQyBWcmVmIGNvbnRyb2wgYnkgdmVyYiAqLwotCQlhbGMyOTRfaHBfaW5pdChjb2RlYyk7
CisJCXNwZWMtPmluaXRfaG9vayA9IGFsYzI5NF9pbml0OwogCQlicmVhazsKIAljYXNlIDB4MTBl
YzAzMDA6CiAJCXNwZWMtPmNvZGVjX3ZhcmlhbnQgPSBBTEMyNjlfVFlQRV9BTEMzMDA7CkBAIC03
NTQxLDcgKzc1NTMsNyBAQCBzdGF0aWMgaW50IHBhdGNoX2FsYzI2OShzdHJ1Y3QgaGRhX2NvZGVj
ICpjb2RlYykKIAkJc3BlYy0+Y29kZWNfdmFyaWFudCA9IEFMQzI2OV9UWVBFX0FMQzcwMDsKIAkJ
c3BlYy0+Z2VuLm1peGVyX25pZCA9IDA7IC8qIEFMQzcwMCBkb2VzIG5vdCBoYXZlIGFueSBsb29w
YmFjayBtaXhlciBwYXRoICovCiAJCWFsY191cGRhdGVfY29lZl9pZHgoY29kZWMsIDB4NGEsIDEg
PDwgMTUsIDApOyAvKiBDb21ibyBqYWNrIGF1dG8gdHJpZ2dlciBjb250cm9sICovCi0JCWFsYzI5
NF9ocF9pbml0KGNvZGVjKTsKKwkJc3BlYy0+aW5pdF9ob29rID0gYWxjMjk0X2luaXQ7CiAJCWJy
ZWFrOwogCiAJfQo=

--_002_6FAB7C47BCF00940BB0999A99BE3547A18DB7442RTITMBSVM07real_
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--_002_6FAB7C47BCF00940BB0999A99BE3547A18DB7442RTITMBSVM07real_--
