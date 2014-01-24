From: Paul Bolle <pebolle@tiscali.nl>
Subject: Re: [PATCH] ALSA: hda - Fix silent output on MacBook Air 1,1
Date: Fri, 24 Jan 2014 22:08:05 +0100
Message-ID: <1390597685.15637.6.camel@x220>
References: <1390593374-6592-1-git-send-email-adrienverge@gmail.com>
	 <1390594484.15637.2.camel@x220>
	 <CANsc=4XiKexRwApFDdDi09mrduz6BXQPDTz880ucwJA1SOV27Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CANsc=4XiKexRwApFDdDi09mrduz6BXQPDTz880ucwJA1SOV27Q@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Adrien =?ISO-8859-1?Q?Verg=E9?= <adrienverge@gmail.com>
Cc: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, Nicolo' <nicolopiazzalunga@gmail.com>, David Henningsson <david.henningsson@canonical.com>, Kailang Yang <kailang@realtek.com>, Hui Wang <hui.wang@canonical.com>, alsa-devel <alsa-devel@alsa-project.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On Fri, 2014-01-24 at 15:46 -0500, Adrien Verg=C3=A9 wrote:
> I think very few people use Linux on their MBA 1,1. Moreover, part of
> them remained on v2.6.

I see. Well, if your analysis is correct I think you're supposed to add
     Fixes: 1a97b7f22774 ("ALSA: hda/realtek - Remove the last static q=
uirks for ALC882")

to your commit explanation. Not sure, since this tag is not documented,
as far as I can see.


Paul Bolle
