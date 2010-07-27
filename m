From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/2] ASoC: tlv320dac33: Revisit the FIFO
	Mode1 handling
Date: Tue, 27 Jul 2010 09:32:44 -0700
Message-ID: <20100727163243.GA18884@opensource.wolfsonmicro.com>
References: <1280213177-15439-1-git-send-email-peter.ujfalusi@nokia.com>
	<1280213177-15439-2-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 7A7B9103807
	for <alsa-devel@alsa-project.org>;
	Tue, 27 Jul 2010 18:32:33 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1280213177-15439-2-git-send-email-peter.ujfalusi@nokia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Cc: alsa-devel@alsa-project.org, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

On Tue, Jul 27, 2010 at 09:46:16AM +0300, Peter Ujfalusi wrote:
> Replace the hardwired latency definition with platform data
> parameter, and simplify the nSample parameter calculation.
> 
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>

Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

I did notice that the default changes from 20ms:

> -#define LATENCY_TIME_MS		20

> +	if (!dac33->mode1_i2c_latency)
> +		dac33->mode1_i2c_latency = 10000; /* 10ms */

to 10ms with the new code but that shouldn't be a problem.
