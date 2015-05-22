From: Cao Minh Hiep <cm-hiep@jinso.co.jp>
Subject: Re: [PATCH 0/4 v2] ASoC: rsnd: fixup interrupt / spin lock issue
Date: Fri, 22 May 2015 10:41:17 +0900
Message-ID: <555E893D.2060705@jinso.co.jp>
References: <878ucitwyh.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <878ucitwyh.wl%kuninori.morimoto.gx@renesas.com>
Sender: linux-sh-owner@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Vinod Koul <vinod.koul@intel.com>, Mark Brown <broonie@kernel.org>
Cc: Simon <horms@verge.net.au>, Nguyen Viet Dung <nv-dung@jinso.co.jp>, Magnus <magnus.damm@gmail.com>, Linux-SH <linux-sh@vger.kernel.org>, Linux-ALSA <alsa-devel@alsa-project.org>, Liam Girdwood <lgirdwood@gmail.com>, Laurent <laurent.pinchart@ideasonboard.com>, Geert Uytterhoeven <geert+renesas@glider.be>, sakato <ryusuke.sakato.bx@renesas.com>, dmaengine@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Hi Morimoto-san,
Sorry for late replying.

On 2015=E5=B9=B405=E6=9C=8821=E6=97=A5 12:47, Kuninori Morimoto wrote:
> Hi Mark, Vinod
> Cc Laurent, Hiep-san
>
> These are v2 of fixup unknown interrupt issue patch which was reporte=
d by
> Hiep-san in v4.1-rcX kernel. It was not happened in v4.0 because ARM
> platform side couldn't use DMA transfer.
>
> We tested these same as v1 patches, and confirmed these solved proble=
m
>
> Hiep-san, can you please re-test these patches ?
>
> Kuninori Morimoto (4):
>        1) dmaengine: rcar-dmac: fixup spinlock in rcar-dmac
>        2) ASoC: rsnd: indicate unknown HW start
>        3) ASoC: rsnd: add rsnd_dai_stream_quit()
>        4) ASoC: rsnd: spin lock for interrupt handler
>
>   drivers/dma/sh/rcar-dmac.c | 55 +++++++++++++++++++++++++++++++----=
--------------------
>   sound/soc/sh/rcar/core.c   | 25 ++++++++++++++++++-------
>   sound/soc/sh/rcar/rsnd.h   |  3 +--
>   sound/soc/sh/rcar/src.c    | 11 ++++++++---
>   sound/soc/sh/rcar/ssi.c    | 18 ++++++++++++++----
>   5 files changed, 72 insertions(+), 40 deletions(-)
We re-tested these patches on our Lager board.
(30 times playback + 10 minutes recode and playback)
It works very well without any problems,

Best Regards,
Cao Minh Hiep.

