From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH 2/3] ASoC: imx: fix burstsize for DMA
Date: Sat, 26 Mar 2011 11:42:20 +0000
Message-ID: <1301139740.3455.1.camel@odin>
References: <1301068306-11997-1-git-send-email-w.sang@pengutronix.de>
	<1301068306-11997-3-git-send-email-w.sang@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179])
	by alsa0.perex.cz (Postfix) with ESMTP id DCC02103821
	for <alsa-devel@alsa-project.org>; Sat, 26 Mar 2011 12:42:26 +0100 (CET)
Received: by wyg36 with SMTP id 36so1217010wyg.38
	for <alsa-devel@alsa-project.org>; Sat, 26 Mar 2011 04:42:26 -0700 (PDT)
In-Reply-To: <1301068306-11997-3-git-send-email-w.sang@pengutronix.de>
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
> SSI counts in words, the DMA engine in bytes. (Wrong) factor got removed
> in bf974a0 (ASoC i.MX: switch to new DMA api).
> 
> Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>

Acked-by: Liam Girdwood <lrg@ti.com>
