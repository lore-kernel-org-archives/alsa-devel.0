From: Daniel Mack <daniel@caiaq.de>
Subject: Re: [PATCH 2/3] ASoC: cs4270: add Master Playback
	Switch
Date: Fri, 24 Apr 2009 15:59:22 +0200
Message-ID: <20090424135922.GG10450@buzzloop.caiaq.de>
References: <1240578026-1987-1-git-send-email-daniel@caiaq.de>
	<1240578026-1987-2-git-send-email-daniel@caiaq.de>
	<20090424131738.GE26440@sirena.org.uk>
	<20090424135216.GF10450@buzzloop.caiaq.de>
	<20090424135439.GG26440@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from buzzloop.caiaq.de (buzzloop.caiaq.de [212.112.241.133])
	by alsa0.perex.cz (Postfix) with ESMTP id 1D33D1038A7
	for <alsa-devel@alsa-project.org>;
	Fri, 24 Apr 2009 15:59:25 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20090424135439.GG26440@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@sirena.org.uk>
Cc: alsa-devel@alsa-project.org, Timur Tabi <timur@freescale.com>
List-Id: alsa-devel@alsa-project.org

On Fri, Apr 24, 2009 at 02:54:40PM +0100, Mark Brown wrote:
> > I'll send a new patch for that, providing this feature in a slightly
> > more complex fashion. However, I don't want to remove the other
> > function. If the soc core decides to mute the codec, it should be able
> > to do so.
> 
> It's not the core that needs it, it's the DAC that normally needs the
> core to mute it (modulo random floating signals that it might parse) -
> if cs4270 is happy without the mute then the core doesn't care if it's
> not there.

This codec has pins which are usually connected to some external logic
that can switch off aplifiers and the like when the code is in its mute
state. Which is a nice feature: once you stop the ALSA output,
everything behind the codec in the analog section is put into a
power saving mode and is magically revived once ALSA starts using it
again. That's why I want to leave it in there, even if the codecs does
not necessarily need it.

Daniel
