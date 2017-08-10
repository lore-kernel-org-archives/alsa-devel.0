From: Bhumika Goyal <bhumirks@gmail.com>
Subject: Re: [PATCH 1/2] ASoC: codecs: add const to snd_soc_codec_driver structures
Date: Thu, 10 Aug 2017 20:56:35 +0530
Message-ID: <CAOH+1jGe_Xo3o024H4xq8cJV10xta76QmovPKreXpncU86hqFA@mail.gmail.com>
References: <1501776020-3328-1-git-send-email-bhumirks@gmail.com>
 <1501776020-3328-2-git-send-email-bhumirks@gmail.com> <20170810152010.hl2ea5tuyo7mhndf@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170810152010.hl2ea5tuyo7mhndf@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Julia Lawall <julia.lawall@lip6.fr>, Liam Girdwood <lgirdwood@gmail.com>, perex@perex.cz, tiwai@suse.com, maxime.ripard@free-electrons.com, Chen-Yu Tsai <wens@csie.org>, alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>, brian.austin@cirrus.com, Paul.Handrigan@cirrus.com, support.opensource@diasemi.com, Muthumula Jaya <mr.swami.reddy@ti.com>, vishwas.a.deshpande@ti.com, peda@axentia.se, bardliao@realtek.com, baohua@kernel.org, peter.ujfalusi@ti.com, patches@opensource.cirrus.com
List-Id: alsa-devel@alsa-project.org

On Thu, Aug 10, 2017 at 8:50 PM, Mark Brown <broonie@kernel.org> wrote:
> On Thu, Aug 03, 2017 at 09:30:19PM +0530, Bhumika Goyal wrote:
>
>>  sound/soc/codecs/88pm860x-codec.c      | 2 +-
>>  sound/soc/codecs/ab8500-codec.c        | 2 +-
>>  sound/soc/codecs/ac97.c                | 2 +-
>>  sound/soc/codecs/ad1836.c              | 2 +-
>>  sound/soc/codecs/ad193x.c              | 2 +-
>>  sound/soc/codecs/ad1980.c              | 2 +-
>>  sound/soc/codecs/ad73311.c             | 2 +-
>>  sound/soc/codecs/adau1373.c            | 2 +-
>>  sound/soc/codecs/adau1701.c            | 2 +-
>
> This is difficult to apply against current code as it is a single commit
> over lots of files but the ASoC tree has lots of branches.  I've figured
> out the dependencies but it's easier to split things up (and avoids
> collisions with other changes causing the whole thing to not apply).

Thanks for the response.
Should I make separate patches for each file or is there another way
to split this patch?

Thanks,
Bhumika
