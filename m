From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v2 2/2] ASoC: omap-mcpdm: Replace legacy
	driver
Date: Tue, 23 Aug 2011 11:57:17 +0100
Message-ID: <20110823105716.GK9232@opensource.wolfsonmicro.com>
References: <1313739679-8975-1-git-send-email-peter.ujfalusi@ti.com>
	<1313739679-8975-3-git-send-email-peter.ujfalusi@ti.com>
	<20110820070113.GB5011@opensource.wolfsonmicro.com>
	<1841405.uncpCjWKsY@barack>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id E5EFC2464C
	for <alsa-devel@alsa-project.org>;
	Tue, 23 Aug 2011 12:57:18 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1841405.uncpCjWKsY@barack>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: =?iso-8859-1?Q?P=E9ter?= Ujfalusi <peter.ujfalusi@ti.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Girdwood,
	Liam" <lrg@ti.com>, "Lopez Cruz, Misael" <misael.lopez@ti.com>
List-Id: alsa-devel@alsa-project.org

On Tue, Aug 23, 2011 at 10:52:03AM +0300, P=E9ter Ujfalusi wrote:

> 1. Stop platform (DMA)
> 2. Power down (mostly codec side)
> 3. Stop cpu dai

> I'm not sure about this, but we should not have running DMA after =

> trigger:stop?

I'd expect that to stop the DMA.  I need to think about this properly
but I think the main trick is keeping the CPU DAI active for longer than
we would normally.
