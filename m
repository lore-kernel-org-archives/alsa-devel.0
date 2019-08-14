From: =?UTF-8?B?5b2t6L6J?= <benquike@gmail.com>
Subject: Re: [PATCH] Fix an OOB bug in parse_audio_mixer_unit
Date: Wed, 14 Aug 2019 12:52:07 -0400
Message-ID: <CAKpmkkVzT5H0RTAu_Fa=9_gjf5v7k3qzPnnJvPpBp3BaP7G0ag@mail.gmail.com>
References: <20190814023625.21683-1-benquike@gmail.com>
 <s5hzhkcb6dh.wl-tiwai@suse.de>
 <CAKpmkkUv=arsdJiexaM-UVhXEwfGN=zreny9P_kDNhQUij8=FQ@mail.gmail.com>
 <s5hmugbbtc2.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="0000000000008b7f79059016947b"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com
 [IPv6:2607:f8b0:4864:20::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 8672BF8015B
 for <alsa-devel@alsa-project.org>; Wed, 14 Aug 2019 18:52:21 +0200 (CEST)
Received: by mail-oi1-x242.google.com with SMTP id 16so4687483oiq.6
 for <alsa-devel@alsa-project.org>; Wed, 14 Aug 2019 09:52:20 -0700 (PDT)
In-Reply-To: <s5hmugbbtc2.wl-tiwai@suse.de>
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
Cc: Mathias Payer <mathias.payer@nebelwelt.net>, security@kernel.org, Wenwen Wang <wang6495@umn.edu>, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, YueHaibing <yuehaibing@huawei.com>, alsa-devel@alsa-project.org, Thomas Gleixner <tglx@linutronix.de>, Allison Randal <allison@lohutok.net>
List-Id: alsa-devel@alsa-project.org

--0000000000008b7f79059016947b
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Takashi:

Thanks for the guide.
The new patch is confirmed and attached.

On Wed, Aug 14, 2019 at 12:33 PM Takashi Iwai <tiwai@suse.de> wrote:

> On Wed, 14 Aug 2019 18:28:39 +0200,
> =E5=BD=AD=E8=BE=89 wrote:
> >
> > Hi, Takashi:
> > Here the problem is that `desc->bLength` is controlled by the device
> side,
> > so  `desc->bLength` may not represent the real length of the descriptor=
.
> > That is why I use pointer arithmetic operations to derive the real size
> of the
> > buffer
> > in my patch.
>
> But bLength is checked before calling this, i.e. it's already assured
> that bLength fits within the buffer limit.  So, the result calls don't
> have to care about the buffer limit itself, and they can just
> concentrate on overflow over bLength.
>
>
> thanks,
>
> Takashi
>
> >
> > On Wed, Aug 14, 2019 at 2:36 AM Takashi Iwai <tiwai@suse.de> wrote:
> >
> >     On Wed, 14 Aug 2019 04:36:24 +0200,
> >     Hui Peng wrote:
> >     >
> >     > The `uac_mixer_unit_descriptor` shown as below is read from the
> >     > device side. In `parse_audio_mixer_unit`, `baSourceID` field is
> >     > accessed from index 0 to `bNrInPins` - 1, the current
> implementation
> >     > assumes that descriptor is always valid (the length  of descripto=
r
> >     > is no shorter than 5 + `bNrInPins`). If a descriptor read from
> >     > the device side is invalid, it may trigger out-of-bound memory
> >     > access.
> >     >
> >     > ```
> >     > struct uac_mixer_unit_descriptor {
> >     >       __u8 bLength;
> >     >       __u8 bDescriptorType;
> >     >       __u8 bDescriptorSubtype;
> >     >       __u8 bUnitID;
> >     >       __u8 bNrInPins;
> >     >       __u8 baSourceID[];
> >     > }
> >     > ```
> >     >
> >     > This patch fixes the bug by add a sanity check on the length of
> >     > the descriptor.
> >     >
> >     > Signed-off-by: Hui Peng <benquike@gmail.com>
> >     > Reported-by: Hui Peng <benquike@gmail.com>
> >     > Reported-by: Mathias Payer <mathias.payer@nebelwelt.net>
> >     > ---
> >     >  sound/usb/mixer.c | 9 +++++++++
> >     >  1 file changed, 9 insertions(+)
> >     >
> >     > diff --git a/sound/usb/mixer.c b/sound/usb/mixer.c
> >     > index 7498b5191b68..38202ce67237 100644
> >     > --- a/sound/usb/mixer.c
> >     > +++ b/sound/usb/mixer.c
> >     > @@ -2091,6 +2091,15 @@ static int parse_audio_mixer_unit(struct
> >     mixer_build *state, int unitid,
> >     >       struct usb_audio_term iterm;
> >     >       int input_pins, num_ins, num_outs;
> >     >       int pin, ich, err;
> >     > +     int desc_len =3D (int) ((unsigned long) state->buffer +
> >     > +                     state->buflen - (unsigned long) raw_desc);
> >     > +
> >     > +     if (desc_len < sizeof(*desc) + desc->bNrInPins) {
> >     > +             usb_audio_err(state->chip,
> >     > +                           "descriptor %d too short\n",
> >     > +                           unitid);
> >     > +             return -EINVAL;
> >     > +     }
> >     >
> >     >       err =3D uac_mixer_unit_get_channels(state, desc);
> >     >       if (err < 0) {
> >
> >     Hm, what is the desc->bLength value in the error case?
> >
> >     Basically the buffer boundary is already checked against bLength in
> >     snd_usb_find_desc() which is called from obtaining the raw_desc in
> the
> >     caller of this function (parse_audio_unit()).
> >
> >     So, if any, we need to check bLength for the possible overflow like
> >     below.
> >
> >     thanks,
> >
> >     Takashi
> >
> >     --- a/sound/usb/mixer.c
> >     +++ b/sound/usb/mixer.c
> >     @@ -744,6 +744,8 @@ static int uac_mixer_unit_get_channels(struct
> >     mixer_build *state,
> >                     return -EINVAL;
> >             if (!desc->bNrInPins)
> >                     return -EINVAL;
> >     +       if (desc->bLength < sizeof(*desc) + desc->bNrInPins)
> >     +               return -EINVAL;
> >
> >             switch (state->mixer->protocol) {
> >             case UAC_VERSION_1:
> >
> > --
> > May the Lord Richly Bless you and yours !
> >
> >
>


--=20
May the *Lord* Richly Bless you and yours !

--0000000000008b7f79059016947b
Content-Type: text/x-patch; charset="US-ASCII";
	name="0001-Fix-an-OOB-bug-in-parse_audio_mixer_unit.patch"
Content-Disposition: attachment;
	filename="0001-Fix-an-OOB-bug-in-parse_audio_mixer_unit.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_jzbhs3jz0>
X-Attachment-Id: f_jzbhs3jz0

RnJvbSBkYTE3ZTJkYjA0ZDI5ZDM5ZjMyOTg3MzhiYWRkMDM2Y2YzZjI1NmQyIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBIdWkgUGVuZyA8YmVucXVpa2VAZ21haWwuY29tPgpEYXRlOiBU
dWUsIDEzIEF1ZyAyMDE5IDIyOjM0OjA0IC0wNDAwClN1YmplY3Q6IFtQQVRDSF0gRml4IGFuIE9P
QiBidWcgaW4gcGFyc2VfYXVkaW9fbWl4ZXJfdW5pdAoKVGhlIGB1YWNfbWl4ZXJfdW5pdF9kZXNj
cmlwdG9yYCBzaG93biBhcyBiZWxvdyBpcyByZWFkIGZyb20gdGhlCmRldmljZSBzaWRlLiBJbiBg
cGFyc2VfYXVkaW9fbWl4ZXJfdW5pdGAsIGBiYVNvdXJjZUlEYCBmaWVsZCBpcwphY2Nlc3NlZCBm
cm9tIGluZGV4IDAgdG8gYGJOckluUGluc2AgLSAxLCB0aGUgY3VycmVudCBpbXBsZW1lbnRhdGlv
bgphc3N1bWVzIHRoYXQgZGVzY3JpcHRvciBpcyBhbHdheXMgdmFsaWQgKHRoZSBsZW5ndGggIG9m
IGRlc2NyaXB0b3IKaXMgbm8gc2hvcnRlciB0aGFuIDUgKyBgYk5ySW5QaW5zYCkuIElmIGEgZGVz
Y3JpcHRvciByZWFkIGZyb20KdGhlIGRldmljZSBzaWRlIGlzIGludmFsaWQsIGl0IG1heSB0cmln
Z2VyIG91dC1vZi1ib3VuZCBtZW1vcnkKYWNjZXNzLgoKYGBgCnN0cnVjdCB1YWNfbWl4ZXJfdW5p
dF9kZXNjcmlwdG9yIHsKCV9fdTggYkxlbmd0aDsKCV9fdTggYkRlc2NyaXB0b3JUeXBlOwoJX191
OCBiRGVzY3JpcHRvclN1YnR5cGU7CglfX3U4IGJVbml0SUQ7CglfX3U4IGJOckluUGluczsKCV9f
dTggYmFTb3VyY2VJRFtdOwp9CmBgYAoKVGhpcyBwYXRjaCBmaXhlcyB0aGUgYnVnIGJ5IGFkZCBh
IHNhbml0eSBjaGVjayBvbiB0aGUgbGVuZ3RoIG9mCnRoZSBkZXNjcmlwdG9yLgoKU2lnbmVkLW9m
Zi1ieTogSHVpIFBlbmcgPGJlbnF1aWtlQGdtYWlsLmNvbT4KUmVwb3J0ZWQtYnk6IEh1aSBQZW5n
IDxiZW5xdWlrZUBnbWFpbC5jb20+ClJlcG9ydGVkLWJ5OiBNYXRoaWFzIFBheWVyIDxtYXRoaWFz
LnBheWVyQG5lYmVsd2VsdC5uZXQ+Ci0tLQogc291bmQvdXNiL21peGVyLmMgfCAyICsrCiAxIGZp
bGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvc291bmQvdXNiL21peGVy
LmMgYi9zb3VuZC91c2IvbWl4ZXIuYwppbmRleCA3NDk4YjUxOTFiNjguLmVhNDg3Mzc4YmUxNyAx
MDA2NDQKLS0tIGEvc291bmQvdXNiL21peGVyLmMKKysrIGIvc291bmQvdXNiL21peGVyLmMKQEAg
LTc0NCw2ICs3NDQsOCBAQCBzdGF0aWMgaW50IHVhY19taXhlcl91bml0X2dldF9jaGFubmVscyhz
dHJ1Y3QgbWl4ZXJfYnVpbGQgKnN0YXRlLAogCQlyZXR1cm4gLUVJTlZBTDsKIAlpZiAoIWRlc2Mt
PmJOckluUGlucykKIAkJcmV0dXJuIC1FSU5WQUw7CisJaWYgKGRlc2MtPmJMZW5ndGggPCBzaXpl
b2YoKmRlc2MpICsgZGVzYy0+Yk5ySW5QaW5zKQorCQlyZXR1cm4gLUVJTlZBTDsKIAogCXN3aXRj
aCAoc3RhdGUtPm1peGVyLT5wcm90b2NvbCkgewogCWNhc2UgVUFDX1ZFUlNJT05fMToKLS0gCjIu
MjIuMQoK
--0000000000008b7f79059016947b
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--0000000000008b7f79059016947b--
