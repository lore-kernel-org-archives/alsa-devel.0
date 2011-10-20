From: Ashish Chavan <ashish.chavan@kpitcummins.com>
Subject: Re: [PATCH v3 2/8] ASoC: da7210: Add support for DAPM
Date: Thu, 20 Oct 2011 17:17:45 +0530
Message-ID: <1319111265.24621.14.camel@matrix>
References: <1318590098.12107.509.camel@matrix>
	<20111014192008.GD2931@opensource.wolfsonmicro.com>
	<1318666803.613.21.camel@matrix>
	<20111017214107.GC5200@opensource.wolfsonmicro.com>
	<1319008895.7230.11.camel@matrix>
	<20111019121341.GE3107@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ch1outboundpool.messaging.microsoft.com
	(ch1ehsobe006.messaging.microsoft.com [216.32.181.186])
	by alsa0.perex.cz (Postfix) with ESMTP id 6AD0924756
	for <alsa-devel@alsa-project.org>;
	Thu, 20 Oct 2011 13:43:49 +0200 (CEST)
In-Reply-To: <20111019121341.GE3107@opensource.wolfsonmicro.com>
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

On Wed, 2011-10-19 at 13:13 +0100, Mark Brown wrote:
> On Wed, Oct 19, 2011 at 12:51:35PM +0530, Ashish Chavan wrote:
> 
> > BTW if in case, hardware designers reiterate to use STANDBY registers,
> > will it suffice to only document this somewhere is the source?
> 
> The main thing is to make sure that the code is understandable and
> doesn't look buggy to visual inspection so yes, if there's adequate
> documentation that would be OK.
> 

I see.

BTW today I received response from hardware designers and as expected,
they are recommending usage of STANDBY registers instead of
ENABLE/DISABLE registers. The main reason for this is that STANDBY
registers are part of system controller which allows system power
up/down in a controlled, pop free manner. Also, as per application note,
STANDBY register bits are only effective if a particular IO (or ADC/DAC)
is already enabled using enable/disable register bits. This is inline
with my previous patch to support DAPM, i.e.

- All IOs and ADC/DAC are enabled using enable/disable register bits in
probe()
- STANDBY mode of all IOs and ADC/DAC is controlled by DAPM

I am thinking of re-posting the patch after adding above info somewhere.

Is there anything else that I need to take care of?
