From: Michael Witten <mfwitten@gmail.com>
Subject: Re: [PATCH][Trivial] Delete trailing whitespace from sound/soc/codecs/wm8994.c
Date: Mon, 9 Apr 2012 20:07:27 +0000
Message-ID: <CAMOZ1BtS_3qxG1ZY5enQRMxKG9rvDbNxvy--D3yQOnPPwsBJhA@mail.gmail.com>
References: <alpine.LNX.2.00.1204090038270.11747@swampdragon.chaosbits.net>
 <alpine.LNX.2.00.1204090201160.24006@pobox.suse.cz> <CAMOZ1BtxNhHxfbYfY+as7jpWHLO2P1QwCW_QpZbmQM+0xf1T=w@mail.gmail.com>
 <alpine.LNX.2.00.1204090228060.24006@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <alpine.LNX.2.00.1204090228060.24006@pobox.suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: Jesper Juhl <jj@chaosbits.net>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Mon, Apr 9, 2012 at 00:29, Jiri Kosina <jkosina@suse.cz> wrote:
> On Mon, 9 Apr 2012, Michael Witten wrote:
>
>> >> While reading through sound/soc/codecs/wm8994.c I noticed a fair
>> >> amount of trailing whitespace. This patch gets rid of it.
>> >>
>> >> Signed-off-by: Jesper Juhl <jj@chaosbits.net>
>> >
>> > Jesper,
>> >
>> > is it really worth it? The code should have been fixed before merg=
ing,
>> > yes, but once it's there, such fixups tend to only make people ang=
ry
>> > (because they have to do unnecessary extra steps during git blame)=
=2E
>>
>> If I may interject, I assume you mean that nobody wants to see the
>> fact that somebody simply changed whitespace. However, the text of
>> `git help blame' suggests that the `-w' flag obviates the issue:
>>
>> =C2=A0 Ignore whitespace when comparing the parent's
>> =C2=A0 version and the child=E2=80=99s to find where the lines
>> =C2=A0 came from.
>>
>> Of course, I've never used it, so I may be mistaken in my
>> interpretation.
>
> That indeed does what it should do, but as it's not git default, then
> quitting git blame and reruning it with '-w' seems to be equally anno=
ying
> to quitting git blame and reruning it with 'particular_commit~1"

It seems to me that something must be terribly wrong with our tools
and workflows whenever an improvement (for which the main work has
already been done, no less) is turned down.

Perhaps that `-w' option should become the default.
