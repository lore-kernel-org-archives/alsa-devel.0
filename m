From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH][Trivial] Delete trailing whitespace from
 sound/soc/codecs/wm8994.c
Date: Mon, 9 Apr 2012 02:29:23 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1204090228060.24006@pobox.suse.cz>
References: <alpine.LNX.2.00.1204090038270.11747@swampdragon.chaosbits.net> <alpine.LNX.2.00.1204090201160.24006@pobox.suse.cz> <CAMOZ1BtxNhHxfbYfY+as7jpWHLO2P1QwCW_QpZbmQM+0xf1T=w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAMOZ1BtxNhHxfbYfY+as7jpWHLO2P1QwCW_QpZbmQM+0xf1T=w@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Michael Witten <mfwitten@gmail.com>
Cc: Jesper Juhl <jj@chaosbits.net>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Mon, 9 Apr 2012, Michael Witten wrote:

> >> While reading through sound/soc/codecs/wm8994.c I noticed a fair
> >> amount of trailing whitespace. This patch gets rid of it.
> >>
> >> Signed-off-by: Jesper Juhl <jj@chaosbits.net>
> >
> > Jesper,
> >
> > is it really worth it? The code should have been fixed before mergi=
ng,
> > yes, but once it's there, such fixups tend to only make people angr=
y
> > (because they have to do unnecessary extra steps during git blame).
>=20
> If I may interject, I assume you mean that nobody wants to see the
> fact that somebody simply changed whitespace. However, the text of
> `git help blame' suggests that the `-w' flag obviates the issue:
>=20
>   Ignore whitespace when comparing the parent's
>   version and the child=E2=80=99s to find where the lines
>   came from.
>=20
> Of course, I've never used it, so I may be mistaken in my=20
> interpretation.

That indeed does what it should do, but as it's not git default, then=20
quitting git blame and reruning it with '-w' seems to be equally annoyi=
ng=20
to quitting git blame and reruning it with 'particular_commit~1"

--=20
Jiri Kosina
SUSE Labs
