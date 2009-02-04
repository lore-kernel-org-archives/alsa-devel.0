From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 2.6.30] ASoC: add additional controls to
	the CS4270	codec driver
Date: Wed, 4 Feb 2009 14:08:33 +0000
Message-ID: <20090204140832.GA27713@rakim.wolfsonmicro.main>
References: <1233680972-1443-1-git-send-email-timur@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id D82401038BF
	for <alsa-devel@alsa-project.org>; Wed,  4 Feb 2009 15:08:34 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1233680972-1443-1-git-send-email-timur@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Timur Tabi <timur@freescale.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, Feb 03, 2009 at 11:09:32AM -0600, Timur Tabi wrote:

> Remove CONFIG_SND_SOC_CS4270_HWMUTE and always allow ASoC to control the mute
> bits.  The driver previously and erroneously assumed that these bits
> control only external muting circuitry, but they also control internal
> muting circuitry, so they should always be used.

As discussed I'm holding off on this until the I2C folks decide what to
do about the signal handling issue you found on teardown.
