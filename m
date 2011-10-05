From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: amixer cget :Assertion `ctl && info &&
 (info->id.name[0] || info->id.numid)' failed. Aborted
Date: Wed, 5 Oct 2011 15:25:44 +0800
Message-ID: <CAN8ccib5ymF1DLMBLdmO-hc9FtHHJ9nV=kWgQ-zDEJnKQ59f+g@mail.gmail.com>
References: <CAN8cciZmMsDx+0tX8izFzXpLPpSD2YS==BN=oG0KWFg9rBaxOA@mail.gmail.com>
	<s5hzkhiqj5q.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f51.google.com (mail-bw0-f51.google.com
	[209.85.214.51])
	by alsa0.perex.cz (Postfix) with ESMTP id F24CB103856
	for <alsa-devel@alsa-project.org>;
	Wed,  5 Oct 2011 09:25:44 +0200 (CEST)
Received: by bkbzu17 with SMTP id zu17so1617978bkb.38
	for <alsa-devel@alsa-project.org>; Wed, 05 Oct 2011 00:25:44 -0700 (PDT)
In-Reply-To: <s5hzkhiqj5q.wl%tiwai@suse.de>
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

2011/10/3 Takashi Iwai <tiwai@suse.de>:
> At Sat, 1 Oct 2011 11:30:44 +0800,
> Raymond Yau wrote:
>>
>> There is assertion when specify iface=3DPCM =A0or iface=3DPCM,name=3D'' =
when
>> using amixer -c0 cget
>>
>> according to the synthax
>>
>> [[iface=3D<iface>,][name=3D'name',][index=3D<index>,][device=3D<device>,=
][subdevice=3D<subdevice>]]|[numid=3D<numid>]
>>
>>
>> amixer -c0 cget iface=3DPCM
>> amixer: control.c:258: snd_ctl_elem_info: Assertion `ctl && info &&
>> (info->id.name[0] || info->id.numid)' failed.
>> Aborted
>>
>> amixer -c0 cget iface=3DPCM,name=3D''
>> amixer: control.c:258: snd_ctl_elem_info: Assertion `ctl && info &&
>> (info->id.name[0] || info->id.numid)' failed.
>> Aborted
>
> So, the empty string isn't checked before assert(). =A0It's bad.
> It must be easy to fix. =A0Care to create and send a patch?
>
>

The syntax seem also wrong.

[[iface=3D<iface>,][name=3D'name',][index=3D<index>,][device=3D<device>,][s=
ubdevice=3Dsubdevice>]]|[numid=3D<numid>]


it should be
 [numid=3D<numid>] |
 [[iface=3D<iface>,name=3D'name'][,index=3D<index>][,device=3D<device>]] |
 [[iface=3D<iface>,name=3D'name'][,device=3D<device>][,subdevice=3D<subdevi=
ce>]]

since you cannot specify index and subdevice at the same time
