From: "samson.richard@gmail.com" <samson.richard@gmail.com>
Subject: Re: [PATCH] add new Fermi 5xx codec IDs to snd-hda
Date: Mon, 28 Feb 2011 18:56:20 +0100
Message-ID: <AANLkTinP5Y3XF7SjGJLy5XE4ojD4MfG8oA97WJHob-3R@mail.gmail.com>
References: <1298855454.2347.27.camel@cartman.lan>
	<74CDBE0F657A3D45AFBB94109FB122FF045687AE77@HQMAIL01.nvidia.com>
	<s5hk4gknkh4.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f51.google.com (mail-ew0-f51.google.com
	[209.85.215.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 6B3ED10381C
	for <alsa-devel@alsa-project.org>; Mon, 28 Feb 2011 18:56:21 +0100 (CET)
Received: by ewy19 with SMTP id 19so1275478ewy.38
	for <alsa-devel@alsa-project.org>; Mon, 28 Feb 2011 09:56:21 -0800 (PST)
In-Reply-To: <s5hk4gknkh4.wl%tiwai@suse.de>
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Stephen Warren <swarren@nvidia.com>
List-Id: alsa-devel@alsa-project.org

Hello,

Thank you for your replies.

As Stephen Warren said, a patch with full support of 5xx cards will be
more useful.
I'll be able to write a new patch but I don't have the knowledge to
get other IDs.

Richard Samson

2011/2/28 Takashi Iwai <tiwai@suse.de>:
> At Mon, 28 Feb 2011 09:13:29 -0800,
> Stephen Warren wrote:
>>
>> Richard Samson wrote at Sunday, February 27, 2011 6:11 PM:
>> > ...
>> > I added a new entry in patch_hdmi.c to get sound working on my own 560
>> > Ti card :
>> >
>> > --- patch_hdmi.c =A0 =A0 =A0 =A02011-02-15 22:29:51.000000000 +0100
>> > +++ patch_hdmi_GTX-560Ti.c =A0 =A0 =A02011-02-27 23:52:56.984613414 +0=
100
>> ...
>> > patch_nvhdmi_8ch_89 },
>> > =A0{ .id =3D 0x10de0014, .name =3D "GPU 14 HDMI/DP", =A0.patch =3D
>> > patch_nvhdmi_8ch_89 },
>> > +{ .id =3D 0x10de0016, .name =3D "GPU 16 HDMI/DP", =A0 .patch =3D
>> > patch_nvhdmi_8ch_89 },
>> > =A0{ .id =3D 0x10de0018, .name =3D "GPU 18 HDMI/DP", =A0.patch =3D
>> ...
>>
>> Acked-By: Stephen Warren <swarren@nvidia.com>
>>
>> Hmm. When I submitted that last patch, I think I looked at the wrong bra=
nch
>> of our Windows drivers, and hence missed a couple IDs, and added a coupl=
e of
>> IDs that won't be used. Once this is merged, I'll follow up with another
>> patch to fix the other issues (or let me know if you just want me to pro=
vide
>> a single patch with everything in it, Takashi).
>
> I don't mind in either way as long as it's a simple patch.
> As I already asked Richard for re-submitting with his sign-off,
> we can wait for a while.
>
> BTW, this kind of id addition patch can be still merged in 2.6.38
> if the chips listed there are real ones.
>
>
> thanks,
>
> Takashi
>
