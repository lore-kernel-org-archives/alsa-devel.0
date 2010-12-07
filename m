From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH 2/2] ASoC: omap: Stop DMA re enabling in
 self linkage mode
Date: Tue, 07 Dec 2010 15:17:34 +0000
Message-ID: <1291735054.3275.86.camel@odin>
References: <1889FA7136B567478A67D4B0F85B0CCEA4C52E81@dlee06.ent.ti.com>
	<201012071117.26440.peter.ujfalusi@nokia.com>
	<20101207140512.GX4698@rakim.wolfsonmicro.main>
	<201012071638.36075.peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ww0-f51.google.com (mail-ww0-f51.google.com [74.125.82.51])
	by alsa0.perex.cz (Postfix) with ESMTP id BD9AD2414E
	for <alsa-devel@alsa-project.org>; Tue,  7 Dec 2010 16:17:37 +0100 (CET)
Received: by wwe15 with SMTP id 15so6810wwe.20
	for <alsa-devel@alsa-project.org>; Tue, 07 Dec 2010 07:17:37 -0800 (PST)
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
Cc: "ext Olaya, Margarita" <magi.olaya@ti.com>, alsa-devel@alsa-project.org, ext Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On Tue, 2010-12-07 at 16:38 +0200, Peter Ujfalusi wrote:
> On Tuesday 07 December 2010 16:05:12 ext Mark Brown wrote:
> > On Tue, Dec 07, 2010 at 11:17:26AM +0200, Peter Ujfalusi wrote:
> > > I have not seen this happening on OMAP2/3, or at least I'm not aware of
> > > it. Is this problem OMAP4 only?
> > > Do you know if this happens on playback, capture or in both direction?
> > > Is it worth to do this workaround only on OMAP4?
> > 
> > Given that the patch should cause at most a single read from a register
> > when tearing down DMA if it's not required I'd guess it's safer to just
> > unconditionally enable the workaround on the off chance that it's just
> > reallly rare rather than not needed?
> 
> Sure, it is a single read to a register, but generally I'm a bit nervous, when 
> we have a while loop without timeout counter.
> In theory we could have infinite loop, if the HW has a bad day...
> This could be safe on all OMAP platforms, but I think it has been only tested on 
> OMAP4.
> If this could happen, than IMHO it has to be handled by the omap_stop_dma, since 
> other drivers could be hit by the same problem (there might be ERRATA for it 
> already for OMAP4).
> 

Afaik, this has also been tested on OMAP3. Not sure about OMAP2 and most
likely not tested on OMAP1.

Liam 
