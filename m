From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: wm8731: set the ACTIVE bit if bias
	ON entered
Date: Fri, 1 Jul 2011 09:15:07 -0700
Message-ID: <20110701161506.GC23784@opensource.wolfsonmicro.com>
References: <ccd4b125244271af7978948689cf1dcef37bc06b.1309368631.git.nicolas.ferre@atmel.com>
	<1309517034-26110-1-git-send-email-nicolas.ferre@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id B1EAB247AF
	for <alsa-devel@alsa-project.org>;
	Fri,  1 Jul 2011 18:15:09 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1309517034-26110-1-git-send-email-nicolas.ferre@atmel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Nicolas Ferre <nicolas.ferre@atmel.com>
Cc: alsa-devel@alsa-project.org, lrg@ti.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Fri, Jul 01, 2011 at 12:43:54PM +0200, Nicolas Ferre wrote:
> Resuming from a suspend/resume cycle, the ACTIVE bit was not set even if a
> stream had actually been processing.
> Setting this bit at entering SND_SOC_BIAS_ON level will ensure this.

This will set the bit even for analogue bypass paths which don't need
it.  I'd suggest making the active bit a supply widget supplying the DAC
and ADC rather than something open coded, that should do the right thing
I think.
