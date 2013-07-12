From: Nicolin Chen <b42378@freescale.com>
Subject: Re: [PATCH] ASoC: fsl: Disable SSI in trigger() if
 RE/TE are both cleared
Date: Fri, 12 Jul 2013 12:19:45 +0800
Message-ID: <20130712041944.GA27906@MrMyself>
References: <1373453034-21618-1-git-send-email-b42378@freescale.com>
 <20130711165401.GU24508@sirena.org.uk> <51DEE810.3090304@tabi.org>
 <20130712035732.GA27823@MrMyself> <51DF7F4F.90707@tabi.org>
 <20130712040930.GB27823@MrMyself> <51DF826C.40208@tabi.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from co9outboundpool.messaging.microsoft.com
 (co9ehsobe004.messaging.microsoft.com [207.46.163.27])
 by alsa0.perex.cz (Postfix) with ESMTP id B26E626592B
 for <alsa-devel@alsa-project.org>; Fri, 12 Jul 2013 06:24:42 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <51DF826C.40208@tabi.org>
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

On Thu, Jul 11, 2013 at 11:13:32PM -0500, Timur Tabi wrote:
> Have you tested it on PowerPC?

Not actually. But I think it won't break the work flow since
the SSI modules on two platform should be literally identical.

But if you still have concern with it, you can ask Mark to wait
and test it later. I'm okay with your decision.

Thanks,
Nicolin Chen
