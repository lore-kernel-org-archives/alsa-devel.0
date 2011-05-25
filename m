From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoc: wm8731: fix wm8731_check_osc()
	connected condition
Date: Wed, 25 May 2011 23:01:14 +0800
Message-ID: <20110525150113.GC12816@opensource.wolfsonmicro.com>
References: <1306230657-28649-1-git-send-email-nicolas.ferre@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id EB35E103855
	for <alsa-devel@alsa-project.org>;
	Wed, 25 May 2011 17:01:19 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1306230657-28649-1-git-send-email-nicolas.ferre@atmel.com>
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
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

On Tue, May 24, 2011 at 11:50:57AM +0200, Nicolas Ferre wrote:
> The crystal oscillator is only enabled if the WM8731_SYSCLK_XTAL master clock
> is specified. Fix the connected() struct snd_soc_dapm_route function to take
> this into account. Oscillator is not enabled on machine that need it otherwise.

Appilied, thanks.
