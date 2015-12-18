From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 12/12] ASoC: rsnd: add Multi channel support
Date: Fri, 18 Dec 2015 14:04:51 -0600
Message-ID: <20151218200448.GA1476@rob-hp-laptop>
References: <87egeliyaz.wl%kuninori.morimoto.gx@renesas.com>
 <87wpsdhje9.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rob-hp-laptop (unknown [68.66.83.131])
 by alsa0.perex.cz (Postfix) with ESMTP id 3B33F26571D
 for <alsa-devel@alsa-project.org>; Sat, 19 Dec 2015 05:09:35 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <87wpsdhje9.wl%kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Linux-DT <devicetree@vger.kernel.org>, Linux-ALSA <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Simon <horms@verge.net.au>
List-Id: alsa-devel@alsa-project.org

On Thu, Dec 17, 2015 at 03:00:10AM +0000, Kuninori Morimoto wrote:
> 
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> 
> This patch adds Multi channel support on Renesas R-Car sound.
> This patch is tested on Salvator-X board, but it can't use
> Multi channel, because supported format is different between
> codec chip and R-Car.
> Thus, it was tested on board which doesn't mount codec chip,
> with oscilloscope.
> 
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> ---
>  .../devicetree/bindings/sound/renesas,rsnd.txt     |  18 ++++

For the binding:

Acked-by: Rob Herring <robh@kernel.org>

>  sound/soc/sh/rcar/core.c                           |   6 +-
>  sound/soc/sh/rcar/gen.c                            |   3 +
>  sound/soc/sh/rcar/rsnd.h                           |  15 ++-
>  sound/soc/sh/rcar/ssi.c                            | 114 ++++++++++++++++++++-
>  sound/soc/sh/rcar/ssiu.c                           |  55 ++++++++--
>  6 files changed, 194 insertions(+), 17 deletions(-)
