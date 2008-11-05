From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 2/4] ASoC: Add Palm/PXA27x unified ASoC
	audio driver
Date: Wed, 5 Nov 2008 21:54:56 +0000
Message-ID: <20081105215456.GA11921@opensource.wolfsonmicro.com>
References: <20081105185220.GA10816@rakim.wolfsonmicro.main>
	<1225911211-22474-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1225911211-22474-2-git-send-email-broonie@opensource.wolfsonmicro.com>
	<s5hhc6lhpw6.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id EC772244FB
	for <alsa-devel@alsa-project.org>; Wed,  5 Nov 2008 22:54:57 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <s5hhc6lhpw6.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Marek Vasut <marek.vasut@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, Nov 05, 2008 at 09:35:53PM +0100, Takashi Iwai wrote:

> > +#ifdef CONFIG_SND_PXA2XX_SOC_PALM27X
> > +void __init palm27x_asoc_set_pdata(struct palm27x_asoc_info *data);

> I wonder whether it's really __init.

Yes.  This will be set up by the machine init code which has to be built
in.  It should be platform data but we can't support that yet.

> Note that the driver can be a module in theory.

Yeah, that practice won't actually build so should probably be masked
out in Kconfig.
