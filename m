From: Liam Girdwood <lg@opensource.wolfsonmicro.com>
Subject: Re: Embedded I2S / 192khz
Date: Thu, 08 May 2008 15:22:41 +0100
Message-ID: <1210256561.20475.16.camel@odin>
References: <76366b180805080650p615851afi272602115ca1660a@mail.gmail.com>
	<20080508140856.GC23041@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 1FAC724733
	for <alsa-devel@alsa-project.org>;
	Thu,  8 May 2008 16:22:43 +0200 (CEST)
In-Reply-To: <20080508140856.GC23041@sirena.org.uk>
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
Cc: ALSA development <alsa-devel@alsa-project.org>, Andrew Paprocki <andrew@ishiboo.com>
List-Id: alsa-devel@alsa-project.org

On Thu, 2008-05-08 at 15:08 +0100, Mark Brown wrote:
> On Thu, May 08, 2008 at 09:50:32AM -0400, Andrew Paprocki wrote:
> 
> > Is anyone aware of a Linux/ALSA capable chip that can drive 192khz
> > I2S? I poked through the ASoC code and could only see 96khz
> > capability.
> 
> The PowerPC code in sound/soc/fsl (as of 2.6.25) supports up to 192kHz,
> though it appears to require the codec to clock the bus.  The SuperH and
> Alchemy code in:
> 
>    git://opensource.wolfsonmicro.com/linux-2.6-asoc
> 
> says they support up to 192kHz too.  PXA3xx should support this too when
> it's done.

heh, shows how much attention I've been paying lately to commits.

PX2xx (SSP) and i.MX3x (SSI) should also do 192kHz too. Interestingly
pxa2xx I2S almost manages (datasheet max is 48kHz) 192kHz but underruns
a bit!
