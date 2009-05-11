From: Chris Pockele <chris.pockele.f1@gmail.com>
Subject: Re: patch to support Samsung NC10 mini notebook
Date: Mon, 11 May 2009 22:25:14 +0200
Message-ID: <2b491faa0905111325h5142b5c9s2ee0f0030606e550@mail.gmail.com>
References: <2b491faa0905101221p6ba903d9kc5be3cc4869f4926@mail.gmail.com>
	<s5hws8oaval.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=0016e6db5c0c9d4db70469a8c60e
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f175.google.com (mail-ew0-f175.google.com
	[209.85.219.175])
	by alsa0.perex.cz (Postfix) with ESMTP id 591F32443B
	for <alsa-devel@alsa-project.org>;
	Mon, 11 May 2009 22:25:15 +0200 (CEST)
Received: by ewy23 with SMTP id 23so4098761ewy.32
	for <alsa-devel@alsa-project.org>; Mon, 11 May 2009 13:25:14 -0700 (PDT)
In-Reply-To: <s5hws8oaval.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

--0016e6db5c0c9d4db70469a8c60e
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On Mon, May 11, 2009 at 10:38 AM, Takashi Iwai <tiwai@suse.de> wrote:
>
> First off, please give a text as a change log together with your
> sign-off so that the patch can be merged to the upstream.

Here it is:
=3D=3D=3D=3D=3D
Add specific configuration for Samsung NC10 mini notebook.  Internal
mic/speakers will be correctly muted when plugging in external ones.
Mixer controls are added for speakers, headphones and PC beep.
"Boost" is added for the microphones.
Signed-off-by: Chris Pockel=E9 <chris.pockele.f1@gmail.com >
=3D=3D=3D=3D=3D


>...
> This kind of comment isn't needed because we track all changes via GIT.
>
It's gone now.

> If you'd like to keep the test code, just comment out with some other
> ifdef. =A0 Even an ifdef 0 with a comment would be OK.
>
Ok, did that.

...
>> + =A0 =A0 HDA_CODEC_VOLUME("Ext Mic Boost Playback Volume", 0x18, 0, HDA=
_INPUT),
>
> The mic boost is for both playback and capture. =A0Thus, simply name it a=
s
> "... Mic Boost".
>
>> + =A0 =A0 HDA_CODEC_VOLUME("Int Mic Playback Volume", 0x0b, 0x1, HDA_INP=
UT),
>> + =A0 =A0 HDA_CODEC_MUTE("Int Mic Playback Switch", 0x0b, 0x1, HDA_INPUT=
),
>> + =A0 =A0 HDA_CODEC_VOLUME("Int Mic Boost Playback Volume", 0x19, 0, HDA=
_INPUT),
>
> Ditto.
>
Changed the names.

>> =A0 =A0 =A0 [ALC663_ASUS_MODE6] =3D "asus-mode6",
>> + =A0 =A0 [ALC272_DELL] =3D "dell272",
>> + =A0 =A0 [ALC272_DELL_ZM1] =3D "dell-zm1",
>
> These models have been already added pretty recently.
> Please rebase your patch with the latest snapshot.
>
I rebased using 20090509 snapshot before sending the patch (I checked
out today's snapshot too - patch_realtek.c hasn't changed), and those
models were there indeed.  However, I wanted to try those
configurations but I couldn't use the model=3D option because the
configurations were not in the alc662_models array.  That's why I
added these 2 lines, and it got through to the patch.  I removed them
for now, as that should probably be another patch.

>
>> + =A0 =A0 [ALC272_SAMSUNG_NC10] =3D "samsung-nc10",
>
> Also, don't forget to update
> Documentation/sound/alsa/HD-Audio-Models.txt, too.
>
>
> Could you fix the issues above and repost?
>
The attached version fixes all issues you mentioned.

Regards,
Chris

--0016e6db5c0c9d4db70469a8c60e
Content-Type: text/x-patch; charset=US-ASCII; name="alsa20090509-add-nc10-support-v2.patch"
Content-Disposition: attachment;
	filename="alsa20090509-add-nc10-support-v2.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_fulmbh2x0

ZGlmZiAtcHJ1IGFsc2EtZHJpdmVyL2Fsc2Eta2VybmVsL0RvY3VtZW50YXRpb24vSEQtQXVkaW8t
TW9kZWxzLnR4dCBhbHNhLWRyaXZlci0yMDA5MDUwOS1NT0QvYWxzYS1rZXJuZWwvRG9jdW1lbnRh
dGlvbi9IRC1BdWRpby1Nb2RlbHMudHh0Ci0tLSBhbHNhLWRyaXZlci9hbHNhLWtlcm5lbC9Eb2N1
bWVudGF0aW9uL0hELUF1ZGlvLU1vZGVscy50eHQJMjAwOS0wNS0wOSAwMDowNTowMS4wMDAwMDAw
MDAgKzAyMDAKKysrIGFsc2EtZHJpdmVyLTIwMDkwNTA5LU1PRC9hbHNhLWtlcm5lbC9Eb2N1bWVu
dGF0aW9uL0hELUF1ZGlvLU1vZGVscy50eHQJMjAwOS0wNS0xMSAyMTowNTowNC4wMDAwMDAwMDAg
KzAyMDAKQEAgLTg3LDggKzg3LDggQEAgQUxDMjY5CiAgIGZ1aml0c3UJRlNDIEFtaWxvCiAgIGF1
dG8JCWF1dG8tY29uZmlnIHJlYWRpbmcgQklPUyAoZGVmYXVsdCkKIAotQUxDNjYyLzY2MwotPT09
PT09PT09PQorQUxDNjYyLzY2My8yNzIKKz09PT09PT09PT09PT09CiAgIDNzdGFjay1kaWcJMy1z
dGFjayAoMi1jaGFubmVsKSB3aXRoIFNQRElGCiAgIDNzdGFjay02Y2gJIDMtc3RhY2sgKDYtY2hh
bm5lbCkKICAgM3N0YWNrLTZjaC1kaWcgMy1zdGFjayAoNi1jaGFubmVsKSB3aXRoIFNQRElGCkBA
IC0xMDcsNiArMTA3LDcgQEAgQUxDNjYyLzY2MwogICBhc3VzLW1vZGU0CUFTVVMKICAgYXN1cy1t
b2RlNQlBU1VTCiAgIGFzdXMtbW9kZTYJQVNVUworICBzYW1zdW5nLW5jMTAJU2Ftc3VuZyBOQzEw
IG1pbmkgbm90ZWJvb2sKICAgYXV0bwkJYXV0by1jb25maWcgcmVhZGluZyBCSU9TIChkZWZhdWx0
KQogCiBBTEM4ODIvODg1CmRpZmYgLXBydSBhbHNhLWRyaXZlci9hbHNhLWtlcm5lbC9wY2kvaGRh
L3BhdGNoX3JlYWx0ZWsuYyBhbHNhLWRyaXZlci0yMDA5MDUwOS1NT0QvYWxzYS1rZXJuZWwvcGNp
L2hkYS9wYXRjaF9yZWFsdGVrLmMKLS0tIGFsc2EtZHJpdmVyL2Fsc2Eta2VybmVsL3BjaS9oZGEv
cGF0Y2hfcmVhbHRlay5jCTIwMDktMDUtMDkgMDA6MDU6MDIuMDAwMDAwMDAwICswMjAwCisrKyBh
bHNhLWRyaXZlci0yMDA5MDUwOS1NT0QvYWxzYS1rZXJuZWwvcGNpL2hkYS9wYXRjaF9yZWFsdGVr
LmMJMjAwOS0wNS0xMSAyMTowMTozNi4wMDAwMDAwMDAgKzAyMDAKQEAgLTE5MCw2ICsxOTAsNyBA
QCBlbnVtIHsKIAlBTEM2NjNfQVNVU19NT0RFNiwKIAlBTEMyNzJfREVMTCwKIAlBTEMyNzJfREVM
TF9aTTEsCisJQUxDMjcyX1NBTVNVTkdfTkMxMCwKIAlBTEM2NjJfQVVUTywKIAlBTEM2NjJfTU9E
RUxfTEFTVCwKIH07CkBAIC0xNTEyMCw2ICsxNTEyMSwzOCBAQCBzdGF0aWMgc3RydWN0IGhkYV9p
bnB1dF9tdXggYWxjNjYzX201MXZhCiAJfSwKIH07CiAKKyNpZiAxIC8qIHNldCB0byAwIGZvciB0
ZXN0aW5nIG90aGVyIGlucHV0IHNvdXJjZXMgYmVsb3cgKi8KK3N0YXRpYyBzdHJ1Y3QgaGRhX2lu
cHV0X211eCBhbGMyNzJfbmMxMF9jYXB0dXJlX3NvdXJjZSA9IHsKKwkubnVtX2l0ZW1zID0gMiwK
KwkuaXRlbXMgPSB7CisJCXsgIkF1dG9zZWxlY3QgTWljIiwgMHgwIH0sCisJCXsgIkludGVybmFs
IE1pYyIsIDB4MSB9LAorCX0sCit9OworI2Vsc2UKK3N0YXRpYyBzdHJ1Y3QgaGRhX2lucHV0X211
eCBhbGMyNzJfbmMxMF9jYXB0dXJlX3NvdXJjZSA9IHsKKwkubnVtX2l0ZW1zID0gMTYsCisJLml0
ZW1zID0geworCQl7ICJBdXRvc2VsZWN0IE1pYyIsIDB4MCB9LAorCQl7ICJJbnRlcm5hbCBNaWMi
LCAweDEgfSwKKwkJeyAiSW4tMHgwMiIsIDB4MiB9LAorCQl7ICJJbi0weDAzIiwgMHgzIH0sCisJ
CXsgIkluLTB4MDQiLCAweDQgfSwKKwkJeyAiSW4tMHgwNSIsIDB4NSB9LAorCQl7ICJJbi0weDA2
IiwgMHg2IH0sCisJCXsgIkluLTB4MDciLCAweDcgfSwKKwkJeyAiSW4tMHgwOCIsIDB4OCB9LAor
CQl7ICJJbi0weDA5IiwgMHg5IH0sCisJCXsgIkluLTB4MGEiLCAweDBhIH0sCisJCXsgIkluLTB4
MGIiLCAweDBiIH0sCisJCXsgIkluLTB4MGMiLCAweDBjIH0sCisJCXsgIkluLTB4MGQiLCAweDBk
IH0sCisJCXsgIkluLTB4MGUiLCAweDBlIH0sCisJCXsgIkluLTB4MGYiLCAweDBmIH0sCisJfSwK
K307CisjZW5kaWYKKwogLyoKICAqIDJjaCBtb2RlCiAgKi8KQEAgLTE2MTUxLDYgKzE2MTg0LDIz
IEBAIHN0YXRpYyBzdHJ1Y3Qgc25kX2tjb250cm9sX25ldyBhbGM2NjJfZWMKIAl7IH0gLyogZW5k
ICovCiB9OwogCitzdGF0aWMgc3RydWN0IHNuZF9rY29udHJvbF9uZXcgYWxjMjcyX25jMTBfbWl4
ZXJbXSA9IHsKKwkvKiBNYXN0ZXIgUGxheWJhY2sgYXV0b21hdGljYWxseSBjcmVhdGVkIGZyb20g
U3BlYWtlciBhbmQgSGVhZHBob25lICovCisJSERBX0NPREVDX1ZPTFVNRSgiU3BlYWtlciBQbGF5
YmFjayBWb2x1bWUiLCAweDAyLCAweDAsIEhEQV9PVVRQVVQpLAorCUhEQV9DT0RFQ19NVVRFKCJT
cGVha2VyIFBsYXliYWNrIFN3aXRjaCIsIDB4MTQsIDB4MCwgSERBX09VVFBVVCksCisJSERBX0NP
REVDX1ZPTFVNRSgiSGVhZHBob25lIFBsYXliYWNrIFZvbHVtZSIsIDB4MDMsIDB4MCwgSERBX09V
VFBVVCksCisJSERBX0NPREVDX01VVEUoIkhlYWRwaG9uZSBQbGF5YmFjayBTd2l0Y2giLCAweDIx
LCAweDAsIEhEQV9PVVRQVVQpLAorCisJSERBX0NPREVDX1ZPTFVNRSgiRXh0IE1pYyBQbGF5YmFj
ayBWb2x1bWUiLCAweDBiLCAweDAsIEhEQV9JTlBVVCksCisJSERBX0NPREVDX01VVEUoIkV4dCBN
aWMgUGxheWJhY2sgU3dpdGNoIiwgMHgwYiwgMHgwLCBIREFfSU5QVVQpLAorCUhEQV9DT0RFQ19W
T0xVTUUoIkV4dCBNaWMgQm9vc3QiLCAweDE4LCAwLCBIREFfSU5QVVQpLAorCisJSERBX0NPREVD
X1ZPTFVNRSgiSW50IE1pYyBQbGF5YmFjayBWb2x1bWUiLCAweDBiLCAweDEsIEhEQV9JTlBVVCks
CisJSERBX0NPREVDX01VVEUoIkludCBNaWMgUGxheWJhY2sgU3dpdGNoIiwgMHgwYiwgMHgxLCBI
REFfSU5QVVQpLAorCUhEQV9DT0RFQ19WT0xVTUUoIkludCBNaWMgQm9vc3QiLCAweDE5LCAwLCBI
REFfSU5QVVQpLAorCXsgfSAvKiBlbmQgKi8KK307CisKICNpZmRlZiBDT05GSUdfU05EX0hEQV9Q
T1dFUl9TQVZFCiAjZGVmaW5lIGFsYzY2Ml9sb29wYmFja3MJYWxjODgwX2xvb3BiYWNrcwogI2Vu
ZGlmCkBAIC0xNjE4NCw2ICsxNjIzNCw3IEBAIHN0YXRpYyBjb25zdCBjaGFyICphbGM2NjJfbW9k
ZWxzW0FMQzY2Ml8KIAlbQUxDNjYzX0FTVVNfTU9ERTRdID0gImFzdXMtbW9kZTQiLAogCVtBTEM2
NjNfQVNVU19NT0RFNV0gPSAiYXN1cy1tb2RlNSIsCiAJW0FMQzY2M19BU1VTX01PREU2XSA9ICJh
c3VzLW1vZGU2IiwKKwlbQUxDMjcyX1NBTVNVTkdfTkMxMF0gPSAic2Ftc3VuZy1uYzEwIiwKIAlb
QUxDNjYyX0FVVE9dCQk9ICJhdXRvIiwKIH07CiAKQEAgLTE2MjQxLDYgKzE2MjkyLDcgQEAgc3Rh
dGljIHN0cnVjdCBzbmRfcGNpX3F1aXJrIGFsYzY2Ml9jZmdfdAogCVNORF9QQ0lfUVVJUksoMHgx
MDViLCAweDBjZDYsICJGb3hjb25uIiwgQUxDNjYyX0VDUyksCiAJU05EX1BDSV9RVUlSSygweDEw
NWIsIDB4MGQ0NywgIkZveGNvbm4gNDVDTVgvNDVHTVgvNDVDTVgtSyIsCiAJCSAgICAgIEFMQzY2
Ml8zU1RfNmNoX0RJRyksCisJU05EX1BDSV9RVUlSSygweDE0NGQsIDB4Y2EwMCwgIlNhbXN1bmcg
TkMxMCIsIEFMQzI3Ml9TQU1TVU5HX05DMTApLAogCVNORF9QQ0lfUVVJUksoMHgxNDU4LCAweGEw
MDIsICJHaWdhYnl0ZSA5NDVHQ00tUzJMIiwKIAkJICAgICAgQUxDNjYyXzNTVF82Y2hfRElHKSwK
IAlTTkRfUENJX1FVSVJLKDB4MTU2NSwgMHg4MjBmLCAiQmlvc3RhciBUQTc4MEcgTTIrIiwgQUxD
NjYyXzNTVF82Y2hfRElHKSwKQEAgLTE2NTEyLDYgKzE2NTY0LDE4IEBAIHN0YXRpYyBzdHJ1Y3Qg
YWxjX2NvbmZpZ19wcmVzZXQgYWxjNjYyX3AKIAkJLnVuc29sX2V2ZW50ID0gYWxjNjYzX201MXZh
X3Vuc29sX2V2ZW50LAogCQkuaW5pdF9ob29rID0gYWxjNjYzX201MXZhX2luaXRob29rLAogCX0s
CisJW0FMQzI3Ml9TQU1TVU5HX05DMTBdID0geworCQkubWl4ZXJzID0geyBhbGMyNzJfbmMxMF9t
aXhlciB9LAorCQkuaW5pdF92ZXJicyA9IHsgYWxjNjYyX2luaXRfdmVyYnMsCisJCQkJYWxjNjYz
XzIxamRfYW1pY19pbml0X3ZlcmJzIH0sCisJCS5udW1fZGFjcyA9IEFSUkFZX1NJWkUoYWxjMjcy
X2RhY19uaWRzKSwKKwkJLmRhY19uaWRzID0gYWxjMjcyX2RhY19uaWRzLAorCQkubnVtX2NoYW5u
ZWxfbW9kZSA9IEFSUkFZX1NJWkUoYWxjNjYyXzNTVF8yY2hfbW9kZXMpLAorCQkuY2hhbm5lbF9t
b2RlID0gYWxjNjYyXzNTVF8yY2hfbW9kZXMsCisJCS5pbnB1dF9tdXggPSAmYWxjMjcyX25jMTBf
Y2FwdHVyZV9zb3VyY2UsCisJCS51bnNvbF9ldmVudCA9IGFsYzY2M19tb2RlNF91bnNvbF9ldmVu
dCwKKwkJLmluaXRfaG9vayA9IGFsYzY2M19tb2RlNF9pbml0aG9vaywKKwl9LAogfTsKCg==
--0016e6db5c0c9d4db70469a8c60e
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--0016e6db5c0c9d4db70469a8c60e--
