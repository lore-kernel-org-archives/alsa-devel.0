From: Matt Flax <flatmax@flatmax.org>
Subject: Re: [PATCH 0/3] ASoC: Enable a new IC master mode:
 bcm2835<=>IC<=>cs42xx8
Date: Sat, 25 Mar 2017 16:45:46 +1100
Message-ID: <3c818d92-498e-868c-696b-a9b709af5415@flatmax.org>
References: <20170228095929.GH2742@localhost.localdomain>
 <20170315190108.y6ybxm3nfgnutajv@sirena.org.uk>
 <7d8d38f7-53aa-cc3d-4bbd-141649528a8a@flatmax.org>
 <8c62f014-d246-e0c1-2b02-a28a2c2786b7@metafoo.de>
 <000fbaa4-4c7c-5b13-0806-7e42672a4a55@flatmax.org>
 <e0adcc6c-8bf4-adae-874b-c291e71e5712@laposte.net>
 <20170321221145.GA7258@camel2.lan>
 <579f0763-a5bd-f820-b36f-b6437e331b4b@flatmax.org>
 <20170322094301.GE6986@localhost.localdomain>
 <64802e9b-ffe9-65e3-502a-4253674fb4c7@flatmax.org>
 <20170324190955.nxw5az4mza2ia6wl@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nsstlmta19p.bpe.bigpond.com (nsstlmta19p.bpe.bigpond.com
 [203.38.21.19]) by alsa0.perex.cz (Postfix) with ESMTP id 3130F266927
 for <alsa-devel@alsa-project.org>; Sat, 25 Mar 2017 06:45:55 +0100 (CET)
In-Reply-To: <20170324190955.nxw5az4mza2ia6wl@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: =?UTF-8?Q?Emmanuel_Fust=c3=a9?= <emmanuel.fuste@laposte.net>, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Stephen Warren <swarren@wwwdotorg.org>, Eric Anholt <eric@anholt.net>, Lee Jones <lee@kernel.org>, phil@raspberrypi.org, Liam Girdwood <lgirdwood@gmail.com>, Matthias Reichl <hias@horus.com>, florian.kauer@koalo.de, Florian Meier <florian.meier@koalo.de>, linux-rpi-kernel@lists.infradead.org, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org



On 25/03/17 06:09, Mark Brown wrote:
> On Wed, Mar 22, 2017 at 11:04:34PM +1100, Matt Flax wrote:
>> On 22/03/17 20:43, Charles Keepax wrote:
>>> Are we saying that what gets transmitted on the bus is neither valid
>>> I2S or DSP mode data? But as you have your custom hardware block in
>>> the middle it interprets this data correctly and converts it to a
>>> regular bus format on the other side that goes to the CODEC?
>> Yes, essentially there is translation between the two data word edge
>> triggered ABP (the bcm2835's PCM block) and a Cirrus Logic TDM codec.
> Could you please be concrete about what the two formats you're talking
> about here are and how these differences are observable on the wire?  I
> don't know what "two data word edge triggered ABP" means.
On the codec side it is a regular TDM stream.
On the SoC side, two channels  are arbitrarily offset from a PCM frame 
sync clock (PCM_FS) leading edge. I have chosen to have 64 bits per 
frame with 1 bit offset for the first word (from the leading edge) and 
33 bits offset (from the leading edge) for the second word. This 
resembles I2S, but it doesn't have to for the bcm2835.

In more detail ...
The bcm2835's flexible PCM hardware (serialiser+APB) is set up to handle 
two words at a time in/out from a 64 word FIFO buffers. The serialiser 
loads and unloads two registers according to offsets from the PCM_FS 
clock's leading edge. The APB interface is responsible for (un)loading 
the 64 word FIFO buffer to/from memory - with DMA I guess.

thanks
Matt
