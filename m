From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: codec power question
Date: Tue, 15 Mar 2011 13:25:43 +0000
Message-ID: <20110315132542.GB10848@opensource.wolfsonmicro.com>
References: <1300182023.1497.7.camel@vkoul-udesk3>
	<20110315113030.GB17277@sirena.org.uk>
	<1300192047.19661.5.camel@vkoul-udesk3>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id D8C491038EA
	for <alsa-devel@alsa-project.org>; Tue, 15 Mar 2011 14:25:45 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1300192047.19661.5.camel@vkoul-udesk3>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Koul, Vinod" <vinod.koul@intel.com>
Cc: alsa <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmciro.com>, Liam <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Tue, Mar 15, 2011 at 05:57:27PM +0530, Koul, Vinod wrote:

> In andriod, flinger opens the streams at boot and keeps them ON, and
> doesn't close the stream when in idle.
> Since the stream in ON, codec consumes lot of power, I was wondering if
> we have something in asoc to detect this kind of state and do much
> better power control.

Ah, this is just a plain userspace bug in the default ALSA thing that
went up on the Android git - there's no way sensible way to figure out
that userspace is playing silence because it's being silly.

The Nexus S libaudio does a better job here though it has its own issues
due to the integration with the non-mainline CODEC driver they're using.
