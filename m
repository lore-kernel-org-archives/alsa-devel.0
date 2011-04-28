From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] audio: tlv320aic26: fix PLL register
	configuration
Date: Thu, 28 Apr 2011 22:56:39 +0100
Message-ID: <20110428215639.GB19535@opensource.wolfsonmicro.com>
References: <1304026377-21829-1-git-send-email-michael.williamson@criticallink.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 41D95243FA
	for <alsa-devel@alsa-project.org>;
	Thu, 28 Apr 2011 23:56:33 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1304026377-21829-1-git-send-email-michael.williamson@criticallink.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Michael Williamson <michael.williamson@criticallink.com>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

On Thu, Apr 28, 2011 at 05:32:57PM -0400, Michael Williamson wrote:

> -	jval = (fsref == 44100) ? 7 : 8;
> -	dval = (fsref == 44100) ? 5264 : 1920;
> +	jval = fsref / (aic26->mclk / 2048);
> +	dval = fsref - jval * (aic26->mclk / 2048);

I'd like some more brackets on this line, especially given the
similarity with the previous line.  Otherwise this looks fine if a bit
magic:

Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
