From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] SMDK64XX I2S: Added machine driver for
	WM8580
Date: Fri, 18 Sep 2009 15:47:53 +0100
Message-ID: <20090918144752.GB2121@rakim.wolfsonmicro.main>
References: <1253232073-21717-1-git-send-email-jassisinghbrar@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id E7DCF2441E
	for <alsa-devel@alsa-project.org>;
	Fri, 18 Sep 2009 16:47:53 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1253232073-21717-1-git-send-email-jassisinghbrar@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: jassi brar <jassisinghbrar@gmail.com>
Cc: alsa-devel@alsa-project.org, Jassi <jassi.brar@samsung.com>, ben@trinity.fluff.org
List-Id: alsa-devel@alsa-project.org

On Fri, Sep 18, 2009 at 09:01:13AM +0900, jassi brar wrote:

> +	/* Currently, WM8580 driver doesn't support PLL-out rates
> +	 * other than those mentioned in Table-52 Page-58 of WM8580A
> +	 * manual. Some of these unavailable rates include

As discussed yesterday this comment is misleading; the driver has no
restrictions in it based on the example configurations listed in the
datasheet and there is no possibility of any future work in the driver
removing the restrictions that aren't present since the driver can't
make features available that aren't present in the hardware.
