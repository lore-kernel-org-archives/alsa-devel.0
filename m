From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH] ASoC: rsnd: Document R-Car M3-W support
Date: Sun, 18 Mar 2018 07:52:54 -0500
Message-ID: <20180318033451.d4ejjp34k6udgvex@rob-hp-laptop>
References: <1521208785-5698-1-git-send-email-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pf0-f194.google.com (mail-pf0-f194.google.com
 [209.85.192.194])
 by alsa0.perex.cz (Postfix) with ESMTP id BF35F266F1C
 for <alsa-devel@alsa-project.org>; Sun, 18 Mar 2018 13:52:58 +0100 (CET)
Received: by mail-pf0-f194.google.com with SMTP id a16so5953898pfn.9
 for <alsa-devel@alsa-project.org>; Sun, 18 Mar 2018 05:52:58 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1521208785-5698-1-git-send-email-geert+renesas@glider.be>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Liam Girdwood <lgirdwood@gmail.com>, linux-renesas-soc@vger.kernel.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

On Fri, Mar 16, 2018 at 02:59:45PM +0100, Geert Uytterhoeven wrote:
> Document support for the sound modules in the Renesas M3-W (r8a7796)
> SoC.
> 
> No driver update is needed.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> "renesas,rcar_sound-r8a7796" has been in use since quite a while, but
> the binding update was still missing.
> ---
>  Documentation/devicetree/bindings/sound/renesas,rsnd.txt | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Rob Herring <robh@kernel.org>
