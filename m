From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: AK4671 pin sharing
Date: Thu, 26 Nov 2009 10:43:09 +0000
Message-ID: <20091126104308.GA12885@sirena.org.uk>
References: <2A201BEEC85E064DA2513CADA373DB0DA765C9@mx2.telecom.sna.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 43AA924150
	for <alsa-devel@alsa-project.org>; Thu, 26 Nov 2009 11:43:10 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <2A201BEEC85E064DA2513CADA373DB0DA765C9@mx2.telecom.sna.samsung.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Misael Lopez <mlopez@sta.samsung.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, Nov 25, 2009 at 11:44:47AM -0600, Misael Lopez wrote:

> full-differential mode as well. However, the chip doesn't have separate
> pins for the differential input/outputs, but instead the same pins
> used in single-ended mode can be reconfigured and reused.

This is a common arrangement.

> (full-differential). Changing the function of a pin also modifies the
> audio map:

> My concerns are:
> - When inputs/outputs are single-ended, then they have its own widgets,
>   i.e.: 

> - Audio map changes depending on the mode of inputs or outputs, I don't
>   know how the SoC codec driver could handle that.

> Any suggestion on what to do in above scenarios?

The WM8993 has similar routing changes when in fully differential mode.
It uses platform data to configure the mode and registers different
widgets depending on the configuration.
