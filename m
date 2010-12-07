From: Jarkko Nikula <jhnikula@gmail.com>
Subject: Re: [PATCH 2/2] ASoC: omap: Stop DMA re enabling in
 self linkage mode
Date: Tue, 7 Dec 2010 18:00:42 +0200
Message-ID: <20101207180042.76e2d122.jhnikula@gmail.com>
References: <1889FA7136B567478A67D4B0F85B0CCEA4C52E81@dlee06.ent.ti.com>
	<201012071117.26440.peter.ujfalusi@nokia.com>
	<20101207140512.GX4698@rakim.wolfsonmicro.main>
	<201012071638.36075.peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f51.google.com (mail-fx0-f51.google.com
	[209.85.161.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 1E036103A0C
	for <alsa-devel@alsa-project.org>; Tue,  7 Dec 2010 17:00:46 +0100 (CET)
Received: by fxm15 with SMTP id 15so49668fxm.38
	for <alsa-devel@alsa-project.org>; Tue, 07 Dec 2010 08:00:46 -0800 (PST)
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
Cc: "ext Olaya, Margarita" <magi.olaya@ti.com>, alsa-devel@alsa-project.org, ext Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Tue, 7 Dec 2010 16:38:35 +0200
Peter Ujfalusi <peter.ujfalusi@nokia.com> wrote:

> If this could happen, than IMHO it has to be handled by the omap_stop_dma, since 
> other drivers could be hit by the same problem (there might be ERRATA for it 
> already for OMAP4).
> 
I agree with Peter that all DMA stopping related workarounds should be
in omap_stop_dma. I'd expect that DMA is stopped when returning
from there. Commit 9da65a9 was dealing with similar issue so probably
this looping should be implemented somewhere around those lines reading
& clearing the _CCR_EN bit?


-- 
Jarkko
