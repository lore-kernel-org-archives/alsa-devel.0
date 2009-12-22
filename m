From: =?UTF-8?B?w4lyaWMgUGllbA==?= <eric.piel@tremplin-utc.net>
Subject: Re: [2.6.33-rc1] [SOUND] HDA: high cpu usage, noise
Date: Tue, 22 Dec 2009 10:15:20 +0100
Message-ID: <4B308E28.1090609@tremplin-utc.net>
References: <8db1092f0912200927y7cdab36ftd1f73d56cd89763f@mail.gmail.com>	<s5hmy1cpqo4.wl%tiwai@suse.de>	<8db1092f0912211012mcdd6639oaaf0bddc118e7d66@mail.gmail.com>	<4B2FC7B2.7000001@tremplin-utc.net> <s5hk4wf1obu.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751626AbZLVJP1@vger.kernel.org>
In-Reply-To: <s5hk4wf1obu.wl%tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Maciej Rutecki <maciej.rutecki@gmail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, alsa-devel@alsa-project.org, perex@perex.cz, "Rafael J. Wysocki" <rjw@sisk.pl>
List-Id: alsa-devel@alsa-project.org

Op 22-12-09 08:04, Takashi Iwai schreef:
> At Mon, 21 Dec 2009 20:08:34 +0100,
> =C3=89ric Piel wrote:
:
>> Could it be coming from this timeout?
>=20
> It shouldn't.  The polling mode doesn't give any behavioral change,
> and the CPU usage can't be that high.
>=20
> Try is to pass bdl_pos_adj=3D0 option.  This should reduce the CPU ho=
g,
> at least.  But it doesn't mean it's the right fix...
I'll try

>=20
> Another thing to try is to replace the whole HD-audio stack with the
> last working one (was it 2.6.32?), and check whether it works with
> 2.6.32 core.
Could you give more details on how to do this?
Does it consist in taking the sound/ directory of 2.6.32 and copying it
over 2.6.33-rc1 ? Or less files?

Eric
