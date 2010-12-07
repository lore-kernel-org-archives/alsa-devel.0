From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 2/2] ASoC: omap: Stop DMA re enabling in
 self linkage mode
Date: Tue, 7 Dec 2010 14:05:12 +0000
Message-ID: <20101207140512.GX4698@rakim.wolfsonmicro.main>
References: <1889FA7136B567478A67D4B0F85B0CCEA4C52E81@dlee06.ent.ti.com>
	<201012071117.26440.peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 1EF2F103A79
	for <alsa-devel@alsa-project.org>; Tue,  7 Dec 2010 15:05:14 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <201012071117.26440.peter.ujfalusi@nokia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Cc: "ext Olaya, Margarita" <magi.olaya@ti.com>, alsa-devel@alsa-project.org, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Tue, Dec 07, 2010 at 11:17:26AM +0200, Peter Ujfalusi wrote:

> I have not seen this happening on OMAP2/3, or at least I'm not aware of it.
> Is this problem OMAP4 only?
> Do you know if this happens on playback, capture or in both direction?
> Is it worth to do this workaround only on OMAP4?

Given that the patch should cause at most a single read from a register
when tearing down DMA if it's not required I'd guess it's safer to just
unconditionally enable the workaround on the off chance that it's just
reallly rare rather than not needed?
