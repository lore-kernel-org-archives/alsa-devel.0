From: Kailang <kailang@realtek.com>
Subject: Re: FW: move eapd coef function before ACT_PRE_PROBE
	state
Date: Wed, 8 May 2019 06:59:02 +0000
Message-ID: <6FAB7C47BCF00940BB0999A99BE3547A1D765C5E@RTITMBSVM07.realtek.com.tw>
References: <6FAB7C47BCF00940BB0999A99BE3547A1D765A9D@RTITMBSVM07.realtek.com.tw>
 <s5hmujy39go.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="_002_6FAB7C47BCF00940BB0999A99BE3547A1D765C5ERTITMBSVM07real_"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 5F8A6F80796
 for <alsa-devel@alsa-project.org>; Wed,  8 May 2019 08:59:08 +0200 (CEST)
In-Reply-To: <s5hmujy39go.wl-tiwai@suse.de>
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

--_002_6FAB7C47BCF00940BB0999A99BE3547A1D765C5ERTITMBSVM07real_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi Takashi,

I recreate patch as attach.
Thanks.

BR,
Kailang

> -----Original Message-----
> From: Takashi Iwai <tiwai@suse.de>
> Sent: Tuesday, May 7, 2019 5:23 PM
> To: Kailang <kailang@realtek.com>
> Cc: (alsa-devel@alsa-project.org) <alsa-devel@alsa-project.org>
> Subject: Re: FW: move eapd coef function before ACT_PRE_PROBE state
>=20
> On Tue, 07 May 2019 11:17:15 +0200,
> Kailang wrote:
> >
> > Hi Takashi,
> >
> > This one.
>=20
> I already replied twice.  The patch needs rewrite.
> Didn't you get the post?
>=20
>=20
> thanks,
>=20
> Takashi
>=20
> >
> > -----Original Message-----
> > From: Kailang
> > Sent: Monday, May 6, 2019 2:46 PM
> > To: Takashi Iwai (tiwai@suse.de) <tiwai@suse.de>
> > Cc: (alsa-devel@alsa-project.org) <alsa-devel@alsa-project.org>
> > Subject: RE: move eapd coef function before ACT_PRE_PROBE state
> >
> > Hi Takashi,
> >
> > Are you available for apply this ?
> > Thanks.
> >
> > BR,
> > Kailang
> >
> > > -----Original Message-----
> > > From: Kailang
> > > Sent: Tuesday, April 30, 2019 3:41 PM
> > > To: Takashi Iwai (tiwai@suse.de) <tiwai@suse.de>
> > > Cc: (alsa-devel@alsa-project.org) <alsa-devel@alsa-project.org>
> > > Subject: move eapd coef function before ACT_PRE_PROBE state
> > >
> > > Hi Takashi,
> > >
> > > alc_fill_eapd_coef(),this function was change EAPD control to default=
.
> > > Default was set EAPD by verb control.
> > > This function was run in ACT_INIT state.
> > > Move it to ACT_PRE_PROBE above. It will have a chance to change EAPD
> > > control on ACT_PRE_PROBE state. It could change control by 0x20 coef =
bit.
> > >
> > > BR,
> > > Kailang
> > [2 0000-move-eapd-coef-func.patch <application/octet-stream (base64)>]
> >
>=20
> ------Please consider the environment before printing this e-mail.

--_002_6FAB7C47BCF00940BB0999A99BE3547A1D765C5ERTITMBSVM07real_
Content-Type: application/octet-stream;
	name="0001-move-eapd-coef-func.patch"
Content-Description: 0001-move-eapd-coef-func.patch
Content-Disposition: attachment; filename="0001-move-eapd-coef-func.patch";
	size=1326; creation-date="Wed, 08 May 2019 06:57:15 GMT";
	modification-date="Wed, 08 May 2019 06:56:18 GMT"
Content-Transfer-Encoding: base64

RnJvbSA4MzUyMTlhMDJhNmFlMWEwN2Y2ZjZlMDI4ZmM0NjQxZWRjN2EzNjMxIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBLYWlsYW5nIFlhbmcgPGthaWxhbmdAcmVhbHRlay5jb20+CkRh
dGU6IFdlZCwgOCBNYXkgMjAxOSAxNDo1NDo1MSArMDgwMApTdWJqZWN0OiBbUEFUQ0hdIEFMU0E6
IGhkYS9yZWFsdGVrIC0gTW92ZSBFUEFEIGJ5IHZlcmIgZnVuY3Rpb24KCmFsY19maWxsX2VhcGRf
Y29lZigpLHRoaXMgZnVuY3Rpb24gd2FzIGNoYW5nZSBFQVBEIGNvbnRyb2wgdG8gZGVmYXVsdC4K
RGVmYXVsdCB3YXMgc2V0IEVBUEQgYnkgdmVyYiBjb250cm9sLgpUaGlzIGZ1bmN0aW9uIHdhcyBy
dW4gaW4gQUNUX0lOSVQgc3RhdGUuCk1vdmUgaXQgdG8gQUNUX1BSRV9QUk9CRSBhYm92ZS4gSXQg
d2lsbCBoYXZlIGEgY2hhbmNlIHRvIGNoYW5nZSBFQVBEIGNvbnRyb2wKb24gQUNUX1BSRV9QUk9C
RSBzdGF0ZS4gSXQgY291bGQgY2hhbmdlIGNvbnRyb2wgYnkgMHgyMCBjb2VmIGJpdC4KClNpZ25l
ZC1vZmYtYnk6IEthaWxhbmcgWWFuZyA8a2FpbGFuZ0ByZWFsdGVrLmNvbT4KCmRpZmYgLS1naXQg
YS9zb3VuZC9wY2kvaGRhL3BhdGNoX3JlYWx0ZWsuYyBiL3NvdW5kL3BjaS9oZGEvcGF0Y2hfcmVh
bHRlay5jCmluZGV4IGRhY2NjYWNiNWZlMC4uZGUyM2I4YWQ5MzJlIDEwMDY0NAotLS0gYS9zb3Vu
ZC9wY2kvaGRhL3BhdGNoX3JlYWx0ZWsuYworKysgYi9zb3VuZC9wY2kvaGRhL3BhdGNoX3JlYWx0
ZWsuYwpAQCAtNTAyLDcgKzUwMiw2IEBAIHN0YXRpYyB2b2lkIGFsY19lYXBkX3NodXR1cChzdHJ1
Y3QgaGRhX2NvZGVjICpjb2RlYykKIC8qIGdlbmVyaWMgRUFQRCBpbml0aWFsaXphdGlvbiAqLwog
c3RhdGljIHZvaWQgYWxjX2F1dG9faW5pdF9hbXAoc3RydWN0IGhkYV9jb2RlYyAqY29kZWMsIGlu
dCB0eXBlKQogewotCWFsY19maWxsX2VhcGRfY29lZihjb2RlYyk7CiAJYWxjX2F1dG9fc2V0dXBf
ZWFwZChjb2RlYywgdHJ1ZSk7CiAJYWxjX3dyaXRlX2dwaW8oY29kZWMpOwogCXN3aXRjaCAodHlw
ZSkgewpAQCAtMTA4Niw2ICsxMDg1LDcgQEAgc3RhdGljIGludCBhbGNfYWxsb2Nfc3BlYyhzdHJ1
Y3QgaGRhX2NvZGVjICpjb2RlYywgaGRhX25pZF90IG1peGVyX25pZCkKIAkJcmV0dXJuIC1FTk9N
RU07CiAJY29kZWMtPnNwZWMgPSBzcGVjOwogCXNuZF9oZGFfZ2VuX3NwZWNfaW5pdCgmc3BlYy0+
Z2VuKTsKKwlhbGNfZmlsbF9lYXBkX2NvZWYoY29kZWMpOwogCXNwZWMtPmdlbi5taXhlcl9uaWQg
PSBtaXhlcl9uaWQ7CiAJc3BlYy0+Z2VuLm93bl9lYXBkX2N0bCA9IDE7CiAJY29kZWMtPnNpbmds
ZV9hZGNfYW1wID0gMTsK

--_002_6FAB7C47BCF00940BB0999A99BE3547A1D765C5ERTITMBSVM07real_
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--_002_6FAB7C47BCF00940BB0999A99BE3547A1D765C5ERTITMBSVM07real_--
