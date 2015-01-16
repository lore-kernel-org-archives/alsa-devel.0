From: Jarkko Nikula <jarkko.nikula@bitmer.com>
Subject: Re: [PATCH] ASoC: omap-mcbsp: Correct CBM_CFS dai
 format configuration
Date: Fri, 16 Jan 2015 11:37:40 +0200
Message-ID: <20150116093740.GA9102@bitmer.com>
References: <1421400025-6374-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bitmer.com (bitmer.com [213.157.87.50])
 by alsa0.perex.cz (Postfix) with ESMTP id 60319261B02
 for <alsa-devel@alsa-project.org>; Fri, 16 Jan 2015 10:37:47 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1421400025-6374-1-git-send-email-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Fri, Jan 16, 2015 at 11:20:25AM +0200, Peter Ujfalusi wrote:
> We should select FSR also to be driven by McBSP, not only FSX.
> 
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> ---
> Clearly the CBM_CFS is not widely used with McBSP, this is why it has not been
> noticed I believe.
> 
> Peter
> 
>  sound/soc/omap/omap-mcbsp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
Acked-by: Jarkko Nikula <jarkko.nikula@bitmer.com> 
