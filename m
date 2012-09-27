From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: ASoC on today's linux-next: dma_alloc_writecombine() failing at least
 on OMAP platforms
Date: Thu, 27 Sep 2012 15:16:45 +0300
Message-ID: <506443AD.1060201@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-next-owner@vger.kernel.org>
Sender: linux-next-owner@vger.kernel.org
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, "Girdwood, Liam" <lrg@ti.com>, linux-next@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Hello,

I tried today's linux-next on OMAP platform and audio is not probing be=
cause
dma_alloc_writecombine() fails to get the area.
My linux-next from two days ago works OK and I don't see anything direc=
tly
connected to OMAP which can cause this failure.

Can someone try linux-next on non OMAP platform to see if
dma_alloc_writecombine() works there?

Meanwhile I'll try to find the reason why it fails for me.

Thanks,
P=E9ter
