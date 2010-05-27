From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: ASoC: Hooking a TI CODEC to a i.MX27 MCU
Date: Thu, 27 May 2010 01:47:03 +0100
Message-ID: <20100527004702.GA22091@sirena.org.uk>
References: <20100524074946.GC16346@www.longlandclan.yi.org>
	<1274698156.3064.93.camel@odin>
	<20100525004126.GA10968@www.longlandclan.yi.org>
	<20100525022646.GA18030@www.longlandclan.yi.org>
	<1274806007.4728.3.camel@gnutoo-desktop>
	<20100526132129.GA13644@www.longlandclan.yi.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 1973B2436E
	for <alsa-devel@alsa-project.org>;
	Thu, 27 May 2010 02:47:05 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20100526132129.GA13644@www.longlandclan.yi.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Stuart Longland <redhatter@gentoo.org>
Cc: alsa-devel@alsa-project.org, gnutoo <GNUtoo@no-log.org>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Wed, May 26, 2010 at 11:21:36PM +1000, Stuart Longland wrote:

> At the moment, when I go to play audio; I see the CODEC being set up ...
> but despite the clocks being present -- I see no audio data, and the DMA
> transfer eventually times out with the message "playback write error
> (DMA or IRQ trouble?)" after 10 seconds.  Would anyone know where I'd
> look for that?  Is there something else needed in the configuration of
> the SSI driver for this to work?

This most likely means your CPU side configuration is broken and clocks
aren't being routed through.  Try looking at the AUDMUX debugfs files to
verify your configuration, and also try routing out to another external
SSI port so you can probe signals.  Make sure the relevant pins on the
i.MX are configured into the appropriate mode for use by the i.MX too.

Note also that the current driver only supports CODEC as clock master.
