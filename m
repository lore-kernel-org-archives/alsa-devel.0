From: Cao Minh Hiep <cm-hiep@jinso.co.jp>
Subject: Re: [PATCH 0/4] ASoC: rsnd: fixup interrupt / spin lock issue
Date: Wed, 20 May 2015 15:12:23 +0900
Message-ID: <555C25C7.3080501@jinso.co.jp>
References: <87382r52x2.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <87382r52x2.wl%kuninori.morimoto.gx@renesas.com>
Sender: linux-sh-owner@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Vinod Koul <vinod.koul@intel.com>, Mark Brown <broonie@kernel.org>
Cc: Simon <horms@verge.net.au>, Nguyen Viet Dung <nv-dung@jinso.co.jp>, Magnus <magnus.damm@gmail.com>, Linux-SH <linux-sh@vger.kernel.org>, Linux-ALSA <alsa-devel@alsa-project.org>, Liam Girdwood <lgirdwood@gmail.com>, Laurent <laurent.pinchart@ideasonboard.com>, Geert Uytterhoeven <geert+renesas@glider.be>, sakato <ryusuke.sakato.bx@renesas.com>, dmaengine@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Hi All

On 2015=E5=B9=B405=E6=9C=8820=E6=97=A5 12:45, Kuninori Morimoto wrote:

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
I have just patched these patches and tested them.
I tested 40 times with playback and recode
(for 4 times restart x 10 times playback and record),
It works very well without any problems.
I mean these patches fixed our bug of kernel panic when playback.

Tested by: Cao Minh Hiep <cm-hiep@jinso.co.jp>


Best Regards,
Cao Minh Hiep.

