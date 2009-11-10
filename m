From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH]ASoc:ZOOM2:Add support for DSP rendering.
Date: Tue, 10 Nov 2009 13:03:34 +0000
Message-ID: <20091110130334.GC16200@rakim.wolfsonmicro.main>
References: <1257459691-12411-1-git-send-email-jwang@ti.com>
	<20091106140306.GD10371@rakim.wolfsonmicro.main>
	<13B9B4C6EF24D648824FF11BE8967162039B8D1913@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 5B9AD243C4
	for <alsa-devel@alsa-project.org>; Tue, 10 Nov 2009 14:03:35 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <13B9B4C6EF24D648824FF11BE8967162039B8D1913@dlee02.ent.ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Wang, Jane" <jwang@ti.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "peter.ujfalusi@nokia.com" <peter.ujfalusi@nokia.com>
List-Id: alsa-devel@alsa-project.org

On Mon, Nov 09, 2009 at 11:22:47AM -0600, Wang, Jane wrote:

Please fix your MUA to word wrap your mails; it makes them very much
more legible and easy to reply to.

> The scenario is data is going between DSP<->McBSP<->TWL4030. DSP
> configures and controls McBSP ports. Since DSP does not have control
> over TWl4030 codec, the role of ALSA here is providing mixer controls
> for user space application to configure codec to prepare for DSP
> rendering.

So in this setup the DSP is essentially a separate device on the audio
bus; it's very much similar to things like the bluetooth chipset you can
see in the OpenMoko devices and ought to be presented in a similar way
as a separate DAI.

> TWL4030 driver does not provide explicit controls over DAC/ADC, mic
> bias, APLL, headset pop-noise attenuation etc, and we need these to make
> playback/capture happen. I can think of two ways to handle this, one is
> add controls in codec to explicitly control these widgets, or using DAPM
> stream events as a single control to power up/down the path. And I feel
> the second solution is cleaner...

Representing the DSP DAI to ASoC is what's needed here, check out the
OpenMoko code for an example of solving a similar problem.
