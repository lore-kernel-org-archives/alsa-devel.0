From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 2/3] ASoC: multi-component - Modify to use
 common S3C I2S features
Date: Thu, 15 Jul 2010 10:32:21 +0100
Message-ID: <20100715093220.GE23529@rakim.wolfsonmicro.main>
References: <lrg@slimlogic.co.uk> <broonie@opensource.wolfsonmicro.com>
	<jassisinghbrar@gmail.com> <claude.youn@gmail.com>
	<1279184328-31746-1-git-send-email-sw.youn@samsung.com>
	<1279184328-31746-2-git-send-email-sw.youn@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 2684C1037FF
	for <alsa-devel@alsa-project.org>;
	Thu, 15 Jul 2010 11:32:22 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1279184328-31746-2-git-send-email-sw.youn@samsung.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Seungwhan Youn <sw.youn@samsung.com>
Cc: alsa-devel@alsa-project.org, Jassi Brar <jassisinghbrar@gmail.com>, Seungwhan Youn <claude.youn@gmail.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Thu, Jul 15, 2010 at 05:58:47PM +0900, Seungwhan Youn wrote:

> +	i2s->base = S3C64XX_PA_IISV4;
> +

I'd really expect this to be being pulled from the resources for the
platform device for the DAI rather than hard coded into the driver.  If
we're going to start reorganising things like this and touching all the
drivers it'd seem better to go straight to doing that rather than
introducing this approach.
