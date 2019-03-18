From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH 1/2] ASoC: rsnd: add missing reg/reg-name
	at Document
Date: Mon, 18 Mar 2019 11:38:06 +0100
Message-ID: <20190318103806.oqfugvu57jjdotey@verge.net.au>
References: <87imwgye1k.wl-kuninori.morimoto.gx@renesas.com>
 <87h8c0ye0n.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from kirsty.vergenet.net (kirsty.vergenet.net [202.4.237.240])
 by alsa1.perex.cz (Postfix) with ESMTP id 56D0FF80709
 for <alsa-devel@alsa-project.org>; Mon, 18 Mar 2019 11:38:13 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <87h8c0ye0n.wl-kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Geert Uytterhoeven <geert.uytterhoeven@gmail.com>, Linux-ALSA <alsa-devel@alsa-project.org>, Jiada Wang <jiada_wang@mentor.com>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Mark Brown <broonie@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>
List-Id: alsa-devel@alsa-project.org

On Mon, Mar 18, 2019 at 02:11:27PM +0900, Kuninori Morimoto wrote:
> 
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> 
> reg is missing "Audio DMAC peri peri" part,
> and reg-name itself is missing at Document.
> This patch add these.
> 
> Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Reviewed-by: Simon Horman <horms+renesas@verge.net.au>

> ---
>  Documentation/devicetree/bindings/sound/renesas,rsnd.txt | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/sound/renesas,rsnd.txt b/Documentation/devicetree/bindings/sound/renesas,rsnd.txt
> index 648d43e..c58af45 100644
> --- a/Documentation/devicetree/bindings/sound/renesas,rsnd.txt
> +++ b/Documentation/devicetree/bindings/sound/renesas,rsnd.txt
> @@ -282,7 +282,10 @@ Required properties:
>  - reg				: Should contain the register physical address.
>  				  required register is
>  				   SRU/ADG/SSI      if generation1
> -				   SRU/ADG/SSIU/SSI if generation2
> +				   SRU/ADG/SSIU/SSI/AUDIO-DMAC-periperi if generation2/generation3
> +- reg-names			: Should contain the register names.
> +				   scu/adg/ssi	if generation1
> +				   scu/adg/ssiu/ssi/audmapp if generation2/generation3
>  - rcar_sound,ssi		: Should contain SSI feature.
>  				  The number of SSI subnode should be same as HW.
>  				  see below for detail.
> -- 
> 2.7.4
> 
