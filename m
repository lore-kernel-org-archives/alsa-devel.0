From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCHv2 3/4] ASoC: multi-component - S3C - Get
 original functionality
Date: Fri, 16 Jul 2010 09:52:53 +0100
Message-ID: <20100716085253.GG9082@rakim.wolfsonmicro.main>
References: <1279260977-18342-1-git-send-email-sw.youn@samsung.com>
	<1279261764-18500-1-git-send-email-sw.youn@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 7BFDC243B1
	for <alsa-devel@alsa-project.org>;
	Fri, 16 Jul 2010 10:52:54 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1279261764-18500-1-git-send-email-sw.youn@samsung.com>
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

On Fri, Jul 16, 2010 at 03:29:24PM +0900, Seungwhan Youn wrote:

> +
> +	unsigned long	base;

You can probably just read this out of the device directly in the core
code, but I'm not 100% sure that's actually a win since you wind up
needing to also read the device in the version-specific code so this is
OK.
