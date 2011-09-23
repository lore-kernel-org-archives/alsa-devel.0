From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: twl6040: No need to read the INTID
	register
Date: Fri, 23 Sep 2011 11:55:17 +0100
Message-ID: <20110923105516.GI3165@opensource.wolfsonmicro.com>
References: <1316760722-27576-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 09A19103BA3
	for <alsa-devel@alsa-project.org>;
	Fri, 23 Sep 2011 12:55:18 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1316760722-27576-1-git-send-email-peter.ujfalusi@ti.com>
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
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>, Misael Lopez Cruz <misael.lopez@ti.com>
List-Id: alsa-devel@alsa-project.org

On Fri, Sep 23, 2011 at 09:52:02AM +0300, Peter Ujfalusi wrote:
> Since our irq handler has been called, it is granted, that
> the reason was either PLUGINT, or UNPLUGINT.
> The INTID register has been checked in the MFD part of
> twl6040 driver (twl6040-irq.c).
> We have no reason to read from chip again here.

Applied, thanks.
