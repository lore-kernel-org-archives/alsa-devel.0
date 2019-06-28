From: Connor McAdams <conmanx360@gmail.com>
Subject: Re: [alsa-devel] ca0132 audio in Ubuntu 19.04 only after Windows 10
 started, missing ctefx-r3di.bin
Date: Fri, 28 Jun 2019 12:42:52 -0400
Message-ID: <CAM8Agx0Mx+B3VeANVkO+3EZAuRPZ8z-GB0npeJwWPvQ54YaMxg@mail.gmail.com>
References: <156097935391.32250.14918304155094222078.malonedeb@chaenomeles.canonical.com>
 <156113479576.29306.8491703251507627705.malone@gac.canonical.com>
 <B0FDD5B2-EA6F-4ABC-8BF5-6231AA31EB70@canonical.com> <s5hh88a6pig.wl-tiwai@suse.de>
 <4E6239D9-3A70-4D66-9F88-453EB268DA2A@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4E6239D9-3A70-4D66-9F88-453EB268DA2A@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc: Takashi Iwai <tiwai@suse.de>, ALSA development <alsa-devel@alsa-project.org>, linux-kernel <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

Hm... not sure the firmware will fix this issue, as it falls back to
the default ctefx.bin firmware which should work fine. But it's worth
a shot.

His card looks like it's being identified properly, and I've had
reports from others with the same motherboard codecs not having
issues.

There's not too much that I can really troubleshoot with these cards,
as I lack the documentation. All that I know is from capturing the HDA
verbs from a Windows virtual machine with PCI passthrough.

The only thing I can really think of is GPIO potentially, but that
would be re-set when the Linux driver is booted up. I know some users
have to do a full on shutdown to clear the cards internal memory for
it to work in Linux, but it sounds like he may have already done that.

I'll look into this a little bit when I get some time, but the issue
is that I don't have too many options/ideas on what could be
potentially wrong.

On Fri, Jun 28, 2019 at 5:29 AM Kai-Heng Feng
<kai.heng.feng@canonical.com> wrote:
>
> at 17:13, Takashi Iwai <tiwai@suse.de> wrote:
>
> > On Fri, 28 Jun 2019 08:35:51 +0200,
> > Kai-Heng Feng wrote:
> >> Hi Connor,
> >>
> >> The bug was filed at Launchpad [1], I think the most notable error is
> >> [    3.768667] snd_hda_intel 0000:00:1f.3: Direct firmware load for
> >> ctefx-r3di.bin failed with error -2
> >>
> >> The firmware is indeed listed in patch_ca0132.c, but looks like
> >> there=E2=80=99s no  corresponding file in linux-firmware.
> >
> > FYI, the firmware is found in alsa-firmware git repo for now.
>
> Got it, thanks for the info. Didn=E2=80=99t know there=E2=80=99s alsa-fir=
mware repo.
>
> Kai-Heng
>
> >
> >
> > Takashi
>
>
