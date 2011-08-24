From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v2 1/1] ASoC: soc-core: check rate for
 symmetry only when pcm is active
Date: Wed, 24 Aug 2011 20:19:07 +0100
Message-ID: <20110824191906.GA21162@opensource.wolfsonmicro.com>
References: <1314183728-23627-1-git-send-email-b29396@freescale.com>
	<4E5520CE.60204@ti.com> <4E552F5F.9070801@metafoo.de>
	<20110824172703.GF16653@opensource.wolfsonmicro.com>
	<4E5548FF.1030709@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id C28CE2440C
	for <alsa-devel@alsa-project.org>;
	Wed, 24 Aug 2011 21:19:09 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <4E5548FF.1030709@metafoo.de>
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "w.sang@pengutronix.de" <w.sang@pengutronix.de>, Dong Aisheng <b29396@freescale.com>, Liam Girdwood <lrg@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: alsa-devel@alsa-project.org

On Wed, Aug 24, 2011 at 08:54:55PM +0200, Lars-Peter Clausen wrote:

> It should be sufficient to just store the rate for the cpu and codec DAI.
> Though the rate constraint should be applied if either the DAI or the link
> wants symmetric rates.

Yes, for the actual rate storage.
