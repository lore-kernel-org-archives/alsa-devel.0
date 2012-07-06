From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: dapm: Fix locking during codec
	shutdown
Date: Fri, 6 Jul 2012 17:43:44 +0100
Message-ID: <20120706164344.GH4017@opensource.wolfsonmicro.com>
References: <1341590225-20837-1-git-send-email-lrg@ti.com>
	<20120706160220.GG4017@opensource.wolfsonmicro.com>
	<1341592575.4963.7.camel@odin>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 379D0104593
	for <alsa-devel@alsa-project.org>;
	Fri,  6 Jul 2012 18:43:46 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1341592575.4963.7.camel@odin>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, Misael Lopez Cruz <misael.lopez@ti.com>
List-Id: alsa-devel@alsa-project.org

On Fri, Jul 06, 2012 at 05:36:15PM +0100, Liam Girdwood wrote:

> I don't think there is anything explicitly stopping a power off from
> happening during a stream shutdown atm without this patch. It was
> reported to me that this would fail 1 in 20 times on a certain device
> and that the above patch fixed the issue (1200 tests completed OK after
> the patch).

> I do think we need this patch atm since we are accessing the same
> resources as the stream event.

So how is suspend and resume safe, for example?  It's the same general
path through the PM core.
