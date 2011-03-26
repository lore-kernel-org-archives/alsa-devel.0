From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH 3/3] ASoC: imx: remove superfluous code in
	imx-ssi.c
Date: Sat, 26 Mar 2011 11:42:29 +0000
Message-ID: <1301139749.3455.2.camel@odin>
References: <1301068306-11997-1-git-send-email-w.sang@pengutronix.de>
	<1301068306-11997-4-git-send-email-w.sang@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ww0-f51.google.com (mail-ww0-f51.google.com [74.125.82.51])
	by alsa0.perex.cz (Postfix) with ESMTP id E13A3103821
	for <alsa-devel@alsa-project.org>; Sat, 26 Mar 2011 12:42:32 +0100 (CET)
Received: by wwf26 with SMTP id 26so1249490wwf.20
	for <alsa-devel@alsa-project.org>; Sat, 26 Mar 2011 04:42:32 -0700 (PDT)
In-Reply-To: <1301068306-11997-4-git-send-email-w.sang@pengutronix.de>
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
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, Sascha Hauer <s.hauer@pengutronix.de>, Mark Brown <broonie@opensource.wolfsonmicro.com>, open list <linux-kernel@vger.kernel.org>, Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>, Timur Tabi <timur@freescale.com>
List-Id: alsa-devel@alsa-project.org

On Fri, 2011-03-25 at 16:51 +0100, Wolfram Sang wrote:
> Checking if IMX_SSI_DMA is set and then set it again is useless.
> 
> Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>

Acked-by: Liam Girdwood <lrg@ti.com>
