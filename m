From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH 2/2] ASoC: rsnd: explain extended Audio
 DMAC peri peri address
Date: Mon, 18 Mar 2019 11:38:18 +0100
Message-ID: <20190318103818.j22q6xly5fbgqeli@verge.net.au>
References: <87imwgye1k.wl-kuninori.morimoto.gx@renesas.com>
 <87ftrkye0f.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from kirsty.vergenet.net (kirsty.vergenet.net [202.4.237.240])
 by alsa1.perex.cz (Postfix) with ESMTP id AE687F8961A
 for <alsa-devel@alsa-project.org>; Mon, 18 Mar 2019 11:38:22 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <87ftrkye0f.wl-kuninori.morimoto.gx@renesas.com>
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

On Mon, Mar 18, 2019 at 02:11:34PM +0900, Kuninori Morimoto wrote:
> 
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> 
> If SoC has extended Audio DMAC peri peri address,
> DT needs to select it.
> Otherwise, it can select normal Audio DMAC peri peri address.
> Extended Audio DMAC peri peri address can use BUSIF4-7,
> normal address can't.
> 
> Reported-by: Jiada Wang <jiada_wang@mentor.com>
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Reviewed-by: Simon Horman <horms+renesas@verge.net.au>

> ---
>  Documentation/devicetree/bindings/sound/renesas,rsnd.txt | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/sound/renesas,rsnd.txt b/Documentation/devicetree/bindings/sound/renesas,rsnd.txt
> index c58af45..b34afa6 100644
> --- a/Documentation/devicetree/bindings/sound/renesas,rsnd.txt
> +++ b/Documentation/devicetree/bindings/sound/renesas,rsnd.txt
> @@ -283,6 +283,8 @@ Required properties:
>  				  required register is
>  				   SRU/ADG/SSI      if generation1
>  				   SRU/ADG/SSIU/SSI/AUDIO-DMAC-periperi if generation2/generation3
> +				   Select extended AUDIO-DMAC-periperi address if SoC has it,
> +				   otherwise select normal AUDIO-DMAC-periperi address.
>  - reg-names			: Should contain the register names.
>  				   scu/adg/ssi	if generation1
>  				   scu/adg/ssiu/ssi/audmapp if generation2/generation3
> -- 
> 2.7.4
> 
