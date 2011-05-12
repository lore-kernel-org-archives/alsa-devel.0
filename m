From: Jarkko Nikula <jhnikula@gmail.com>
Subject: Re: [PATCH] ASoC: omap-pcm: Period wakeup disabling on
	OMAP2+
Date: Thu, 12 May 2011 13:24:42 +0300
Message-ID: <20110512132442.b2c293f0.jhnikula@gmail.com>
References: <1305194695-4425-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ey0-f179.google.com (mail-ey0-f179.google.com
	[209.85.215.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 2076910381E
	for <alsa-devel@alsa-project.org>;
	Thu, 12 May 2011 12:23:46 +0200 (CEST)
Received: by eyg5 with SMTP id 5so415076eyg.38
	for <alsa-devel@alsa-project.org>; Thu, 12 May 2011 03:23:45 -0700 (PDT)
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
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Thu, 12 May 2011 13:04:55 +0300
Peter Ujfalusi <peter.ujfalusi@ti.com> wrote:

> Allow disabling ALSA period wakeup interrupts.
> This can only be done on OMAP2+ (2/3/4), since there
> we can chain the DMA.
> 
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> ---

Acked-by: Jarkko Nikula <jhnikula@gmail.com>
