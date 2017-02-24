From: Matt Flax <flatmax@flatmax.org>
Subject: Re: [PATCH v8] ASoC: bcm2835: Add 8 channel
 (multitrack) capability
Date: Sat, 25 Feb 2017 08:30:03 +1100
Message-ID: <501e4af5-51b7-c124-4a29-ef5804d8a03c@flatmax.org>
References: <1486422576-6958-1-git-send-email-flatmax@flatmax.org>
 <1487746600-11065-1-git-send-email-flatmax@flatmax.org>
 <20170224121832.GA19227@camel2.lan>
 <3b693ff9-b3a6-1c10-5b1a-78be04006113@flatmax.org>
 <20170224202553.GA28529@camel2.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nsstlmta37p.bpe.bigpond.com (nsstlmta37p.bpe.bigpond.com
 [203.38.21.37]) by alsa0.perex.cz (Postfix) with ESMTP id 5C3D22668C0
 for <alsa-devel@alsa-project.org>; Fri, 24 Feb 2017 22:30:12 +0100 (CET)
In-Reply-To: <20170224202553.GA28529@camel2.lan>
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
Cc: alsa-devel@alsa-project.org, Stephen Warren <swarren@wwwdotorg.org>, Lee Jones <lee@kernel.org>, Phil Elwell <phil@raspberrypi.org>, Eric Anholt <eric@anholt.net>, Mark Brown <broonie@kernel.org>, Florian Meier <florian.meier@koalo.de>, linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org



On 25/02/17 07:25, Matthias Reichl wrote:

> I'd put it in another way: it seems to me that the bcm2835 I2S
> won't reliably sync in DSP mode A.
>
>

What you are explaining here is the nature of the BCM2835 responding to 
a codec master. The hardware setup you are describing is elegantly 
simple, but TOO simple.

Measurements on a system which uses a codec master don't represent a 
robust implementation of multichannel with the BCM2835. My experiments 
(and now yours) have shown that the system has a bit shift and an 
uncontrollable channel drift.

Multichannel simply can't be done (on the BCM2835) without control at 
the hardware level - this requires an intermediate master control chip.

The Audio Injector Octo machine driver, sets both the codec and the 
BCM2835 as slaves - the FPGA is master because it has to control both 
the BCM2835 and the codec's systems to get reliability. You can see the 
machine driver on github :
https://github.com/flatmax/linux/blob/rpi-4.4.y/sound/soc/bcm/audioinjector-octo-soundcard.c

It has taken month to implement a robust solution to this problem using 
an FPGA and the result is a fantastic (Audio Injector Octo) sound card. 
I am almost certain this hardware technique can be used on all stereo 
I2S SoC chips.


Matt
