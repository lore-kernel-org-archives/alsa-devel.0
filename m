From: Li Bo <liboat@gmail.com>
Subject: Re: [PATCH 17/31] HDA patch_via.c: Add second S/PDIF
	out control for VT1708S and VT1702.
Date: Tue, 6 Oct 2009 13:01:42 +0800
Message-ID: <16685ee0910052201n74138c01g69c08e5fe7f59f04@mail.gmail.com>
References: <16685ee0910050727n4f3eb80ah113d214815de6342@mail.gmail.com>
	<s5h63at6fff.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f212.google.com (mail-fx0-f212.google.com
	[209.85.220.212])
	by alsa0.perex.cz (Postfix) with ESMTP id 862EF103882
	for <alsa-devel@alsa-project.org>;
	Tue,  6 Oct 2009 07:01:42 +0200 (CEST)
Received: by fxm8 with SMTP id 8so3309172fxm.45
	for <alsa-devel@alsa-project.org>; Mon, 05 Oct 2009 22:01:42 -0700 (PDT)
In-Reply-To: <s5h63at6fff.wl%tiwai@suse.de>
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
Cc: LoganLi@viatech.com.cn, alsa-devel@alsa-project.org, HaraldWelte@viatech.com, lydiawang@viatech.com.cn
List-Id: alsa-devel@alsa-project.org

They are separate S/PDIFs, and in our test, slave SPDIF  seems can work
 independently with master SPDIF. I'll do some test later.

On Mon, Oct 5, 2009 at 11:14 PM, Takashi Iwai <tiwai@suse.de> wrote:
> At Mon, 5 Oct 2009 22:27:35 +0800,
> Li Bo wrote:
>>
>> [ALSA] HDA VIA: Add second S/PDIF out control for VT1708S and VT1702.
>>
>> Signed-off-by: Lydia Wang <lydiawang@viatech.com.cn>
>
> The slave SPDIFs are really slaves. =A0They are supposed to have identical
> SPDIF status bits as the master. =A0So, creating the individual SPDIF sta=
tus
> controls is wrong.
>
> If they have to be handled separately, we shouldn't use slave SPDIF but
> create different streams, etc.
>
>
> Takashi
>
>
>>
>> Index: sound-2.6/sound/pci/hda/patch_via.c
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> --- sound-2.6.orig/sound/pci/hda/patch_via.c =A02009-10-05 15:10:59.0000=
00000 +0800
>> +++ sound-2.6/sound/pci/hda/patch_via.c =A0 =A0 =A0 2009-10-05 15:11:02.=
000000000 +0800
>> @@ -1265,6 +1265,13 @@
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (err < 0)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return err;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 spec->multiout.share_spdif =3D 1;
>> + =A0 =A0 =A0 =A0 =A0 =A0 /* lydia add for second spdif out */
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (spec->slave_dig_outs[0]) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D snd_hda_create_spdif_o=
ut_ctls(codec,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 spec->slave_dig_outs[0]);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (err < 0)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return err;
>> + =A0 =A0 =A0 =A0 =A0 =A0 }
>> =A0 =A0 =A0 }
>> =A0 =A0 =A0 if (spec->dig_in_nid) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D snd_hda_create_spdif_in_ctls(codec, =
spec->dig_in_nid);
>> @@ -3127,7 +3134,7 @@
>> =A0};
>>
>> =A0static struct hda_pcm_stream vt1708S_pcm_digital_playback =3D {
>> - =A0 =A0 .substreams =3D 1,
>> + =A0 =A0 .substreams =3D 2,
>> =A0 =A0 =A0 .channels_min =3D 2,
>> =A0 =A0 =A0 .channels_max =3D 2,
>> =A0 =A0 =A0 /* NID is set in via_build_pcms */
>>
>
