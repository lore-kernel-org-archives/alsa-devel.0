From: =?UTF-8?B?w4lyaWMgUGllbA==?= <eric.piel@tremplin-utc.net>
Subject: Re: [REGRESSION bisected] Sound goes too fast due to commit 7b3a177b0
Date: Wed, 14 Apr 2010 13:22:14 +0200
Message-ID: <4BC5A566.8060106@tremplin-utc.net>
References: <4BC4E812.6050602@tremplin-utc.net> <s5h633u5zx1.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <s5h633u5zx1.wl%tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Jaroslav Kysela <perex@perex.cz>, "Rafael J. Wysocki" <rjw@sisk.pl>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 14/04/10 08:08, Takashi Iwai wrote:
> At Tue, 13 Apr 2010 23:54:26 +0200,
> =C3=89ric Piel wrote:
>>
>> Hello,
>>
>> Since 2.6.34-rc*, I have a regression on alsa which prevents the sou=
nd
>> to be played correctly. When playing, the music goes too fast, skipp=
ing
>> some parts. Typically, it's very easy to reproduce by doing:
>> time mplayer -endpos 30 sound-file-which-lasts-more-than-thirty-sec.=
mp3
>>
>> If the wall clock is less than 30s, you have the bug. With my intel-=
hda
>> (AD1981), it's reliably reproducible: it gives ~27s, instead of the
>> normal ~31s.
>>
>> After bisection, it turns out that it is commit
>> 7b3a177b0d4f92b3431b8dca777313a07533a710, aka "ALSA: pcm_lib: fix
>> "something must be really wrong" condition" which caused this
>> regression. Reverting it on top of 2.6.34-rc3+ fixes the problem.
>=20
> What happens if you pass position_fix=3D1 option to snd-hda-intel?
Oh! Very good remark...
I've just noticed that I had an option already on the module:
bdl_pos_adj=3D0. It seems it's not needed anymore to get my card workin=
g
fine. If I remove every option (leaving bdl_pos_adj to the default valu=
e
1), it works fine. If I put bdl_pos_adj=3D0 and position_fix=3D1, it wo=
rks
fine again.

I don't fully grasp the meaning of bdl_pos_adj, so I don't know if it's
a bug to not play correctly when forcing it to 0. Is it?

I'll ask to another reporter who had the same problem if bdl_pos_adj is
also set to 0...

> Is it via PulseAudio or other backend?
This happens both with pulseaudio, oss and alsa (in which case it plays
the 30s clip in 12s).

Eric
