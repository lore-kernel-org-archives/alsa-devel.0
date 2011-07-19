From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/3] ASoC: sgtl5000: refactor registering
	internal ldo
Date: Tue, 19 Jul 2011 16:20:31 +0100
Message-ID: <20110719152030.GH9652@opensource.wolfsonmicro.com>
References: <1311004385-14554-1-git-send-email-w.sang@pengutronix.de>
	<1311004385-14554-2-git-send-email-w.sang@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 397D024571
	for <alsa-devel@alsa-project.org>;
	Tue, 19 Jul 2011 17:20:34 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1311004385-14554-2-git-send-email-w.sang@pengutronix.de>
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
Cc: alsa-devel@alsa-project.org, Dong Aisheng <b29396@freescale.com>, Zeng Zhaoming <b32542@freescale.com>
List-Id: alsa-devel@alsa-project.org

On Mon, Jul 18, 2011 at 05:53:03PM +0200, Wolfram Sang wrote:
> The code for registering the internal ldo was present twice. Turn it
> into a function instead. Also, inform the user if LDO is used now.

Applied, thanks.
