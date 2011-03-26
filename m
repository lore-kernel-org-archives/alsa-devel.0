From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH 1/3] ASoC: imx: set watermarks for mx2-dma
Date: Sat, 26 Mar 2011 11:42:04 +0000
Message-ID: <1301139725.3455.0.camel@odin>
References: <1301068306-11997-1-git-send-email-w.sang@pengutronix.de>
	<1301068306-11997-2-git-send-email-w.sang@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ww0-f41.google.com (mail-ww0-f41.google.com [74.125.82.41])
	by alsa0.perex.cz (Postfix) with ESMTP id 8396624549
	for <alsa-devel@alsa-project.org>; Sat, 26 Mar 2011 12:42:10 +0100 (CET)
Received: by wwi18 with SMTP id 18so344326wwi.2
	for <alsa-devel@alsa-project.org>; Sat, 26 Mar 2011 04:42:10 -0700 (PDT)
In-Reply-To: <1301068306-11997-2-git-send-email-w.sang@pengutronix.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Wolfram Sang <w.sang@pengutronix.de>
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, Sascha Hauer <s.hauer@pengutronix.de>, Mark Brown <broonie@opensource.wolfsonmicro.com>, open list <linux-kernel@vger.kernel.org>, Timur Tabi <timur@freescale.com>
List-Id: alsa-devel@alsa-project.org

On Fri, 2011-03-25 at 16:51 +0100, Wolfram Sang wrote:
> They got accidently removed by f0fba2a (ASoC: multi-component - ASoC
> Multi-Component Support). Reintroduce them and get rid of the
> superfluous defines because the fiq-driver has its own hardcoded values.
> 
> Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
> ---

Acked-by: Liam Girdwood <lrg@ti.com>
