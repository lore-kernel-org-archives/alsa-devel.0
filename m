From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/2] ASoC: Fix ADAU1701 build in
	SND_SOC_ALL_CODECS
Date: Fri, 17 Jun 2011 11:32:18 +0100
Message-ID: <20110617103218.GA29723@opensource.wolfsonmicro.com>
References: <1308306271-28411-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id E8A8C1039E6
	for <alsa-devel@alsa-project.org>;
	Fri, 17 Jun 2011 12:32:22 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1308306271-28411-1-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mike Frysinger <vapier@gentoo.org>, Liam Girdwood <lrg@slimlogic.co.uk>
Cc: alsa-devel@alsa-project.org, device-drivers-devel@blackfin.uclinux.org
List-Id: alsa-devel@alsa-project.org

On Fri, Jun 17, 2011 at 11:24:30AM +0100, Mark Brown wrote:
> Since select doesn't obey dependencies we need ALL_CODECS to select SIGMA
> directly.
> 
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

Hrm, actually the drivers/firmware Kconfig isn't even included on any
architectures except ia64, x86 and blackfin so this is going to be a
general failure.  We also need a patch or patches adding firmware to the
build for all architectures.
