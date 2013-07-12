From: Nicolin Chen <b42378@freescale.com>
Subject: Re: [PATCH] ASoC: fsl: Disable SSI in trigger() if
 RE/TE are both cleared
Date: Fri, 12 Jul 2013 12:09:31 +0800
Message-ID: <20130712040930.GB27823@MrMyself>
References: <1373453034-21618-1-git-send-email-b42378@freescale.com>
 <20130711165401.GU24508@sirena.org.uk> <51DEE810.3090304@tabi.org>
 <20130712035732.GA27823@MrMyself> <51DF7F4F.90707@tabi.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe003.messaging.microsoft.com [216.32.180.186])
 by alsa0.perex.cz (Postfix) with ESMTP id B3E79265912
 for <alsa-devel@alsa-project.org>; Fri, 12 Jul 2013 06:12:59 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <51DF7F4F.90707@tabi.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Timur Tabi <timur@tabi.org>
Cc: fabio.estevam@freescale.com, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, linuxppc-dev@lists.ozlabs.org, shawn.guo@linaro.org
List-Id: alsa-devel@alsa-project.org

On Thu, Jul 11, 2013 at 11:00:15PM -0500, Timur Tabi wrote:
> I definitely want to.  Unfortunately, I'm literally in the middle of
> moving into a new house, and so everything is packed up.  I won't be
> able to look at it for another week.

Oh, I see. Actually we've been using this patch for quite a while,
it should be okay.
And I still have some patches pending for the fsl_ssi.c, but looks
like it'll be better for me to wait after you settle down.

Hope everything will run smoothly during your house-moving.
