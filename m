From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ALSA: ASoC: cs4270: move power management
 hooks to snd_soc_codec_device
Date: Wed, 5 Aug 2009 19:37:00 +0100
Message-ID: <20090805183700.GA6727@rakim.wolfsonmicro.main>
References: <1249497036-9073-1-git-send-email-daniel@caiaq.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 8D6C124578
	for <alsa-devel@alsa-project.org>;
	Wed,  5 Aug 2009 20:37:01 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1249497036-9073-1-git-send-email-daniel@caiaq.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <daniel@caiaq.de>
Cc: alsa-devel@alsa-project.org, Timur Tabi <timur@freescale.com>
List-Id: alsa-devel@alsa-project.org

On Wed, Aug 05, 2009 at 08:30:36PM +0200, Daniel Mack wrote:
> Power management for the cs4270 codec is currently implemented as part
> of the i2c_driver struct. The disadvantage of doing it this way is that
> the callbacks registered in the snd_soc_card struct are called _before_
> the codec's callbacks.

> That doesn't work, because the snd_soc_card callbacks will most likely
> switch down the codec's power domains or pull the reset GPIOs, and
> hence make the i2c communication bail out.

> Fix this by binding the suspend and resume code to the
> snd_soc_codec_device driver model.

You should leave the suspend and resume functions for I2C but have them
call the snd_soc_suspend_device() and snd_soc_resume_device() callbacks
in the core (which do nothing but will in future ensure that the entire
card goes down when one of the components goes down to make sure we are
always able to communicate with all the card components).   The actual
suspend and resume actions should be moved as you have done.
