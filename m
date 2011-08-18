From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: Lost dB volumes on USB headset between 2.6.38 and
	3.0
Date: Fri, 19 Aug 2011 06:55:54 +0800
Message-ID: <CAN8cciZ=u98SFp_n4dxix7R7-WpB-zTOQh+qvkxuKs=jyKVzyQ@mail.gmail.com>
References: <4E410361.7010808@canonical.com> <4E410E7D.8050903@ladisch.de>
	<4E4117C9.2090100@colin.guthr.ie> <s5hwremdagh.wl%tiwai@suse.de>
	<4E4A6338.6020309@colin.guthr.ie> <s5hfwkyu4su.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f51.google.com (mail-fx0-f51.google.com
	[209.85.161.51]) by alsa0.perex.cz (Postfix) with ESMTP id A998424353
	for <alsa-devel@alsa-project.org>;
	Fri, 19 Aug 2011 00:55:54 +0200 (CEST)
Received: by fxh10 with SMTP id 10so1759810fxh.38
	for <alsa-devel@alsa-project.org>; Thu, 18 Aug 2011 15:55:54 -0700 (PDT)
In-Reply-To: <s5hfwkyu4su.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

2011/8/18 Takashi Iwai <tiwai@suse.de>:
> At Tue, 16 Aug 2011 13:31:52 +0100,
> Colin Guthrie wrote:
>>
>> > diff --git a/sound/usb/mixer.c b/sound/usb/mixer.c
>> > index c04d7c7..cdd19d7 100644
>> > --- a/sound/usb/mixer.c
>> > +++ b/sound/usb/mixer.c
>> > @@ -152,6 +152,7 @@ static inline void check_mapped_dB(const struct us=
bmix_name_map *p,
>> > =A0 =A0 if (p && p->dB) {
>> > =A0 =A0 =A0 =A0 =A0 =A0 cval->dBmin =3D p->dB->min;
>> > =A0 =A0 =A0 =A0 =A0 =A0 cval->dBmax =3D p->dB->max;
>> > + =A0 =A0 =A0 =A0 =A0 cval->initialized =3D 1;
>> > =A0 =A0 }
>> > =A0}
>> >
>> > @@ -1092,7 +1093,7 @@ static void build_feature_ctl(struct mixer_build=
 *state, void *raw_desc,
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 " Switch" : " =
Volume");
>> > =A0 =A0 =A0 =A0 =A0 =A0 if (control =3D=3D UAC_FU_VOLUME) {
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 check_mapped_dB(map, cval);
>> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (cval->dBmin < cval->dBmax) {
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (cval->dBmin < cval->dBmax ||=
 !cval->initialized) {
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 kctl->tlv.c =
=3D mixer_vol_tlv;
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 kctl->vd[0].ac=
cess |=3D
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 SNDRV_CTL_ELEM_ACCESS_TLV_READ |
>>
>>
>>
>> Not had a chance to test this yet but I will when I get a moment.
>
> Any chance to test the patch?
>

The patch seem fix the no dB scale problem , however the broken dB
test which you added seem redundant as cval->dBmin and cval->dBmax are
still zero because error in get_min_max() at build_feature_ctl() and
it seem that the valid dBmin and dBMax are calculated by get_min_max()
at mixer_ctl_feature_info() on my usb logitech web cam


LSA endpoint.c:450: 2:3:1: add audio endpoint 0x86
ALSA mixer.c:1182: [5] FU [Mic Capture Switch] ch =3D 1, val =3D 0/1/1
ALSA mixer.c:804: 5:2: cannot get min/max values for control 2 (id 5)
ALSA mixer.c:1182: [5] FU [Mic Capture Volume] ch =3D 1, val =3D 0/1/1
ALSA mixer.c:804: 5:2: cannot get min/max values for control 2 (id 5)
usbcore: registered new interface driver snd-usb-audio
