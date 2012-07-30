From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 05/18] ASoC: Ux500: Enable ux500 MSP driver
 for Device Tree
Date: Mon, 30 Jul 2012 16:01:30 +0100
Message-ID: <20120730150129.GF4468@opensource.wolfsonmicro.com>
References: <1343393162-11938-1-git-send-email-lee.jones@linaro.org>
 <1343393162-11938-6-git-send-email-lee.jones@linaro.org>
 <20120729204218.GI4384@opensource.wolfsonmicro.com>
 <50162F70.2050900@linaro.org>
 <20120730133930.GB4468@opensource.wolfsonmicro.com>
 <501692B8.6050102@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 45BC72652BD
 for <alsa-devel@alsa-project.org>; Mon, 30 Jul 2012 17:01:29 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <501692B8.6050102@linaro.org>
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

On Mon, Jul 30, 2012 at 02:57:12PM +0100, Lee Jones wrote:
> On 30/07/12 14:39, Mark Brown wrote:

> >Why does the driver care - doesn't the pinctrl abstraction and/or
> >bindings handle this sensibly?

> Not when I tested it. pinctrl_get() came back !IS_ERR() for MSP0,
> MSP2 & MSP3, then when it went on to pinctrl_lookup_state(), only
> then did it fail. Would it be more sane to retract the error
> messages and just let it fail silently? It's either that or have
> lots of "could not get MSP defstate" clogging up the log.

This sounds to me like we should be ensuring that there's a single
fixed state available for these MSPs (representing the fact that the
pins are always in the right mode) in the pinctrl bindings.

As with several of other changes for this platform it seems like we need
to think carefully about the abstraction level we're working at.
