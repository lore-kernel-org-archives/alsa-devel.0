From: Timur Tabi <timur@tabi.org>
Subject: Re: [PATCH 1/2] ASoC: fsl: fsl_dma: Use true/false for
	boolean init
Date: Sat, 09 May 2015 10:47:44 -0500
Message-ID: <554E2C20.10501@tabi.org>
References: <1431186353-7331-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from muin.pair.com (muin.pair.com [209.68.1.55])
 by alsa0.perex.cz (Postfix) with ESMTP id 29403260517
 for <alsa-devel@alsa-project.org>; Sat,  9 May 2015 17:47:47 +0200 (CEST)
In-Reply-To: <1431186353-7331-1-git-send-email-festevam@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Fabio Estevam <festevam@gmail.com>, broonie@kernel.org
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Fabio Estevam wrote:
> From: Fabio Estevam<fabio.estevam@freescale.com>
>
> Bool initializations should use true and false.  Bool tests don't need
> comparisons.  Based on contributions from Joe Perches, Rusty Russell
> and Bruce W Allan.
>
> The semantic patch that makes this change is available
> in scripts/coccinelle/misc/boolinit.cocci.
>
> More information about semantic patching is available at
> http://coccinelle.lip6.fr/
>
> Signed-off-by: Fabio Estevam<fabio.estevam@freescale.com>

Acked-by: Timur Tabi <timur@tabi.org>
