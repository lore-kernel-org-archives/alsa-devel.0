From: =?UTF-8?B?w4lyaWMgUGllbA==?= <eric.piel@tremplin-utc.net>
Subject: Re: [REGRESSION bisected] Sound goes too fast due to commit 7b3a177b0
Date: Wed, 14 Apr 2010 13:54:48 +0200
Message-ID: <4BC5AD08.8040606@tremplin-utc.net>
References: <4BC4E812.6050602@tremplin-utc.net> <s5h633u5zx1.wl%tiwai@suse.de> <4BC5A566.8060106@tremplin-utc.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4BC5A566.8060106@tremplin-utc.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Jaroslav Kysela <perex@perex.cz>, "Rafael J. Wysocki" <rjw@sisk.pl>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, alsa-devel@alsa-project.org, Frank Griffin <ftg@roadrunner.com>
List-Id: alsa-devel@alsa-project.org

On 14/04/10 13:22, =C3=89ric Piel wrote:
:
> I don't fully grasp the meaning of bdl_pos_adj, so I don't know if it=
's
> a bug to not play correctly when forcing it to 0. Is it?
>=20
> I'll ask to another reporter who had the same problem if bdl_pos_adj =
is
> also set to 0...
=46rank (cc'd here) has the same problem of music going too fast (on a
2.6.33 kernel with the "culprit" commit applied). On his system  "cat
/sys/module/snd_hda_intel/parameters/bdl_pos_adj" gives:
32,32,-1,-1,-1,-1,-1,-1

He also mentioned that on another system also using snd_hda_intel, with
the same bdl_pos_adj, it works fine.

Eric
