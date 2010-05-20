From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: tpa6130a2: Define output pins with
 SND_SOC_DAPM_OUTPUT
Date: Thu, 20 May 2010 08:21:26 -0700
Message-ID: <20100520152125.GA8357@opensource.wolfsonmicro.com>
References: <1274266526-29439-1-git-send-email-jhnikula@gmail.com>
	<201005191500.14607.peter.ujfalusi@nokia.com>
	<1274281512.2698.1053.camel@finisterre.wolfsonmicro.main>
	<201005200903.53926.peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 55B9D24472
	for <alsa-devel@alsa-project.org>;
	Thu, 20 May 2010 17:21:17 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <201005200903.53926.peter.ujfalusi@nokia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Thu, May 20, 2010 at 09:03:53AM +0300, Peter Ujfalusi wrote:
> On Wednesday 19 May 2010 18:05:12 ext Mark Brown wrote:

> I guess my reasoning was to avoid the following DAPM route, which for me seamed 
> weird:
> soc codec                        |      tap6130a2        |   machine driver
> codec_DAC -> .. -> codec_OUTPUT -> tpa_PGA -> tpa_OUTPUT -> machine_HP

> It seamed wrong to have codec_OUTPUT and tpa_OUTPUT in the same DAPM route.

That seems absolutely fine to me - it's something I'd expect to happen
as we move into a multi-chip ASoC world, you'll have signals which go
out of one chip and into another before going to the edge of the system.
The output wigdget is the output of one chip but there's no reason you
can't use it as an input for another chip.

> > They may also wish to use the event that is available on the jack widget to
> > perform some board specific action when the headphone is activated.

> The event is _usually_ needed to toggle the power for the amp (enable/disable).
> The power for the tpa is managed within the driver, so no additional enable is 
> needed.

Well, usually the event is completely unused and the headphone widget is
entirely ornamental.

> > There's no actual requirement to define headphone widgets if they don't
> > have any other code associated with them - if the outputs are left
> > unconnected the effect will be the same as if a noop and unused
> > headphone widget were there.

> That is true, but in that case why would anyone add the tpa amp to their DAPM 
> route in the first place (when it is not connected)?

They wouldn't, I'm just saying that having the extra headphone widget on
the end is not a requirement for anything to function.
