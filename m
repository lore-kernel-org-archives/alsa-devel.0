From: Peter Rosin <peda@axentia.se>
Subject: Re: [RFC PATCH] ASoC: pcm512x: Implement the
	set_bclk_ratio interface
Date: Tue, 15 Jan 2019 12:11:23 +0000
Message-ID: <2d11c9f2-5938-c6d8-1933-2f5cf86e3838@axentia.se>
References: <900a4f74-9312-58d8-a5b3-035305fe184e@gmail.com>
 <4b8ce92c-9239-3a8a-f061-eb114050bd3a@axentia.se>
 <CAHEwa0BmUedqYR0Q0RtHtsHCqHCggtK75uY3hDcDzqAM8Qu4ZQ@mail.gmail.com>
 <9b479bdb-2c29-86ad-1ea4-9f76b9b47f7b@axentia.se>
 <CAHEwa0BhKp2hqgBR+ZrCmZ92LCxhsWd-8Pjc1pQ7HJ4==jz6WA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from EUR01-VE1-obe.outbound.protection.outlook.com
 (mail-eopbgr140129.outbound.protection.outlook.com [40.107.14.129])
 by alsa0.perex.cz (Postfix) with ESMTP id 3E5E526743C
 for <alsa-devel@alsa-project.org>; Tue, 15 Jan 2019 13:11:25 +0100 (CET)
In-Reply-To: <CAHEwa0BhKp2hqgBR+ZrCmZ92LCxhsWd-8Pjc1pQ7HJ4==jz6WA@mail.gmail.com>
Content-Language: en-US
Content-ID: <1CF05C05B0AF00479066637E9C0A619E@eurprd02.prod.outlook.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Dimitris Papavasiliou <dpapavas@gmail.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

On 2019-01-15 12:11, Dimitris Papavasiliou wrote:
> On Tue, Jan 15, 2019 at 10:06 AM Peter Rosin <peda@axentia.se> wrote:
>> ...and when double-checking that, this dai op is only ever called from
>> snd_soc_dai_set_bclk_ratio, and that function is in turn not called from
>> anywhere AFAICT. What's the point of this dai op anyway? Or, what am I
>> missing?
> 
> Well, my use for this, would be to allow the machine driver to call
> snd_soc_dai_set_bclk_ratio, in order to explicitly set the frame
> width.  This would allow it to use 32-bit frames for 24-bit data and
> avoid the fractional dividers that would otherwise result.  Right now,
> the machine driver (which lives in the Raspberry Pi kernel tree) uses
> a workaround for this, that relies on a patch made to the CODEC driver
> to half-support TDM slots, which hasn't be pushed upstream, and
> wouldn't be accepted if it had, since it's essentially a hack.  You
> can find more details here:
> 
> http://mailman.alsa-project.org/pipermail/alsa-devel/2018-December/143507.html
> 
> What the intended use for the snd_soc_dai_set_bclk_ratio is, I'm not
> so clear about, hence this RFC.

I did some digging. The dai op was added in 3.13 (without users), then one
user appeared in 3.19 (sound/soc/intel/boards/bytcr_rt5640.c) and another
(presumably copy-pasted) in 4.5 (sound/soc/intel/boards/bytcr_rt5651.c).
Both these users are suspect since neither the rt5640 nor the rt5651 codec
have ever sported a set_bclk_ratio dai op, and presumably the boards have
the named codecs on them. But what do I know...

The user added in 3.19 was removed for 4.9 and the other for 4.17, so
that's why there are no upstream users at the moment.

Cheers,
Peter
