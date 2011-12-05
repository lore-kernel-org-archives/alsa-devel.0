From: Tomoya MORINAGA <tomoya.rohm@gmail.com>
Subject: Re: [PATCH v2] soc/lapis: add machine driver
Date: Mon, 5 Dec 2011 14:28:29 +0900
Message-ID: <CANKRQngGHLD0Bam6sxCGPSkGutjkagbJMvGPTgkduXR6xmMw_Q@mail.gmail.com>
References: <1322819115-15808-1-git-send-email-tomoya.rohm@gmail.com>
	<20111202153401.GX8245@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20111202153401.GX8245@opensource.wolfsonmicro.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Liam Girdwood <lrg@ti.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, Lars-Peter Clausen <lars@metafoo.de>, Dimitris Papastamos <dp@opensource.wolfsonmicro.com>, Mike Frysinger <vapier@gentoo.org>, Daniel Mack <zonque@gmail.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, qi.wang@intel.com, yong.y.wang@intel.com, joel.clark@intel.com, kok.howg.ewe@intel.com
List-Id: alsa-devel@alsa-project.org

Hi Mark,

=46irst of all, let me confirm my understanding for machine driver.
According to "machine.txt", I created this machine driver referring
corgi.c/spitz.c.
However, corgi.c/spitz.c. don't look obeying your saying.

e.g.
2011/12/3 Mark Brown <broonie@opensource.wolfsonmicro.com>:
>> + =A0 =A0 snd_soc_dapm_add_routes(dapm, ml7213_routes, ARRAY_SIZE(ml=
7213_routes));
>
> Use table based init for these.
>
I  couldn't see any table based init processing at corgi.c/spitz.c.

>
>> + =A0 =A0 switch (params_rate(params)) {
>> + =A0 =A0 case 16000:
>> + =A0 =A0 case 32000:
>> + =A0 =A0 case 48000:
>> + =A0 =A0 =A0 =A0 =A0 =A0 clk =3D 12288800;
>> + =A0 =A0 =A0 =A0 =A0 =A0 break;
>
> You may as well just set the CODEC clock rate once on init() and let =
the
> CODEC driver worry about what it can do with the clock it's got, if t=
he
> values aren't going to change there's no need to set them every time.
>

corgi.c/spitz.c look coded like above.

So, I'm confused.
Is this procedure true ?


Thanks,

tomoya
