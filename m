From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v2 0/9] ASoC: OMAP machine driver cleanups
Date: Mon, 10 Oct 2011 16:18:24 +0100
Message-ID: <20111010151824.GA9895@opensource.wolfsonmicro.com>
References: <1318250056-26437-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 33249245A9
	for <alsa-devel@alsa-project.org>;
	Mon, 10 Oct 2011 17:18:29 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1318250056-26437-1-git-send-email-peter.ujfalusi@ti.com>
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
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Mon, Oct 10, 2011 at 03:34:07PM +0300, Peter Ujfalusi wrote:

> Some cleanups for the OMAP ASoC machine drivers:
> - do not call soc_dapm_sync from dai_link->init callback since it is useless
> - Convert drivers to use table based DAPM initialization
> - Remove dapm_enable_pin calls from dai_link->init callback since pins are
>   enabled by default

Applied all, thanks.
