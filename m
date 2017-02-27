From: Matt Flax <flatmax@flatmax.org>
Subject: Re: [PATCH 0/3] ASoC: Enable a new IC master mode:
 bcm2835<=>IC<=>cs42xx8
Date: Mon, 27 Feb 2017 21:08:14 +1100
Message-ID: <170950f7-354f-e6a9-cefb-834a00fadd1b@flatmax.org>
References: <cover.1487997974.git.flatmax@flatmax.org>
 <20170225133952.GA28091@camel2.lan>
 <8cf68a3e-330d-e76d-e276-5df5453e3baf@flatmax.org>
 <20170226144958.GA5543@camel2.lan>
 <732a71ac-5ec5-37e1-1190-be036ea34555@flatmax.org>
 <20170226221648.GA10974@camel2.lan>
 <7cef41ee-ef00-22b7-830f-517a9d594ed0@flatmax.org>
 <20170227080433.GA2718@delle.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nsstlmta28p.bpe.bigpond.com (nsstlmta28p.bpe.bigpond.com
 [203.38.21.28]) by alsa0.perex.cz (Postfix) with ESMTP id 2A7F32667A9
 for <alsa-devel@alsa-project.org>; Mon, 27 Feb 2017 11:08:24 +0100 (CET)
In-Reply-To: <20170227080433.GA2718@delle.lan>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Matthias Reichl <hias@horus.com>
Cc: alsa-devel@alsa-project.org, Stephen Warren <swarren@wwwdotorg.org>, Lee Jones <lee@kernel.org>, phil@raspberrypi.org, Liam Girdwood <lgirdwood@gmail.com>, Eric Anholt <eric@anholt.net>, florian.kauer@koalo.de, broonie@kernel.org, Florian Meier <florian.meier@koalo.de>, linux-rpi-kernel@lists.infradead.org, ckeepax@opensource.wolfsonmicro.com, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org



On 27/02/17 19:04, Matthias Reichl wrote:
> On Mon, Feb 27, 2017 at 09:35:14AM +1100, Matt Flax wrote:
>>
>> On 27/02/17 09:16, Matthias Reichl wrote:
>>>
>>> Have a look at the end of Documentation/sound/alsa/soc/DPCM.txt
>>> where codec<->codec links are explained.
>>>
>>> You can setup the stream parameters for the "IC"<->"real codec" link
>>> with snd_soc_dai_link.params.
>>>
>>> You can do that for example in your machine driver in hwparams:
>>> when hw_params is called eg with 2 channels 192kHz just set the
>>> dai link parameters of the codec to 8 channels 48kHz.
>>>
>>> Maybe using dynamic pcm (which offers a be_hw_params_fixup hook)
>>> is the more appropriate way to do that, but I can't tell for sure
>>> as I never used it and am not familiar with it.
>>>
>>>
>> Thanks for this information, I will give this a go - seems a better way now
>> then introducing an IC master into the mix !
>>
>> Do you agree that we still need the BCM2835 SoC CPU driver to be expanded to
>> handle DSP mode
>> and multichannel setups ? I can't see any other way to enable the
>> multichannel hardware setup without altering bcm2835_i2s.c to handle DSP
>> mode and more then 2 channels in its _hw_params.
> No, DSP mode and multichannel don't work on the BCM2835. Keep the driver
> as it is.
>
> Use the alsa plugin approach to tunnel multichannel data over a 2-channel
> PCM and you don't need to modify existing drivers.
>

Thanks again for this suggestion. I have been playing around with user 
space plugins lately, they are great. I plan to release some C++ classes 
to help trivialise the creation of such plugins.

However for a product, a piece of robustly functioning hardware, I am 
inclined to take the route of introducing a DSP mode into the 
bcm2835_i2s.c driver.

 From the previous patches, it is clear that people are willing to allow 
multichannel (DSP mode) into the bcm2835 CPU driver. It improves the 
usefulness of hardware which use the BCM2835 derived chipset. From my 
point of view that is a major simplification in terms of releasing 
functioning multichannel hardware. I would imagine from the 
manufacturer's point of view that is a big bonus too !

Again I intend to implement your concept of the snd_soc_dai_link for my 
machine driver, that is a fantasic lead you have given me ... when I 
have questions @ implementation time I will copy you in seeking for more 
guidance.

thanks again,
Matt
