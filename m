From: Thomas Preston <thomas.preston@codethink.co.uk>
Subject: Re: [alsa-devel] [PATCH v2 3/3] ASoC: TDA7802: Add turn-on diagnostic
 routine
Date: Tue, 30 Jul 2019 16:27:32 +0100
Message-ID: <99b80b21-fdb4-085f-3380-7df4700bb0ff@codethink.co.uk>
References: <20190730120937.16271-1-thomas.preston@codethink.co.uk>
 <20190730120937.16271-4-thomas.preston@codethink.co.uk>
 <20190730124158.GH54126@ediswmail.ad.cirrus.com>
 <e7a879d3-36c2-2df8-97c0-3c4bbd2e7ea2@codethink.co.uk>
 <20190730142010.GG4264@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190730142010.GG4264@sirena.org.uk>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, Charles Keepax <ckeepax@opensource.cirrus.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Kirill Marinushkin <kmarinushkin@birdec.tech>, Liam Girdwood <lgirdwood@gmail.com>, Takashi Iwai <tiwai@suse.com>, Marco Felsch <m.felsch@pengutronix.de>, Annaliese McDermond <nh6z@nh6z.net>, linux-kernel@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>, Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Jerome Brunet <jbrunet@baylibre.com>, Cheng-Yi Chiang <cychiang@chromium.org>
List-Id: alsa-devel@alsa-project.org

On 30/07/2019 15:20, Mark Brown wrote:
> On Tue, Jul 30, 2019 at 03:04:19PM +0100, Thomas Preston wrote:
>> On 30/07/2019 13:41, Charles Keepax wrote:
> 
>>> This could probably be removed using regmap_multi_reg_write.
> 
>> The problem is that I want to retain the state of the other bits in those
>> registers. Maybe I should make a copy of the backed up state, set the bits
>> I want to off-device, then either:
> 
>> 1. Write the changes with regmap_multi_reg_write
>> 2. Write all six regs again (if my device doesn't support the multi_reg)
> 
> Or make this a regmap function, there's nothing device specific about
> it.
> 

I did wonder why regmap didn't have an multi-update function. If appropriate,
I will add this in.
