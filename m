From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 2/2] ASoC: omap: Stop DMA re enabling in
 self linkage mode
Date: Tue, 7 Dec 2010 14:43:48 +0000
Message-ID: <20101207144348.GA9689@rakim.wolfsonmicro.main>
References: <1889FA7136B567478A67D4B0F85B0CCEA4C52E81@dlee06.ent.ti.com>
	<201012071117.26440.peter.ujfalusi@nokia.com>
	<20101207140512.GX4698@rakim.wolfsonmicro.main>
	<201012071638.36075.peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id F31D9103AAB
	for <alsa-devel@alsa-project.org>; Tue,  7 Dec 2010 15:43:49 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <201012071638.36075.peter.ujfalusi@nokia.com>
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

On Tue, Dec 07, 2010 at 04:38:35PM +0200, Peter Ujfalusi wrote:

> Sure, it is a single read to a register, but generally I'm a bit nervous, when 
> we have a while loop without timeout counter.
> In theory we could have infinite loop, if the HW has a bad day...
> This could be safe on all OMAP platforms, but I think it has been only tested on 
> OMAP4.
> If this could happen, than IMHO it has to be handled by the omap_stop_dma, since 
> other drivers could be hit by the same problem (there might be ERRATA for it 
> already for OMAP4).

A timeout would be better in general, yes.
