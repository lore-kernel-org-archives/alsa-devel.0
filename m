From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v2 3/5] ASoC: twl6040: Do not use wrapper
	for irq request
Date: Tue, 5 Jul 2011 10:59:20 -0700
Message-ID: <20110705175919.GA6238@opensource.wolfsonmicro.com>
References: <1309873775-17927-1-git-send-email-peter.ujfalusi@ti.com>
	<1309873775-17927-4-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 34EC5103843
	for <alsa-devel@alsa-project.org>;
	Tue,  5 Jul 2011 19:59:24 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1309873775-17927-4-git-send-email-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: alsa-devel@alsa-project.org, Samuel Ortiz <sameo@linux.intel.com>, Tony Lindgren <tony@atomide.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-kernel@vger.kernel.org, Felipe Balbi <balbi@ti.com>, Misael Lopez Cruz <misael.lopez@ti.com>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Tue, Jul 05, 2011 at 04:49:33PM +0300, Peter Ujfalusi wrote:
> The twl6040_request_irq/free_irq inline functions are going
> to be removed, so replace them with direct calls.
> The irq number is provided by the core driver via resource.
> 
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>

Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
