From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: EP93xx: fixed LRCLK rate and DMA
 oper. in I2S code
Date: Mon, 17 Jan 2011 14:07:34 +0000
Message-ID: <20110117140734.GG21113@opensource.wolfsonmicro.com>
References: <1291809693.31916.2.camel@r60e>
	<20101208124637.GD16418@rakim.wolfsonmicro.main>
	<1295182085.15631.231.camel@r60e>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 6A219103832
	for <alsa-devel@alsa-project.org>; Mon, 17 Jan 2011 15:07:36 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1295182085.15631.231.camel@r60e>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Alexander <subaparts@yandex.ru>
Cc: alsa-devel@alsa-project.org, ryan@bluewatersys.com, linux-arm-kernel@lists.infradead.org, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

On Sun, Jan 16, 2011 at 03:48:05PM +0300, Alexander wrote:
> From: Alexander Sverdlin <subaparts@yandex.ru>
> 
> Changelog:
> 1. I2S module of EP93xx should be feed by 32bit DMA transfers. This is 
> hardware limitation and that's the way original Cirrus's driver worked.

Applied, thanks.
