From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [PATCH] ASoC: pxa-ssp: Don't use
	SSCR0_SerClkDiv	and SSCR0_SCR
Date: Fri, 17 Apr 2009 11:22:58 +0100
Message-ID: <20090417102257.GA10992@sirena.org.uk>
References: <1239961178-19122-1-git-send-email-philipp.zabel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 23A63243C8
	for <alsa-devel@alsa-project.org>;
	Fri, 17 Apr 2009 12:22:59 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1239961178-19122-1-git-send-email-philipp.zabel@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Philipp Zabel <philipp.zabel@gmail.com>
Cc: alsa-devel@alsa-project.org, Eric Miao <eric.miao@marvell.com>
List-Id: alsa-devel@alsa-project.org

On Fri, Apr 17, 2009 at 11:39:38AM +0200, Philipp Zabel wrote:

> To me, using ssp_dev seems to be cleaner, as all the places where
> ssp_set_scr is called, we already have an ssp_dev *ssp = priv->dev.ssp
> set up, which allows us to call ssp_set_scr(ssp, ...) instead of
> ssp_set_scr(&priv->dev, ...). Same for ssp_get_scr.

Yeah, the combination of ssp_dev and ssp_device is icky in general and
largely historical as a result of a partially done transition of the
driver to ssp_device.

I'll apply the patch - thanks!
