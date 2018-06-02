From: Robert Jarzmik <robert.jarzmik@free.fr>
Subject: Re: [PATCH v8] ASoC: pxa: switch to new ac97 bus support
Date: Sun, 03 Jun 2018 00:27:58 +0200
Message-ID: <87fu24su1d.fsf@belgarion.home>
References: <20180602192930.17846-1-robert.jarzmik@free.fr>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180602192930.17846-1-robert.jarzmik@free.fr> (Robert Jarzmik's
        message of "Sat, 2 Jun 2018 21:29:30 +0200")
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Takashi Iwai <tiwai@suse.com>, Jaroslav Kysela <perex@perex.cz>, Daniel Mack <daniel@zonque.org>, Haojian Zhuang <haojian.zhuang@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

Robert Jarzmik <robert.jarzmik@free.fr> writes:

> Switch to the new ac97 bus support in sound/ac97 instead of the legacy
> snd_ac97 one.
> +	codecs_pdata = pdata ? pdata->codecs_pdata : NULL;

It's a shame my automated build and test system didn't catch that : it should
have been pdata->codec_pdata and not pdata->codecs_pdata.

Given that this slipped in, please don't apply this until I find out why my
builder lives in utopia.

Cheers.

--
Robert
