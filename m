From: Li Bo <liboat@gmail.com>
Subject: Re: [PATCH 18/31] HDA patch_via.c: Add 48K sample rate
	limit for S/PDIF streams.
Date: Tue, 6 Oct 2009 12:41:12 +0800
Message-ID: <16685ee0910052141q6b31b7bcnb46efc360fd78d35@mail.gmail.com>
References: <16685ee0910050727k409b03fdj1b03afd9c9521db2@mail.gmail.com>
	<s5h4oqd6ff0.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f212.google.com (mail-fx0-f212.google.com
	[209.85.220.212])
	by alsa0.perex.cz (Postfix) with ESMTP id ABD8710381D
	for <alsa-devel@alsa-project.org>;
	Tue,  6 Oct 2009 06:41:13 +0200 (CEST)
Received: by fxm8 with SMTP id 8so3303728fxm.45
	for <alsa-devel@alsa-project.org>; Mon, 05 Oct 2009 21:41:13 -0700 (PDT)
In-Reply-To: <s5h4oqd6ff0.wl%tiwai@suse.de>
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

Hi, Takashi
  According to our HW test, S/PDIF at 48K sample rate has best SNR, so
  this limit can make S/PDIF work better.

On Mon, Oct 5, 2009 at 11:14 PM, Takashi Iwai <tiwai@suse.de> wrote:
> At Mon, 5 Oct 2009 22:27:43 +0800,
> Li Bo wrote:
>>
>> [ALSA] HDA VIA: Add 48K sample rate limit for S/PDIF streams.
>>
>> Signed-off-by: Lydia Wang <lydiawang@viatech.com.cn>
>
> Any reason?
>
>
> Takashi
>
>>
>> Index: sound-2.6/sound/pci/hda/patch_via.c
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> --- sound-2.6.orig/sound/pci/hda/patch_via.c =A02009-10-05 15:11:02.0000=
00000 +0800
>> +++ sound-2.6/sound/pci/hda/patch_via.c =A0 =A0 =A0 2009-10-05 15:11:04.=
000000000 +0800
>> @@ -1228,6 +1228,7 @@
>> =A0 =A0 =A0 .substreams =3D 1,
>> =A0 =A0 =A0 .channels_min =3D 2,
>> =A0 =A0 =A0 .channels_max =3D 2,
>> + =A0 =A0 .rates =3D SNDRV_PCM_RATE_48000,
>> =A0 =A0 =A0 /* NID is set in via_build_pcms */
>> =A0 =A0 =A0 .ops =3D {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 .open =3D via_dig_playback_pcm_open,
>> @@ -1241,6 +1242,7 @@
>> =A0 =A0 =A0 .substreams =3D 1,
>> =A0 =A0 =A0 .channels_min =3D 2,
>> =A0 =A0 =A0 .channels_max =3D 2,
>> + =A0 =A0 .rates =3D SNDRV_PCM_RATE_48000,
>> =A0};
>>
>> =A0static int via_build_controls(struct hda_codec *codec)
>> @@ -2042,6 +2044,7 @@
>> =A0 =A0 =A0 .substreams =3D 1,
>> =A0 =A0 =A0 .channels_min =3D 2,
>> =A0 =A0 =A0 .channels_max =3D 2,
>> + =A0 =A0 .rates =3D SNDRV_PCM_RATE_48000,
>> =A0 =A0 =A0 /* NID is set in via_build_pcms */
>> =A0 =A0 =A0 .ops =3D {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 .open =3D via_dig_playback_pcm_open,
>> @@ -2657,6 +2660,7 @@
>> =A0 =A0 =A0 .substreams =3D 1,
>> =A0 =A0 =A0 .channels_min =3D 2,
>> =A0 =A0 =A0 .channels_max =3D 2,
>> + =A0 =A0 .rates =3D SNDRV_PCM_RATE_48000,
>> =A0 =A0 =A0 /* NID is set in via_build_pcms */
>> =A0 =A0 =A0 .ops =3D {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 .open =3D via_dig_playback_pcm_open,
>> @@ -3137,6 +3141,7 @@
>> =A0 =A0 =A0 .substreams =3D 2,
>> =A0 =A0 =A0 .channels_min =3D 2,
>> =A0 =A0 =A0 .channels_max =3D 2,
>> + =A0 =A0 .rates =3D SNDRV_PCM_RATE_48000,
>> =A0 =A0 =A0 /* NID is set in via_build_pcms */
>> =A0 =A0 =A0 .ops =3D {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 .open =3D via_dig_playback_pcm_open,
>> @@ -3581,6 +3586,7 @@
>> =A0 =A0 =A0 .substreams =3D 2,
>> =A0 =A0 =A0 .channels_min =3D 2,
>> =A0 =A0 =A0 .channels_max =3D 2,
>> + =A0 =A0 .rates =3D SNDRV_PCM_RATE_48000,
>> =A0 =A0 =A0 /* NID is set in via_build_pcms */
>> =A0 =A0 =A0 .ops =3D {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 .open =3D via_dig_playback_pcm_open,
>>
>
