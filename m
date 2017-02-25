From: Matt Flax <flatmax@flatmax.org>
Subject: Re: [PATCH 0/3] ASoC: Enable a new IC master mode:
 bcm2835<=>IC<=>cs42xx8
Date: Sun, 26 Feb 2017 09:13:09 +1100
Message-ID: <8cf68a3e-330d-e76d-e276-5df5453e3baf@flatmax.org>
References: <cover.1487997974.git.flatmax@flatmax.org>
 <20170225133952.GA28091@camel2.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nschwmtas04p.mx.bigpond.com (nschwmtas04p.mx.bigpond.com
 [61.9.189.146]) by alsa0.perex.cz (Postfix) with ESMTP id ABEF4266B0F
 for <alsa-devel@alsa-project.org>; Sat, 25 Feb 2017 23:13:17 +0100 (CET)
In-Reply-To: <20170225133952.GA28091@camel2.lan>
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
Cc: linux-arm-kernel@lists.infradead.org, alsa-devel@alsa-project.org, Stephen Warren <swarren@wwwdotorg.org>, Lee Jones <lee@kernel.org>, phil@raspberrypi.org, Liam Girdwood <lgirdwood@gmail.com>, Eric Anholt <eric@anholt.net>, broonie@kernel.org, Florian Meier <florian.meier@koalo.de>, linux-rpi-kernel@lists.infradead.org, ckeepax@opensource.wolfsonmicro.com, florian.kauer@koalo.de
List-Id: alsa-devel@alsa-project.org


On 26/02/17 00:39, Matthias Reichl wrote:
> On Sat, Feb 25, 2017 at 04:03:11PM +1100, Matt Flax wrote:
>> This patch set lets the ASoC system specify that an IC between the SoC and codec
>> is master. This is intended to put both the SoC and Codec into slave modes.
>>
>> By default un-patched SoC and Codec drivers will return -EINVAL if they aren't
>> enabled and tested for this mode.
>>
>> soc-dia.h has the new SND_SOC_DAIFMT_IBM_IFM definition set as :
>> #define SND_SOC_DAIFMT_IBM_IFM		(5 << 12) /* IC clk & FRM master */
>>
>> The cs42xx8 codec driver is enabled for this mode and so too is the BCM2835
>> SoC driver. This forms a chain : bcm2835<=>IC<=>cs42xx8
>> where the IC is bit and frame master.
> Model your IC as a codec. No need to add patches to random drivers
> and add a flag with the rather meaningless semantics "someone else is
> automagically setting up clocks for me".
>
>

My last patch, used the two codec approach, however it was pointed out 
that the
bcm2835 was run in DSP mode with a codec master (rather then IC master) 
and that
the patch doesn't work. Which is clearly true and a problem, it can only 
work with an
intermediate non-codec master.

I think you summed it up well with your statement :

On 25/02/17 Matthias Reichl wrote:
If the clock timing adheres to DSP mode A timing and you add code
to the the CPU DAI driver so it can operate in DSP mode A then
that should also work. If not, it's broken.


This patch set fixes the problem of a daisy chain of three possible masters
(CPU <=> IC <=> codec) where only the IC can be master. In fact, when retro
fitting DSP mode to old silicon, the CPU can specify which of the three 
can be masters
and there is no chance that someone can fire the system up with the 
wrong master
(which we know produces bit offset and random channel swapping when a 
codec is
master).

thanks
Matt
