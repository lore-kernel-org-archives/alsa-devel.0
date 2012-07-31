From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/1] ASoC: sgtl5000: enable VAG_POWER for
 LINE_IN
Date: Tue, 31 Jul 2012 16:46:51 +0100
Message-ID: <20120731154651.GC19974@sirena.org.uk>
References: <1343387922-25227-1-git-send-email-b29396@freescale.com>
 <20120728143957.GJ2128@S2101-09.ap.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id AEC67265D2A
 for <alsa-devel@alsa-project.org>; Tue, 31 Jul 2012 17:46:51 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20120728143957.GJ2128@S2101-09.ap.freescale.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Shawn Guo <shawn.guo@linaro.org>
Cc: alsa-devel@alsa-project.org, Dong Aisheng <b29396@freescale.com>, lrg@ti.com, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

On Sat, Jul 28, 2012 at 10:39:59PM +0800, Shawn Guo wrote:
> On Fri, Jul 27, 2012 at 07:18:42PM +0800, Dong Aisheng wrote:

> > LINE_IN also needs VAG_POWER on or we may hear noise when directly
> > route LINE_IN to Headphone Mux.

> The following is what I see from sgtl5000 data sheet about VAG_POWER.

>   VAG is the internal voltage reference for the ADC and DAC.

> Are you seeing any info that requires VAG_POWER in route of LINE_IN to
> Headphone Mux?  Or it's only a result from your testing?

Given the name I rather suspect that's a datasheet error and the same
reference is used by other bits of the chip.  Just guessing, though.
