From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [PATCH] Add AC'97 driver for AT91SAM9263ek atmel
	board.
Date: Thu, 2 Oct 2008 10:52:09 +0100
Message-ID: <20081002095207.GE2848@sirena.org.uk>
References: <48E3A42C.6090202@atmel.com> <48E48B76.1050809@atmel.com>
	<s5h4p3vicaz.wl%tiwai@suse.de>
	<20081002092430.GB2848@sirena.org.uk> <48E49852.2010504@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id A9232244F7
	for <alsa-devel@alsa-project.org>;
	Thu,  2 Oct 2008 11:52:10 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <48E49852.2010504@atmel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Sedji Gaouaou <sedji.gaouaou@atmel.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, Oct 02, 2008 at 11:45:54AM +0200, Sedji Gaouaou wrote:

> Should I provide the same thing?
> This driver is not based on the ASoC.
> Nevertheless I can see that there is a ac97 driver in sound/soc/codec, 
> so should I do the same as pxa, I mean create 2 drivers?

It's up to you but I would suggest that it's easier to just leave the
ASoC driver until there is some user demand for it.  The ASoC AC97
support won't offer any benefit unless board designs have codecs or
other external components which can take advantage of it.
