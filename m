From: Pavel Hofman <pavel.hofman@ivitera.com>
Subject: Re: Spdif: Control interface
Date: Wed, 09 Nov 2011 08:50:12 +0100
Message-ID: <4EBA30B4.7090607@ivitera.com>
References: <CAL7V=_GbT_um=KGjMjXVcYnR197Sqj8XjXeoP2XnX6Nq3wKAHg@mail.gmail.com>	<4EB99477.5050208@ivitera.com>
	<CAL7V=_ERiQSqUQDyaV=8dSiwNZmUOpRO-x1mHRCF=fsAMSdSsA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cable.insite.cz (twistwrist.pilsfree.net [78.108.108.109])
	by alsa0.perex.cz (Postfix) with ESMTP id 85FC41039D2
	for <alsa-devel@alsa-project.org>; Wed,  9 Nov 2011 08:50:13 +0100 (CET)
In-Reply-To: <CAL7V=_ERiQSqUQDyaV=8dSiwNZmUOpRO-x1mHRCF=fsAMSdSsA@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ajay khandelwal <ajay.lforum@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Dne 9.11.2011 06:28, ajay khandelwal napsal(a):
> Hi Pavel,
>  Thanks for reply
> 
> Simple mixer control 'IEC958 Playback AC97-SPSA',0
>   Capabilities: volume volume-joined penum
>   Playback channels: Mono
>   Capture channels: Mono
>   Limits: 0 - 3
>   Mono: 3 [100%]

Thanks. I assume you mean this control. For meaning of this control see
e.g. http://alsa.opensrc.org/Realtek_ALC650#SPDIF_support

It is not related to volume, IMO capabilities of this control are
incorrect, there should be "enum" instead. Perhaps changing
SNDRV_CTL_ELEM_TYPE_INTEGER to SNDRV_CTL_ELEM_TYPE_ENUMERATED ?

The code around this control is
http://git.alsa-project.org/?p=alsa-kmirror.git;a=blob;f=pci/ac97/ac97_codec.c;hb=HEAD#l874
. Perhaps the

.info = snd_ac97_info_volsw

should use a different method, setting the ENUM type.

Unfortunately, I do not have the HW to test any changes.

Regards,

Pavel.
