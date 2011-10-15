From: Ashish Chavan <ashish.chavan@kpitcummins.com>
Subject: Re: [PATCH v3 2/8] ASoC: da7210: Add support for DAPM
Date: Sat, 15 Oct 2011 13:50:03 +0530
Message-ID: <1318666803.613.21.camel@matrix>
References: <1318590098.12107.509.camel@matrix>
	<20111014192008.GD2931@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from AM1EHSOBE005.bigfish.com (am1ehsobe005.messaging.microsoft.com
	[213.199.154.208])
	by alsa0.perex.cz (Postfix) with ESMTP id 4EE8924419
	for <alsa-devel@alsa-project.org>;
	Sat, 15 Oct 2011 10:08:40 +0200 (CEST)
In-Reply-To: <20111014192008.GD2931@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel <alsa-devel@alsa-project.org>, "kuninori.morimoto.gx" <kuninori.morimoto.gx@renesas.com>, linux-kernel <linux-kernel@vger.kernel.org>, David@alsa-project.org, Chen <david.chen@diasemi.com>, lrg <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Fri, 2011-10-14 at 20:20 +0100, Mark Brown wrote:
> On Fri, Oct 14, 2011 at 04:31:38PM +0530, Ashish Chavan wrote:
> 
> > +	/* ADCs */
> > +	SND_SOC_DAPM_ADC("ADC Left", "Capture", DA7210_STARTUP3, 5, 1),
> > +	SND_SOC_DAPM_ADC("ADC Right", "Capture", DA7210_STARTUP3, 6, 1),
> > +
> > +	/* Output Side */
> > +	/* DACs */
> > +	SND_SOC_DAPM_DAC("DAC Left", "Playback", DA7210_STARTUP2, 5, 1),
> > +	SND_SOC_DAPM_DAC("DAC Right", "Playback", DA7210_STARTUP2, 6, 1),
> 
> These are also being enabled in the probe() function using completely
> different registers - there the registers used are _ADC and _DAC.
> What's going on there?  It's good to see the stuff in the startup()
> function gone but almost all of the probe() just shouldn't be there in a
> properly written driver and much of it looks like stuff that DAPM should
> be taking care of.
> 

There are two type of registers for all IOs (HP, MIC, AUX) as well as
DAC and ADC. One type of registers control individual enable and disable
of IO, while other set of register controls the standby mode of that
particular IO. e.g. For ADC,

- Enable/disable of ADC left and right channel is controlled by bit 3
and 7 of DA7210_ADC register.

- Standby mode of ADC left and right channel is controlled by bit 5 and
6 of DA7210_STARTUP3 register.

As per hardware designer's recommendation, standby mode is preferred for
minimum power consumption. So, current DAPM patch only takes care of
STANDBY bits.
