From: "Nicolo'" <nicolopiazzalunga@gmail.com>
Subject: Re: [PATCH] ALSA: hda - Fix silent output on MacBook Air 1,1
Date: Sat, 25 Jan 2014 11:17:15 +0100
Message-ID: <CABru_zWurg5tiOy-LtyizB0bqK5HoTScw0f3TizX4VHTorttTw@mail.gmail.com>
References: <1390593374-6592-1-git-send-email-adrienverge@gmail.com>
 <1390594484.15637.2.camel@x220> <CANsc=4XiKexRwApFDdDi09mrduz6BXQPDTz880ucwJA1SOV27Q@mail.gmail.com>
 <1390597685.15637.6.camel@x220> <s5hd2jgpj81.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <s5hd2jgpj81.wl%tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Paul Bolle <pebolle@tiscali.nl>, =?ISO-8859-1?Q?Adrien_Verg=E9?= <adrienverge@gmail.com>, Jaroslav Kysela <perex@perex.cz>, David Henningsson <david.henningsson@canonical.com>, Kailang Yang <kailang@realtek.com>, Hui Wang <hui.wang@canonical.com>, alsa-devel <alsa-devel@alsa-project.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

I can confirm this happens on my machine too: does anybody have a hint
on why changing VREF on 0x18 mutes/unmutes speakers and hp, which are
on 0x14 and 0x15 ?

On Sat, Jan 25, 2014 at 9:18 AM, Takashi Iwai <tiwai@suse.de> wrote:
> At Fri, 24 Jan 2014 22:08:05 +0100,
> Paul Bolle wrote:
>>
>> On Fri, 2014-01-24 at 15:46 -0500, Adrien Verg=E9 wrote:
>> > I think very few people use Linux on their MBA 1,1. Moreover, part=
 of
>> > them remained on v2.6.
>>
>> I see. Well, if your analysis is correct I think you're supposed to =
add
>>      Fixes: 1a97b7f22774 ("ALSA: hda/realtek - Remove the last stati=
c quirks for ALC882")
>>
>> to your commit explanation. Not sure, since this tag is not document=
ed,
>> as far as I can see.
>
> I applied with fixes and cc-to-stable tags now.
>
> thanks,
>
> Takashi
