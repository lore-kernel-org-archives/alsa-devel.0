From: Matt Flax <flatmax@flatmax.org>
Subject: Re: [PATCH v1] ASoC: bcm2835: Remove redundant channel
 checking code in hw_params
Date: Wed, 1 Feb 2017 22:05:18 +1100
Message-ID: <d91986b0-4deb-6d2a-6000-34b4072baed2@flatmax.org>
References: <1484443043-13623-1-git-send-email-flatmax@flatmax.org>
 <1485924303-30869-1-git-send-email-flatmax@flatmax.org>
 <20170201105329.vr4ro5bjf676dwtk@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nsstlmta07p.bpe.bigpond.com (nsstlmta07p.bpe.bigpond.com
 [203.38.21.7]) by alsa0.perex.cz (Postfix) with ESMTP id B7829266957
 for <alsa-devel@alsa-project.org>; Wed,  1 Feb 2017 12:05:27 +0100 (CET)
In-Reply-To: <20170201105329.vr4ro5bjf676dwtk@sirena.org.uk>
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
Cc: alsa-devel@alsa-project.org, Stephen Warren <swarren@wwwdotorg.org>, Lee Jones <lee@kernel.org>, phil@raspberrypi.org, Eric Anholt <eric@anholt.net>, Florian Meier <florian.meier@koalo.de>, linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org



On 01/02/17 21:53, Mark Brown wrote:
> On Wed, Feb 01, 2017 at 03:45:03PM +1100, Matt Flax wrote:
>
>> This redundant channel count check may seem like it will not cause
>> any problems however some sound cards (such as the 8 channel
>> AudioInjector Octo sound card) require the execution of the
>> bcm2835_i2s_hw_params function when channels_max in the
>> bcm2835_i2s_dai structure has been increased to 8.
>> As the channel checking code in bcm2835_i2s_hw_params is redundant
>> and stops certain cards from working it has been removed.
> If those cards add support for higher channel counts they should be
> adding real support for that in the driver, not just hacking out
> defensive code.  If the device can usefully do 8 channels then modify
> the driver to do 8 channels.  Otherwise people are going to need to
> modify the driver anyway to remove the limits in the constraints.
>
Indeed the AudioInjector Octo sound card is currently operating @ 8 
channels out on the bcm2835 silicon. It has been tested on both the Pi 2 
and Pi 3.

Do you mean that I should increase bcm2835_i2s_dai.channels_max to 8 ?

I can do this. Does anyone have any objections to this approach ?

thanks

Matt

>
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
