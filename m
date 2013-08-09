From: Jean-Francois Moine <moinejf@free.fr>
Subject: Re: [PATCH v4 1/1] ASoc: kirkwood: add DT support to the mvebu
 audio subsystem [OT]
Date: Fri, 9 Aug 2013 12:30:20 +0200
Message-ID: <20130809123020.70907621@armhf>
References: <20130808132201.2610aef3@armhf>
	<5204A716.6070507@gmail.com>
	<20130809091953.GO6427@sirena.org.uk>
	<5204B7A6.9050907@gmail.com>
	<20130809094340.GO23006@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20130809094340.GO23006@n2100.arm.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, Rob Herring <rob.herring@calxeda.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

On Fri, 9 Aug 2013 10:43:40 +0100
Russell King - ARM Linux <linux@arm.linux.org.uk> wrote:

> Note that we do have another case not yet in tree, which is DRM, but
> this case is different from that, because ASoC can cope with componen=
ts
> with independent initialisation.

No sure!

Sometimes, with the tda998x in HDMI mode, I get a black screen on my TV
set. And, surprise, when I start the audio (playing something with
vlc), the image appears!

I dumped all (known) registers in the audio and video subsystems
(tda998x, dove lcd, kirkwood audio), and there is no difference between
normal display and black screen. So, some audio event should interact
with the HDMI display.

I don't think that the problem comes from the TV set, because, when
there is a black screen, turning the TV off/on never makes it display
normally again. Rebooting the cubox also lets the black screen.
Only powering off/on the cubox could change the display back to normal.

Now, playing some audio stream gives me immediately a normal display.

Any idea?

--=20
Ken ar c'henta=C3=B1	|	      ** Breizh ha Linux atav! **
Jef		|		http://moinejf.free.fr/
