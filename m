From: Jarkko Nikula <jarkko.nikula@bitmer.com>
Subject: Re: [PATCH] ASoC: omap: Make RX51 depend on GPIOLIB
 due to jack usage
Date: Tue, 21 Jan 2014 08:45:42 +0200
Message-ID: <20140121064542.GA3935@bitmer.com>
References: <1390258801-26986-1-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bitmer.com (bitmer.com [213.157.87.50])
 by alsa0.perex.cz (Postfix) with ESMTP id 75ADC261B18
 for <alsa-devel@alsa-project.org>; Tue, 21 Jan 2014 07:45:53 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1390258801-26986-1-git-send-email-broonie@kernel.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, linaro-kernel@lists.linaro.org, Russell King - ARM Linux <linux@arm.linux.org.uk>, Mark Brown <broonie@linaro.org>, Liam Girdwood <lgirdwood@gmail.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>
List-Id: alsa-devel@alsa-project.org

On Mon, Jan 20, 2014 at 11:00:01PM +0000, Mark Brown wrote:
> From: Mark Brown <broonie@linaro.org>
> 
> Since the GPIO jacks are only supported if gpiolib is built and fail to
> compile otherwise add a build depedency.  This is unlikely to have any
> practical impact outside of coverage testing.
> 
> Reported-by: Russell King <linux@arm.linux.org.uk>
> Signed-off-by: Mark Brown <broonie@linaro.org>
> ---
>  sound/soc/omap/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>
Acked-by: Jarkko Nikula <jarkko.nikula@bitmer.com> 
