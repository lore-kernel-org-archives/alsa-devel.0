From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: Output frequency configuration for I2S
	in	beagleboard? (underrun problem)
Date: Wed, 13 May 2009 10:53:19 +0100
Message-ID: <20090513095318.GA10035@sirena.org.uk>
References: <fb44c3530905121628i56a92ea8x10f966b7aa4ebc00@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 0DB0C2478E
	for <alsa-devel@alsa-project.org>;
	Wed, 13 May 2009 11:53:22 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <fb44c3530905121628i56a92ea8x10f966b7aa4ebc00@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Ernesto Torres <skullmate@gmail.com>
Cc: alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Tue, May 12, 2009 at 06:28:58PM -0500, Ernesto Torres wrote:

> *static int omap_mcbsp_dai_set_clkdiv(struct snd_soc_dai *cpu_dai,
>                      int div_id, int div)

> Here, the value is asigned to srgr1. I capture all actions from startup and
> from aplay but this function is never called. Do you know when it should be
> called or where we can find the div value?

The beagle is configured to clock the I2S bus from the TWL4030 rather
than from the OMAP.
