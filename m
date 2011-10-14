From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v3 5/8] ASoC: da7210: Add support for ADC &
 DAC equalizers
Date: Fri, 14 Oct 2011 20:41:55 +0100
Message-ID: <20111014194155.GO2931@opensource.wolfsonmicro.com>
References: <1318590666.12107.524.camel@matrix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 505C324475
	for <alsa-devel@alsa-project.org>;
	Fri, 14 Oct 2011 21:41:57 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1318590666.12107.524.camel@matrix>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Ashish Chavan <ashish.chavan@kpitcummins.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, alsa-devel <alsa-devel@alsa-project.org>, lrg <lrg@ti.com>, "kuninori.morimoto.gx" <kuninori.morimoto.gx@renesas.com>, David Dajun Chen <david.chen@diasemi.com>
List-Id: alsa-devel@alsa-project.org

On Fri, Oct 14, 2011 at 04:41:06PM +0530, Ashish Chavan wrote:
> This patch adds support for ADC and DAC five band equalizers
> available on DA7210 codec.

This and some of the others just adding new controls are good but
depend on the DAPM patches which I didn't apply.  I'd suggest
reshuffling them earlier in the series.
