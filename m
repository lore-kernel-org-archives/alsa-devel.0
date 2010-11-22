From: Denis Kup <dener.kup@gmail.com>
Subject: Re: [PATCH] Acer 7730G support update.
Date: Mon, 22 Nov 2010 19:09:32 +0300
Message-ID: <AANLkTim8Xpf8+PMatXZ0o04JL+-axVdUJj4P60OWB+wV@mail.gmail.com>
References: <AANLkTimmcm6OcsPrB59ovYFonv5g=yrOu3_aW31UHHrO@mail.gmail.com>
	<s5hr5edrgim.wl%tiwai@suse.de>
	<AANLkTinXrkHOfmsuCmv3xTx8nG5sogY75=w399F=tZmP@mail.gmail.com>
	<s5h39qtva6e.wl%tiwai@suse.de>
	<AANLkTin71oqTOe6Wi-DgzAhgonafvt=_RyAzpuxAagwt@mail.gmail.com>
	<s5hsjyttuho.wl%tiwai@suse.de>
	<AANLkTi=MxLsPOrNmR7agJGnzbWE11kMyR5+n+MT5dtzW@mail.gmail.com>
	<s5hmxp1tsm9.wl%tiwai@suse.de>
	<AANLkTikHStk=zY8SXHGasRupa-xfnD2Qaq74_5cDBhfQ@mail.gmail.com>
	<s5h39qttnwg.wl%tiwai@suse.de>
	<AANLkTinYhR6eKgdt7aqPTdAhbHb3srdwrmFt=gBV51Xb@mail.gmail.com>
	<s5hk4k5qslj.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=20cf30433c9a47954f0495a67b9b
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f51.google.com (mail-fx0-f51.google.com
	[209.85.161.51]) by alsa0.perex.cz (Postfix) with ESMTP id B210E2414E
	for <alsa-devel@alsa-project.org>; Mon, 22 Nov 2010 17:09:35 +0100 (CET)
Received: by fxm10 with SMTP id 10so21056fxm.38
	for <alsa-devel@alsa-project.org>; Mon, 22 Nov 2010 08:09:32 -0800 (PST)
In-Reply-To: <s5hk4k5qslj.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Alsa Developers Maillist <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

--20cf30433c9a47954f0495a67b9b
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

I have downloaded file normally. I found that all tabs was converted
to spaces in patch file. So I am sending new version.

2010/11/22 Takashi Iwai <tiwai@suse.de>:
> At Mon, 22 Nov 2010 17:53:22 +0300,
> Denis Kup wrote:
>>
>> Yes it is 70 MB in archived state and 266.6 when decompressed. After
>> decompressing i have such folders in linux-2.6.37-rc3:
>>
>> drivers
>> Documentation
>> crypto
>> block
>> arch
>
> There must be more directories like include, lib, sound, etc.
> I checked the tarball here and it contains correctly.
>
> Either your filesystem is filled up to full or the downloaded archive
> is broken, I guess.
>
>
> Takashi
>
>
>> I have used find tool to locate sound folder and I have found it only
>> in documentation.
>>
>> 2010/11/22 Takashi Iwai <tiwai@suse.de>:
>> > At Mon, 22 Nov 2010 17:46:31 +0300,
>> > Denis Kup wrote:
>> >>
>> >> There is no such directory in archive.
>> >
>> > You must be kidding. =A0Double-check you downloaded the whole file.
>> > It's 70M big in the compressed form.
>> >
>> >
>> > Takashi
>> >
>> >
>> >> 2010/11/22 Takashi Iwai <tiwai@suse.de>:
>> >> > At Mon, 22 Nov 2010 15:40:31 +0300,
>> >> > Denis Kup wrote:
>> >> >>
>> >> >> I can't find patch_realtek.c in this archive. Where should it be s=
ituated?
>> >> >
>> >> > It's in sound/pci/hda/patch_realtek.c.
>> >> >
>> >> >
>> >> > Takashi
>> >> >
>> >> >
>> >> >> 2010/11/22 Takashi Iwai <tiwai@suse.de>:
>> >> >> > At Mon, 22 Nov 2010 15:24:16 +0300,
>> >> >> > Denis Kup wrote:
>> >> >> >>
>> >> >> >> Do you mean that?
>> >> >> >> http://www.kernel.org/pub/linux/kernel/v2.6/testing/linux-2.6.3=
7-rc3.tar.bz2
>> >> >> >
>> >> >> > Yes.
>> >> >> >
>> >> >> >
>> >> >> > Takashi
>> >> >> >
>> >> >> >> 2010/11/22 Takashi Iwai <tiwai@suse.de>:
>> >> >> >> > At Mon, 22 Nov 2010 13:51:45 +0300,
>> >> >> >> > Denis Kup wrote:
>> >> >> >> >>
>> >> >> >> >> 2010/11/22 Takashi Iwai <tiwai@suse.de>:
>> >> >> >> >> > At Mon, 8 Nov 2010 00:01:45 +0300,
>> >> >> >> >> > Denis Kup wrote:
>> >> >> >> >> >>
>> >> >> >> >> >> [1 =A0<multipart/alternative (7bit)>]
>> >> >> >> >> >> [1.1 =A0<text/plain; ISO-8859-1 (7bit)>]
>> >> >> >> >> >> Hello!
>> >> >> >> >> >>
>> >> >> >> >> >> I want to commit patch that fix no-sound on acer 7730G la=
ptop. All work
>> >> >> >> >> >> history you can see here
>> >> >> >> >> >> https://bugtrack.alsa-project.org/alsa-bug/view.php?id=3D=
5123 .
>> >> >> >> >> >> This patch for the latest snapshot, where this changes ha=
ve been made:
>> >> >> >> >> >> http://www.kerneltrap.com/mailarchive/git-commits-head/20=
10/5/20/35023 .
>> >> >> >> >> >>
>> >> >> >> >> >> Acer 7730G support patch.
>> >> >> >> >> >>
>> >> >> >> >> >> Changes:
>> >> >> >> >> >> 1) Fixes automatic EAPD configuration on Acer 7730G lapto=
p.
>> >> >> >> >> >>
>> >> >> >> >> >> Denis Kuplyakov <dener.kup@gmail.com>
>> >> >> >> >> >> 8.11.10 00:00:50
>> >> >> >> >> >
>> >> >> >> >> > [Sorry for the late reply - the mail was stuck in my outpu=
t queue
>> >> >> >> >> > =A0without triggering for weeks!]
>> >> >> >> >> >
>> >> >> >> >> > Thanks for the patch.
>> >> >> >> >> > Unfortunately, your patch isn't applicable as is to the la=
test code.
>> >> >> >> >> > The patch gives fuzz and errors.
>> >> >> >> >> >
>> >> >> >> >> > Could you rebase your patch to the latest 2.6.37-rc kernel=
 code?
>> >> >> >> >> >
>> >> >> >> >> > Also, don't forget to give your sign-off. =A0It's simply a=
 line like
>> >> >> >> >> > Signed-off-by: Foo Bar <foo@bar.com>
>> >> >> >> >> >
>> >> >> >> >> >
>> >> >> >> >> > thanks,
>> >> >> >> >> >
>> >> >> >> >> > Takashi
>> >> >> >> >> >
>> >> >> >> >>
>> >> >> >> >> Can you send me a link to the latest version, that should I =
patch.
>> >> >> >> >
>> >> >> >> > It's Linus tree, e.g. 2.6.37-rc3 should suffice.
>> >> >> >> >
>> >> >> >> >
>> >> >> >> > Takashi
>> >> >> >> >
>> >> >> >>
>> >> >> >
>> >> >>
>> >> >
>> >>
>> >
>>
>

--20cf30433c9a47954f0495a67b9b
Content-Type: application/octet-stream; name=patch
Content-Disposition: attachment; filename=patch
Content-Transfer-Encoding: base64
X-Attachment-Id: f_ggtjxlkx0

LS0tIC4vYS9wYXRjaF9yZWFsdGVrLmMJMjAxMC0xMS0yMiAwMjoxODo1Ni4wMDAwMDAwMDAgKzAz
MDAKKysrIC4vYi9wYXRjaF9yZWFsdGVrLmMJMjAxMC0xMS0wNyAwMTozNjoxOS4wMDAwMDAwMDAg
KzAzMDAKQEAgLTIwMTQsNiArMjAxNCwzNiBAQCBzdGF0aWMgc3RydWN0IGhkYV92ZXJiIGFsYzg4
OF9hY2VyX2FzcGlyCiB9OwogCiAvKgorICpBTEM4ODggQWNlciBBc3BpcmUgNzczMEcgbW9kZWwK
KyAqLworCitzdGF0aWMgc3RydWN0IGhkYV92ZXJiIGFsYzg4OF9hY2VyX2FzcGlyZV83NzMwR192
ZXJic1tdID0geworLyogQmlhcyB2b2x0YWdlIG9uIGZvciBleHRlcm5hbCBtaWMgcG9ydCAqLwor
CXsweDE4LCBBQ19WRVJCX1NFVF9QSU5fV0lER0VUX0NPTlRST0wsIFBJTl9JTiB8IFBJTl9WUkVG
ODB9LAorLyogRnJvbnQgTWljOiBzZXQgdG8gUElOX0lOIChlbXB0eSBieSBkZWZhdWx0KSAqLwor
CXsweDEyLCBBQ19WRVJCX1NFVF9QSU5fV0lER0VUX0NPTlRST0wsIFBJTl9JTn0sCisvKiBVbnNl
bGVjdCBGcm9udCBNaWMgYnkgZGVmYXVsdCBpbiBpbnB1dCBtaXhlciAzICovCisJezB4MjIsIEFD
X1ZFUkJfU0VUX0FNUF9HQUlOX01VVEUsIEFNUF9JTl9NVVRFKDB4Yil9LAorLyogRW5hYmxlIHVu
c29saWNpdGVkIGV2ZW50IGZvciBIUCBqYWNrICovCisJezB4MTUsIEFDX1ZFUkJfU0VUX1VOU09M
SUNJVEVEX0VOQUJMRSwgQUxDODgwX0hQX0VWRU5UIHwgQUNfVVNSU1BfRU59LAorLyogRW5hYmxl
IHNwZWFrZXIgb3V0cHV0ICovCisJezB4MTQsIEFDX1ZFUkJfU0VUX1BJTl9XSURHRVRfQ09OVFJP
TCwgUElOX09VVH0sCisJezB4MTQsIEFDX1ZFUkJfU0VUX0FNUF9HQUlOX01VVEUsIEFNUF9PVVRf
VU5NVVRFfSwKKwl7MHgxNCwgQUNfVkVSQl9TRVRfRUFQRF9CVExFTkFCTEUsIDJ9LAorLyogRW5h
YmxlIGhlYWRwaG9uZSBvdXRwdXQgKi8KKwl7MHgxNSwgQUNfVkVSQl9TRVRfUElOX1dJREdFVF9D
T05UUk9MLCBQSU5fT1VUIHwgUElOX0hQfSwKKwl7MHgxNSwgQUNfVkVSQl9TRVRfQU1QX0dBSU5f
TVVURSwgQU1QX09VVF9VTk1VVEV9LAorCXsweDE1LCBBQ19WRVJCX1NFVF9DT05ORUNUX1NFTCwg
MHgwMH0sCisJezB4MTUsIEFDX1ZFUkJfU0VUX0VBUERfQlRMRU5BQkxFLCAyfSwKKy8qRW5hYmxl
IGludGVybmFsIHN1Yndvb2ZlciAqLworCXsweDE3LCBBQ19WRVJCX1NFVF9QSU5fV0lER0VUX0NP
TlRST0wsIFBJTl9PVVR9LAorCXsweDE3LCBBQ19WRVJCX1NFVF9BTVBfR0FJTl9NVVRFLCBBTVBf
T1VUX1VOTVVURX0sCisJezB4MTcsIEFDX1ZFUkJfU0VUX0NPTk5FQ1RfU0VMLCAweDAyfSwKKwl7
MHgxNywgQUNfVkVSQl9TRVRfRUFQRF9CVExFTkFCTEUsIDJ9LAorCXsgfQorfTsKKworLyoKICAq
IEFMQzg4OSBBY2VyIEFzcGlyZSA4OTMwRyBtb2RlbAogICovCiAKQEAgLTIyMDAsNiArMjIzMCwx
NiBAQCBzdGF0aWMgdm9pZCBhbGM4ODhfYWNlcl9hc3BpcmVfNjUzMGdfc2V0CiAJc3BlYy0+YXV0
b2NmZy5zcGVha2VyX3BpbnNbMl0gPSAweDE3OwogfQogCitzdGF0aWMgdm9pZCBhbGM4ODhfYWNl
cl9hc3BpcmVfNzczMGdfc2V0dXAoc3RydWN0IGhkYV9jb2RlYyAqY29kZWMpCit7CisJc3RydWN0
IGFsY19zcGVjICpzcGVjID0gY29kZWMtPnNwZWM7CisKKwlzcGVjLT5hdXRvY2ZnLmhwX3BpbnNb
MF0gPSAweDE1OworCXNwZWMtPmF1dG9jZmcuc3BlYWtlcl9waW5zWzBdID0gMHgxNDsKKwlzcGVj
LT5hdXRvY2ZnLnNwZWFrZXJfcGluc1sxXSA9IDB4MTY7CisJc3BlYy0+YXV0b2NmZy5zcGVha2Vy
X3BpbnNbMl0gPSAweDE3OworfQorCiBzdGF0aWMgdm9pZCBhbGM4ODlfYWNlcl9hc3BpcmVfODkz
MGdfc2V0dXAoc3RydWN0IGhkYV9jb2RlYyAqY29kZWMpCiB7CiAJc3RydWN0IGFsY19zcGVjICpz
cGVjID0gY29kZWMtPnNwZWM7CkBAIC05NTI0LDEzICs5NTY0LDYgQEAgc3RhdGljIHN0cnVjdCBo
ZGFfdmVyYiBhbGM4ODNfYWNlcl9lYXBkXwogCXsgfQogfTsKIAotc3RhdGljIHN0cnVjdCBoZGFf
dmVyYiBhbGM4ODhfYWNlcl9hc3BpcmVfNzczMEdfdmVyYnNbXSA9IHsKLQl7MHgxNSwgQUNfVkVS
Ql9TRVRfQ09OTkVDVF9TRUwsIDB4MDB9LAotCXsweDE3LCBBQ19WRVJCX1NFVF9DT05ORUNUX1NF
TCwgMHgwMn0sCi0JezB4MTUsIEFDX1ZFUkJfU0VUX1VOU09MSUNJVEVEX0VOQUJMRSwgQUxDODgw
X0hQX0VWRU5UIHwgQUNfVVNSU1BfRU59LAotCXsgfSAvKiBlbmQgKi8KLX07Ci0KIHN0YXRpYyB2
b2lkIGFsYzg4OF82c3RfZGVsbF9zZXR1cChzdHJ1Y3QgaGRhX2NvZGVjICpjb2RlYykKIHsKIAlz
dHJ1Y3QgYWxjX3NwZWMgKnNwZWMgPSBjb2RlYy0+c3BlYzsKQEAgLTEwMzI4LDcgKzEwMzYxLDcg
QEAgc3RhdGljIHN0cnVjdCBhbGNfY29uZmlnX3ByZXNldCBhbGM4ODJfcAogCQkuY29uc3RfY2hh
bm5lbF9jb3VudCA9IDYsCiAJCS5pbnB1dF9tdXggPSAmYWxjODgzX2NhcHR1cmVfc291cmNlLAog
CQkudW5zb2xfZXZlbnQgPSBhbGNfYXV0b211dGVfYW1wX3Vuc29sX2V2ZW50LAotCQkuc2V0dXAg
PSBhbGM4ODhfYWNlcl9hc3BpcmVfNjUzMGdfc2V0dXAsCisJCS5zZXR1cCA9IGFsYzg4OF9hY2Vy
X2FzcGlyZV83NzMwZ19zZXR1cCwKIAkJLmluaXRfaG9vayA9IGFsY19hdXRvbXV0ZV9hbXAsCiAJ
fSwKIAlbQUxDODgzX01FRElPTl0gPSB7Cg==
--20cf30433c9a47954f0495a67b9b
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--20cf30433c9a47954f0495a67b9b--
