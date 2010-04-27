From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/2] powerpc: add platform registration	for
	ALSA SoC drivers
Date: Tue, 27 Apr 2010 21:38:21 +0100
Message-ID: <20100427203821.GA15083@opensource.wolfsonmicro.com>
References: <1272314980-23679-1-git-send-email-timur@freescale.com>
	<1272350168.24542.6.camel@pasglop> <1272355624.3204.52.camel@odin>
	<4BD6FA39.3030400@freescale.com>
	<1272381611.11000.39.camel@odin> <4BD70292.20001@freescale.com>
	<1272386470.11000.84.camel@odin> <4BD72DB0.20808@freescale.com>
	<s2ifa686aa41004271215tb3c992c1v8996ce5520896c6c@mail.gmail.com>
	<4BD74351.9030704@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 268B22413F
	for <alsa-devel@alsa-project.org>;
	Tue, 27 Apr 2010 22:38:22 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <4BD74351.9030704@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Timur Tabi <timur@freescale.com>
Cc: alsa-devel@alsa-project.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, kumar.gala@freescale.com, Grant Likely <grant.likely@secretlab.ca>, linuxppc-dev@ozlabs.org, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Tue, Apr 27, 2010 at 03:04:33PM -0500, Timur Tabi wrote:

[Reflowed into 80 columns]

> At least, that's the way ASoC likes to operate.  AsoC takes a fixed
> string plus a unique integer.  I could technically create a unique
> string for each DMA device, and have the integer always be 0.

This seems like the most direct approach to your problem - as with other
subsystems the .id is there mostly to provide deduping when the string
is always the same, if you can easily come up with sensible names you
can just use those.
