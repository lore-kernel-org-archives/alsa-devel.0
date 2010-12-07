From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re: [PATCH 2/2] ASoC: omap: Stop DMA re enabling in
	self linkage mode
Date: Tue, 7 Dec 2010 16:38:35 +0200
Message-ID: <201012071638.36075.peter.ujfalusi@nokia.com>
References: <1889FA7136B567478A67D4B0F85B0CCEA4C52E81@dlee06.ent.ti.com>
	<201012071117.26440.peter.ujfalusi@nokia.com>
	<20101207140512.GX4698@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-sa01.nokia.com (smtp.nokia.com [147.243.1.47])
	by alsa0.perex.cz (Postfix) with ESMTP id 48D1C10383E
	for <alsa-devel@alsa-project.org>; Tue,  7 Dec 2010 15:38:43 +0100 (CET)
In-Reply-To: <20101207140512.GX4698@rakim.wolfsonmicro.main>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: "ext Olaya, Margarita" <magi.olaya@ti.com>, ext Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Tuesday 07 December 2010 16:05:12 ext Mark Brown wrote:
> On Tue, Dec 07, 2010 at 11:17:26AM +0200, Peter Ujfalusi wrote:
> > I have not seen this happening on OMAP2/3, or at least I'm not aware of
> > it. Is this problem OMAP4 only?
> > Do you know if this happens on playback, capture or in both direction?
> > Is it worth to do this workaround only on OMAP4?
> =

> Given that the patch should cause at most a single read from a register
> when tearing down DMA if it's not required I'd guess it's safer to just
> unconditionally enable the workaround on the off chance that it's just
> reallly rare rather than not needed?

Sure, it is a single read to a register, but generally I'm a bit nervous, w=
hen =

we have a while loop without timeout counter.
In theory we could have infinite loop, if the HW has a bad day...
This could be safe on all OMAP platforms, but I think it has been only test=
ed on =

OMAP4.
If this could happen, than IMHO it has to be handled by the omap_stop_dma, =
since =

other drivers could be hit by the same problem (there might be ERRATA for i=
t =

already for OMAP4).

-- =

P=E9ter
