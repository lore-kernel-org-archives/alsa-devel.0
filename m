From: =?UTF-8?Q?Adrien_Verg=C3=A9?= <adrienverge@gmail.com>
Subject: Re: [PATCH] ALSA: hda - Fix silent output on MacBook Air 1,1
Date: Fri, 24 Jan 2014 15:46:27 -0500
Message-ID: <CANsc=4XiKexRwApFDdDi09mrduz6BXQPDTz880ucwJA1SOV27Q@mail.gmail.com>
References: <1390593374-6592-1-git-send-email-adrienverge@gmail.com>
	<1390594484.15637.2.camel@x220>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1390594484.15637.2.camel@x220>
Sender: linux-kernel-owner@vger.kernel.org
To: Paul Bolle <pebolle@tiscali.nl>
Cc: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, Nicolo' <nicolopiazzalunga@gmail.com>, David Henningsson <david.henningsson@canonical.com>, Kailang Yang <kailang@realtek.com>, Hui Wang <hui.wang@canonical.com>, alsa-devel <alsa-devel@alsa-project.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

I think very few people use Linux on their MBA 1,1. Moreover, part of
them remained on v2.6.

2014/1/24 Paul Bolle <pebolle@tiscali.nl>:
> On Fri, 2014-01-24 at 14:56 -0500, Adrien Verg=C3=A9 wrote:
>> Similarly to other Apple products, MBA 1,1 needs a specific quirk.
>> Pin 0x18 must be set to VREF_50 to have sound output.  This was no
>> longer done since commit 1a97b7f, resulting in a mute built-in speak=
er.
>
> Commit 1a97b7f ("ALSA: hda/realtek - Remove the last static quirks fo=
r
> ALC882") was included in v3.4. Did no-one notice this for 9 releases?
>
>> This patch corrects the regression by creating a fixup for the MBA 1=
,1.
>>
>> Tested-by: Adrien Verg=C3=A9 <adrienverge@gmail.com>
>> Signed-off-by: Adrien Verg=C3=A9 <adrienverge@gmail.com>
>
>
> Paul Bolle
>
