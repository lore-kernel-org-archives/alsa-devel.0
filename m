From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: Make SND_SOC_MX27VIS_AIC32X4 depend
	on I2C
Date: Sun, 4 Dec 2011 23:40:03 +0000
Message-ID: <20111204234000.GB4346@opensource.wolfsonmicro.com>
References: <1322986276.22605.2.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 0EBB910394A
	for <alsa-devel@alsa-project.org>; Mon,  5 Dec 2011 00:40:06 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1322986276.22605.2.camel@phoenix>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Axel Lin <axel.lin@gmail.com>
Cc: Arnaud Patard <arnaud.patard@rtp-net.org>, alsa-devel@alsa-project.org, Sascha Hauer <s.hauer@pengutronix.de>, Eric =?iso-8859-1?Q?B=E9nard?= <eric@eukrea.com>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Sun, Dec 04, 2011 at 04:11:16PM +0800, Axel Lin wrote:
> SND_SOC_MX27VIS_AIC32X4 selects SND_SOC_TLV320AIC32X4,
> but SND_SOC_TLV320AIC32X4 needs CONFIG_I2C.
> So we need to make SND_SOC_MX27VIS_AIC32X4 depend on I2C.
> otherwise I got below build error if CONFIG_I2C is not selected.

Applied, thanks.
