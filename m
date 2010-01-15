From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/2] ALSA: ASoC: cs4270: allow passing
 freq=0 in set_dai_sysclk()
Date: Fri, 15 Jan 2010 17:29:22 +0000
Message-ID: <20100115172922.GA7138@rakim.wolfsonmicro.main>
References: <20100113162749.GA26519@sirena.org.uk>
	<1263573409-30863-1-git-send-email-daniel@caiaq.de>
	<4B50A128.9050105@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id C1B3C103926
	for <alsa-devel@alsa-project.org>; Fri, 15 Jan 2010 18:29:23 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <4B50A128.9050105@freescale.com>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, Jan 15, 2010 at 11:08:56AM -0600, Timur Tabi wrote:
> Daniel Mack wrote:

> > For setups with variable MCLKs, the current logic of limiting the
> > available sampling rates at startup time is not sufficient. We need to
> > be able to change the setting at a later point, and so the codec must
> > offer all possible rates until the hw_params are given.

> > Signed-off-by: Daniel Mack <daniel@caiaq.de>

> Acked-by: Timur Tabi <timur@freescale.com>

Applied both patches, thanks.
