From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 2/3] ASoC: uda1380: Fix missed
 uda1380_reset call if pdata->gpio_power is a valid gpio
Date: Sun, 4 Dec 2011 13:02:34 +0000
Message-ID: <20111204130234.GB8461@sirena.org.uk>
References: <1322998520.12391.1.camel@phoenix>
	<1322998652.12391.3.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 76070244E4
	for <alsa-devel@alsa-project.org>; Sun,  4 Dec 2011 14:02:34 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1322998652.12391.3.camel@phoenix>
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
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Liam Girdwood <lrg@ti.com>, Philipp Zabel <philipp.zabel@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Sun, Dec 04, 2011 at 07:37:32PM +0800, Axel Lin wrote:
> Current code does not call uda1380_reset() in uda1380_probe() if
> pdata->gpio_power is a valid gpio. Fix it.

This doesn't look like a problem - what's happening is that when the
driver has control over the CODEC power it's powering it off which has
the effect of restoring the device to the power on defaults.  It only
needs to issue a reset if the device is powered up.
