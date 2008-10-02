From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [PATCH] Add AC'97 driver for AT91SAM9263ek atmel
	board.
Date: Thu, 2 Oct 2008 10:24:31 +0100
Message-ID: <20081002092430.GB2848@sirena.org.uk>
References: <48E3A42C.6090202@atmel.com> <48E48B76.1050809@atmel.com>
	<s5h4p3vicaz.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 88B97244B2
	for <alsa-devel@alsa-project.org>;
	Thu,  2 Oct 2008 11:24:32 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5h4p3vicaz.wl%tiwai@suse.de>
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
Cc: Sedji Gaouaou <sedji.gaouaou@atmel.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, Oct 02, 2008 at 11:19:48AM +0200, Takashi Iwai wrote:
> Sedji Gaouaou wrote:
> > Sedji Gaouaou a ?crit :

> > When I was writing this patch I was wondering if it should actually be 
> > in the sound/arm directory or in a sound/soc/atmel directory?

> sound/arm looks correct unless the driver is based on the ASoC
> framework.

Indeed.

If you look at pxa2xx-ac97 you'll see that for that there's actually two
drivers (both of which now share most of the actual hardware access code
thanks to some good work by Dmitry Baryshkov), one for the non-ASoC AC97
framework and one for use within ASoC.  Both can be useful, though the
ASoC one is only useful if people design boards which can make use of
the extra features it provides.
