From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH] ASoC: omap-pcm: Period wakeup disabling on
 OMAP2+
Date: Fri, 13 May 2011 13:16:47 +0100
Message-ID: <1305289007.3202.2.camel@odin>
References: <1305194695-4425-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f51.google.com (mail-ew0-f51.google.com
	[209.85.215.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 29F32103843
	for <alsa-devel@alsa-project.org>;
	Fri, 13 May 2011 14:16:52 +0200 (CEST)
Received: by ewy6 with SMTP id 6so742681ewy.38
	for <alsa-devel@alsa-project.org>; Fri, 13 May 2011 05:16:51 -0700 (PDT)
In-Reply-To: <1305194695-4425-1-git-send-email-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On Thu, 2011-05-12 at 13:04 +0300, Peter Ujfalusi wrote:
> Allow disabling ALSA period wakeup interrupts.
> This can only be done on OMAP2+ (2/3/4), since there
> we can chain the DMA.
> 
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> ---
> 

Applied.

Thanks

Liam
