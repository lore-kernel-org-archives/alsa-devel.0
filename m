From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 05/18] ASoC: Ux500: Enable ux500 MSP driver
 for Device Tree
Date: Sun, 29 Jul 2012 21:42:18 +0100
Message-ID: <20120729204218.GI4384@opensource.wolfsonmicro.com>
References: <1343393162-11938-1-git-send-email-lee.jones@linaro.org>
 <1343393162-11938-6-git-send-email-lee.jones@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id F12E026031B
 for <alsa-devel@alsa-project.org>; Sun, 29 Jul 2012 22:42:17 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1343393162-11938-6-git-send-email-lee.jones@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lee Jones <lee.jones@linaro.org>
Cc: ola.o.lilja@stericsson.com, alsa-devel@alsa-project.org, linus.walleij@stericsson.com, arnd@arndb.de, olalilja@yahoo.se, linux-kernel@vger.kernel.org, STEricsson_nomadik_linux@list.st.com, lrg@ti.com, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

On Fri, Jul 27, 2012 at 01:45:49PM +0100, Lee Jones wrote:

> +	if (of_get_property(np, "stericsson,use-pinctrl", NULL))
> +		msp->use_pinctrl = true;
> +	else
> +		msp->use_pinctrl = false;

I don't recall seeing any response to my query about this on the first
iteration.  Please don't just ignore review comments.
