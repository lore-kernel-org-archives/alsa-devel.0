From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v7 1/3] ASoC: da7210: Add support for DAPM
Date: Fri, 21 Oct 2011 09:58:38 +0100
Message-ID: <20111021085838.GE3513@opensource.wolfsonmicro.com>
References: <1319119369.24621.84.camel@matrix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id EE6E3103A8A
	for <alsa-devel@alsa-project.org>;
	Fri, 21 Oct 2011 10:58:41 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1319119369.24621.84.camel@matrix>
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

On Thu, Oct 20, 2011 at 07:32:49PM +0530, Ashish Chavan wrote:
> This patch adds support for DAPM covering all inputs and outputs
> as well as ADC and DAC.

This patch doesn't apply against current code.

> +/*
> + * DAPM Controls
> + *
> + * Current DAPM implementation covers almost all codec components e.g. IOs,
> + * mixers, PGAs,ADC and DAC.

This explanation would better placed next to the code in the probe -
it's that code which looks out of place in a Linux driver.
