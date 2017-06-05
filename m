From: James Cameron <quozl@laptop.org>
Subject: Re: [PATCH] ASoC: audio-graph-scu-card: add missing
 MIX binding example
Date: Mon, 5 Jun 2017 15:15:47 +1000
Message-ID: <20170605051547.GC25989@us.netrek.org>
References: <87h8zvdq17.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from swan.laptop.org (swan.laptop.org [18.85.44.157])
 by alsa0.perex.cz (Postfix) with ESMTP id 4E17A2668E2
 for <alsa-devel@alsa-project.org>; Mon,  5 Jun 2017 07:15:54 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <87h8zvdq17.wl%kuninori.morimoto.gx@renesas.com>
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
Cc: linux-renesas-soc@vger.kernel.org, Linux-ALSA <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>, Simon <horms@verge.net.au>
List-Id: alsa-devel@alsa-project.org

On Mon, Jun 05, 2017 at 04:25:15AM +0000, Kuninori Morimoto wrote:
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> 
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> ---
>  .../bindings/sound/audio-graph-scu-card.txt        | 47 +++++++++++++++++++++-
>  1 file changed, 46 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/sound/audio-graph-scu-card.txt b/Documentation/devicetree/bindings/sound/audio-graph-scu-card.txt
> index b2dd23f..ca494cf 100644
> --- a/Documentation/devicetree/bindings/sound/audio-graph-scu-card.txt
> +++ b/Documentation/devicetree/bindings/sound/audio-graph-scu-card.txt
> @@ -35,7 +35,7 @@ Required properties:
>  - compatible				: "audio-graph-scu-card";
>  - dais					: list of CPU DAI port{s}
>  
> -Example
> +Example 1. Sampling Rate Covert

Other documentation refers to sampling rate conversion or converter
unit, but simple-scu-card.txt and your patch refer to making the
sampling rate covert.  Perhaps "covert" should be "convert."

-- 
James Cameron
http://quozl.netrek.org/
