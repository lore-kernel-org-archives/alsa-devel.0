From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] ASoC: rsnd: Document R-Car M3-N support
Date: Thu, 26 Jul 2018 15:14:25 +0200
Message-ID: <20180726131424.4k76bfw5pnkmpvqz@verge.net.au>
References: <1532551215-14868-1-git-send-email-ykaneko0929@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from kirsty.vergenet.net (kirsty.vergenet.net [202.4.237.240])
 by alsa0.perex.cz (Postfix) with ESMTP id 3781D26776E
 for <alsa-devel@alsa-project.org>; Thu, 26 Jul 2018 15:14:32 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1532551215-14868-1-git-send-email-ykaneko0929@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Yoshihiro Kaneko <ykaneko0929@gmail.com>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Magnus Damm <magnus.damm@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, linux-renesas-soc@vger.kernel.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

On Thu, Jul 26, 2018 at 05:40:15AM +0900, Yoshihiro Kaneko wrote:
> From: Hiroyuki Yokoyama <hiroyuki.yokoyama.vx@renesas.com>
> 
> Document support for the sound modules in the Renesas M3-N (r8a77965)
> SoC.
> 
> No driver update is needed.
> 
> Signed-off-by: Hiroyuki Yokoyama <hiroyuki.yokoyama.vx@renesas.com>
> Signed-off-by: Yoshihiro Kaneko <ykaneko0929@gmail.com>

Reviewed-by: Simon Horman <horms+renesas@verge.net.au>

> ---
> 
> This patch is based on the devel branch of Simon Horman's renesas tree.
> 
>  Documentation/devicetree/bindings/sound/renesas,rsnd.txt | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/sound/renesas,rsnd.txt b/Documentation/devicetree/bindings/sound/renesas,rsnd.txt
> index b86d790..9e764270 100644
> --- a/Documentation/devicetree/bindings/sound/renesas,rsnd.txt
> +++ b/Documentation/devicetree/bindings/sound/renesas,rsnd.txt
> @@ -352,6 +352,7 @@ Required properties:
>  				    - "renesas,rcar_sound-r8a7794" (R-Car E2)
>  				    - "renesas,rcar_sound-r8a7795" (R-Car H3)
>  				    - "renesas,rcar_sound-r8a7796" (R-Car M3-W)
> +				    - "renesas,rcar_sound-r8a77965" (R-Car M3-N)
>  - reg				: Should contain the register physical address.
>  				  required register is
>  				   SRU/ADG/SSI      if generation1
> -- 
> 1.9.1
> 
