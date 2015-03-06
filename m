From: =?ISO-8859-1?Q?Ingo=20Br=FCckl?= <ib@wupperonline.de>
Subject: Re: Intel HDA / ALC662 analog surround problem
Date: Fri, 06 Mar 2015 11:03:14 +0100
Message-ID: <54f97b6b.77d1f7d1.bm001@wupperonline.de>
References: <s5h1tl21nsr.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from moutD.wup.tal.de (moutd.wup.tal.de [213.240.144.30])
 by alsa0.perex.cz (Postfix) with ESMTP id A59E9265AE1
 for <alsa-devel@alsa-project.org>; Fri,  6 Mar 2015 11:04:26 +0100 (CET)
In-Reply-To: <s5h1tl21nsr.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: tiwai@suse.de, superquad.vortex2@gmail.com, david.henningsson@canonical.com
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote on Fri, 06 Mar 2015 10:24:20 +0100:

> At Thu, 05 Mar 2015 17:52:19 +0100,
> Ingo Br=FCckl wrote:
>>
>> Raymond Yau wrote on Fri, 27 Feb 2015 10:11:20 +0800:
>>
>> > Try [...] to change node 0x15 Speaker as not connected
>>
>> This is exactly what I did now:
>>
>> diff -Nur a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
>> --- a/sound/pci/hda/patch_realtek.c   2015-02-27 02:49:36.000000000 +0100
>> +++ b/sound/pci/hda/patch_realtek.c   2015-03-05 17:09:15.305016021 +0100
>> @@ -5665,9 +5665,10 @@
>>
>>  static int alc662_parse_auto_config(struct hda_codec *codec)
>>  {
>> -     static const hda_nid_t alc662_ignore[] =3D { 0x1d, 0 };
>> +     /* ignore internal speaker (0x15) in order to get a multi-io confi=
g */
>> +     static const hda_nid_t alc662_ignore[] =3D { 0x15, 0x1d, 0 };
>>       static const hda_nid_t alc663_ssids[] =3D { 0x15, 0x1b, 0x14, 0x21=
 };
>> -     static const hda_nid_t alc662_ssids[] =3D { 0x15, 0x1b, 0x14, 0 };
>> +     static const hda_nid_t alc662_ssids[] =3D { 0x1b, 0x14, 0 };
>>       const hda_nid_t *ssids;
>>
>>       if (codec->vendor_id =3D=3D 0x10ec0272 || codec->vendor_id =3D=3D =
0x10ec0663 ||
>>
>> It gives me the multi-io config without side effects and without the
>> hp_lo_shared and spk_lo_shared issue in get_line_out_pfx().

> Well, the starting point is wrong.  You cannot ignore pins if you
> really use them.  It might look as if something is working casually,
> but this isn't supposed to work at all.

I'm not using it.

Since it seems impossible to use it in addition to have a multi-io 6ch
config, I've decided to "cut" it off.

Ingo
