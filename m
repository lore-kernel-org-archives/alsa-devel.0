From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: Lost dB volumes on USB headset between 2.6.38 and
	3.0
Date: Tue, 23 Aug 2011 11:02:23 +0800
Message-ID: <CAN8cciZT5_9=vnQp-Qcck5r2wfNbN-vkiQGdMAn=vU_hgaQhdg@mail.gmail.com>
References: <4E410361.7010808@canonical.com> <4E410E7D.8050903@ladisch.de>
	<4E4117C9.2090100@colin.guthr.ie> <s5hwremdagh.wl%tiwai@suse.de>
	<4E4A6338.6020309@colin.guthr.ie> <s5hfwkyu4su.wl%tiwai@suse.de>
	<CAN8cciZ=u98SFp_n4dxix7R7-WpB-zTOQh+qvkxuKs=jyKVzyQ@mail.gmail.com>
	<s5h4o1elzfb.wl%tiwai@suse.de> <s5hzkj6kjuo.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f51.google.com (mail-fx0-f51.google.com
	[209.85.161.51]) by alsa0.perex.cz (Postfix) with ESMTP id CE307244A8
	for <alsa-devel@alsa-project.org>;
	Tue, 23 Aug 2011 05:02:29 +0200 (CEST)
Received: by fxh10 with SMTP id 10so132347fxh.38
	for <alsa-devel@alsa-project.org>; Mon, 22 Aug 2011 20:02:23 -0700 (PDT)
In-Reply-To: <s5hzkj6kjuo.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

2011/8/19 Takashi Iwai <tiwai@suse.de>:
> At Fri, 19 Aug 2011 07:53:44 +0200,
> Takashi Iwai wrote:
>>
>>
>> Yeah, that's a known problem. =A0The dB-test is missing when reading dB
>> failed at probing time and later it gives a wrong value.
>>
>> We can add another dB-test later, and remove TLV bit from
>> kcontrol.access on the fly. =A0But for that, we'd need to notify via
>> SNDRV_CTL_EVENT_MASK_INFO, too.
>
> I meant something like below.
>
>
> Takashi
>
> ---
> diff --git a/sound/usb/mixer.c b/sound/usb/mixer.c
> index cdd19d7..78a5abd 100644
> --- a/sound/usb/mixer.c
> +++ b/sound/usb/mixer.c
> @@ -881,8 +881,17 @@ static int mixer_ctl_feature_info(struct snd_kcontro=
l *kcontrol, struct snd_ctl_
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0uinfo->value.integer.min =3D 0;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0uinfo->value.integer.max =3D 1;
> =A0 =A0 =A0 =A0} else {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (! cval->initialized)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 get_min_max(cval, =A00);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!cval->initialized) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 get_min_max(cval, 0);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (cval->initialized && cv=
al->dBmin >=3D cval->dBmax) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 kcontrol->v=
d[0].access &=3D
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 ~(SNDRV_CTL_ELEM_ACCESS_TLV_READ |
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 SNDRV_CTL_ELEM_ACCESS_TLV_CALLBACK);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 snd_ctl_not=
ify(cval->mixer->chip->card,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0SNDRV_CTL_EVENT_MASK_INFO,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0&kcontrol->id);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0uinfo->value.integer.min =3D 0;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0uinfo->value.integer.max =3D
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(cval->max - cval->min + c=
val->res - 1) / cval->res;
>

I have doubt about this removal of tlv is enough since values of dB
scale are calculated from min and max of the control , as dBmin >=3D
dBmax imply min >=3D max and the control already has a invalid range and
unusable
