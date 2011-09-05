From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 2/3] ASoC: Allow codecs to provide their
 own regmap configuration
Date: Mon, 5 Sep 2011 10:45:04 -0700
Message-ID: <20110905174503.GI3889@opensource.wolfsonmicro.com>
References: <1315228682-1097-1-git-send-email-lars@metafoo.de>
	<1315228682-1097-2-git-send-email-lars@metafoo.de>
	<20110905172916.GG3889@opensource.wolfsonmicro.com>
	<4E650A3A.5050807@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id F3C8D24364
	for <alsa-devel@alsa-project.org>;
	Mon,  5 Sep 2011 19:45:07 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <4E650A3A.5050807@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Scott Jiang <scott.jiang.linux@gmail.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, device-drivers-devel@blackfin.uclinux.org, uclinux-dist-devel@blackfin.uclinux.org, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Mon, Sep 05, 2011 at 07:43:22PM +0200, Lars-Peter Clausen wrote:

> I think it is useful, since we avoid duplicating that ugly switch statement
> and we also have to wrap regmap_write and regmap_read, duplicating that in each
> codec driver doesn't make sense.

When the CODEC drivers do the probe they should be setting the regmap up
in their individual bus probe functions so no switch statement.
