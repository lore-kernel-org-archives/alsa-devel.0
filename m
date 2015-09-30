From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH] ASoC: Document DAI signal polarity
Date: Wed, 30 Sep 2015 21:34:46 +0200
Message-ID: <560C3956.9000302@metafoo.de>
References: <1441054258-33200-1-git-send-email-anatol.pomozov@gmail.com>	<20150918135427.GI12027@sirena.org.uk>	<CAOMFOmW3RCcrGn6o0xsQWREz5gqVT_ucjO5uDAf=zexZrxWEdA@mail.gmail.com>	<20150930181004.GN15635@sirena.org.uk>
 <CAOMFOmXX67Uktd4cVJ==1w-nfHzFF_HaKwVb+sqLMp4WPt0Knw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-050.synserver.de (smtp-out-107.synserver.de
 [212.40.185.107])
 by alsa0.perex.cz (Postfix) with ESMTP id 1199C2665EE
 for <alsa-devel@alsa-project.org>; Wed, 30 Sep 2015 21:34:49 +0200 (CEST)
In-Reply-To: <CAOMFOmXX67Uktd4cVJ==1w-nfHzFF_HaKwVb+sqLMp4WPt0Knw@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Anatol Pomozov <anatol.pomozov@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: liam.r.girdwood@linux.intel.com, =?UTF-8?B?6Zmz56uL5bOw?= <albertchen@realtek.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On 09/30/2015 09:08 PM, Anatol Pomozov wrote:
>  - for I2S/left/right justified - frame starts with falling FSYNC edge

This is what most drivers implement:

I2S: Left channel starts with the falling edge, right channel starts with
the rising edge (data is delayed by one clock cycle)

Right/Left justified: Left channel starts with the rising edge, right
channel starts with the falling edge

DSP A/B: Frame starts with the rising edge. Channels are spaced by the
configured slot width (e.g. first channel at offset 0, second channel at
offset 16, third channel at offset 32, ...). If the slot with has not been
configured explicitly using the set_tdm_slots() API the slot with is the
number of bits in one single-channel sample (Return value of params_width()).

When using I2S or left/right justified in TDM mode channels are also spaced
by the configured slot width and the second edge should be ignored.
