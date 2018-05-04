From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 3/4] ASoC: wm8960: Make the node name
	generic
Date: Fri, 4 May 2018 17:25:07 -0500
Message-ID: <20180504222507.GC13133@rob-hp-laptop>
References: <1525461123-16686-1-git-send-email-festevam@gmail.com>
 <1525461123-16686-3-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-oi0-f67.google.com (mail-oi0-f67.google.com
 [209.85.218.67])
 by alsa0.perex.cz (Postfix) with ESMTP id D870F2675D4
 for <alsa-devel@alsa-project.org>; Sat,  5 May 2018 00:25:09 +0200 (CEST)
Received: by mail-oi0-f67.google.com with SMTP id w123-v6so11500411oia.4
 for <alsa-devel@alsa-project.org>; Fri, 04 May 2018 15:25:09 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1525461123-16686-3-git-send-email-festevam@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Fabio Estevam <festevam@gmail.com>
Cc: Fabio Estevam <fabio.estevam@nxp.com>, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

On Fri, May 04, 2018 at 04:12:02PM -0300, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@nxp.com>
> 
> According to Devicetree Specification v0.2 document:
> 
> "The name of a node should be somewhat generic, reflecting the function
> of the device and not its precise programming model."
> 
> Do as suggested in the binding example.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
> ---
>  Documentation/devicetree/bindings/sound/wm8960.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/sound/wm8960.txt b/Documentation/devicetree/bindings/sound/wm8960.txt
> index 2deb8a3..6d29ac3 100644
> --- a/Documentation/devicetree/bindings/sound/wm8960.txt
> +++ b/Documentation/devicetree/bindings/sound/wm8960.txt
> @@ -23,7 +23,7 @@ Optional properties:

Applied.
