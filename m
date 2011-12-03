From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: kirkwood: Make
 SND_KIRKWOOD_SOC_OPENRD and SND_KIRKWOOD_SOC_T5325 depend on I2C
Date: Sat, 3 Dec 2011 11:03:47 +0000
Message-ID: <20111203110347.GB6043@opensource.wolfsonmicro.com>
References: <1322908705.17054.2.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 70DD0246BF
	for <alsa-devel@alsa-project.org>; Sat,  3 Dec 2011 12:58:50 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1322908705.17054.2.camel@phoenix>
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
Cc: Arnaud Patard <apatard@mandriva.com>, alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Sat, Dec 03, 2011 at 06:38:25PM +0800, Axel Lin wrote:
> SND_KIRKWOOD_SOC_T5325 selects SND_SOC_ALC5623, but SND_SOC_ALC5623 needs
> CONFIG_I2C. So we need to make SND_KIRKWOOD_SOC_T5325 depend on I2C,
> otherwise I got below build error if CONFIG_I2C is not selected.

Applied, thanks.
