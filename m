From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: Add jack_status_check callback
	function
Date: Thu, 12 Nov 2009 15:38:40 +0000
Message-ID: <20091112153840.GB24874@rakim.wolfsonmicro.main>
References: <4AFBC3CC.9070906@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 02B481037F2
	for <alsa-devel@alsa-project.org>; Thu, 12 Nov 2009 16:38:42 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <4AFBC3CC.9070906@samsung.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Joonyoung Shim <jy0922.shim@samsung.com>
Cc: alsa-devel@alsa-project.org, kyungmin.park@samsung.com
List-Id: alsa-devel@alsa-project.org

On Thu, Nov 12, 2009 at 05:14:04PM +0900, Joonyoung Shim wrote:
> The jack_status_check callback function is the interface to check the
> status of the jack. Some target provides the method to distinguish what
> is the jack inserted - headphone jack, microphone jack, tvout jack, etc,
> so we can implement it using the jack_status_check function.

Applied, thanks.  

Obviously with some jack detection methods you'd just be using multiple
GPIOs but that's not going to work for everything.  If someone needs
platform data of some kind passing into the jack that could be added
later.
