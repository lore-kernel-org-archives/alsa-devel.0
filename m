From: Michael Witten <mfwitten@gmail.com>
Subject: Re: [PATCH][Trivial] Delete trailing whitespace from sound/soc/codecs/wm8994.c
Date: Mon, 9 Apr 2012 00:24:40 +0000
Message-ID: <CAMOZ1BtxNhHxfbYfY+as7jpWHLO2P1QwCW_QpZbmQM+0xf1T=w@mail.gmail.com>
References: <alpine.LNX.2.00.1204090038270.11747@swampdragon.chaosbits.net> <alpine.LNX.2.00.1204090201160.24006@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <alpine.LNX.2.00.1204090201160.24006@pobox.suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: Jesper Juhl <jj@chaosbits.net>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Mon, Apr 9, 2012 at 00:02, Jiri Kosina <jkosina@suse.cz> wrote:
> On Mon, 9 Apr 2012, Jesper Juhl wrote:
>
>> While reading through sound/soc/codecs/wm8994.c I noticed a fair
>> amount of trailing whitespace. This patch gets rid of it.
>>
>> Signed-off-by: Jesper Juhl <jj@chaosbits.net>
>
> Jesper,
>
> is it really worth it? The code should have been fixed before merging=
,
> yes, but once it's there, such fixups tend to only make people angry
> (because they have to do unnecessary extra steps during git blame).

If I may interject, I assume you mean that nobody wants to see the
fact that somebody simply changed whitespace. However, the text of
`git help blame' suggests that the `-w' flag obviates the issue:

  Ignore whitespace when comparing the parent's
  version and the child=E2=80=99s to find where the lines
  came from.

Of course, I've never used it, so I may be mistaken in my interpretatio=
n.

Sincerely,
Michael Witten
