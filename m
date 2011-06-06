From: Liam Girdwood <lrg@ti.com>
Subject: Re: [PATCH] ASoC: Allow WM8915 BCLK calculation
	outside hw_params()
Date: Mon, 6 Jun 2011 20:36:18 +0100
Message-ID: <4DED2C32.8030908@ti.com>
References: <1307384464-24522-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from comal.ext.ti.com (comal.ext.ti.com [198.47.26.152])
	by alsa0.perex.cz (Postfix) with ESMTP id BA1B7243BA
	for <alsa-devel@alsa-project.org>;
	Mon,  6 Jun 2011 21:36:23 +0200 (CEST)
In-Reply-To: <1307384464-24522-1-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "patches@opensource.wolfsonmicro.com" <patches@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On 06/06/11 19:21, Mark Brown wrote:
> Allow more dynamic management of the device clocking by allowing BCLK to
> be calculated when we set SYSCLK. This means that if the system is idle
> when hw_params() runs then we don't try to use the SYSCLK used in that case
> to set up the BCLK dividers, we can instead wait until a later point such
> as bias level configuration. This makes it easier to manage low power modes.
> 
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

Acked-by: Liam Girdwood <lrg@ti.com>
