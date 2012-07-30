From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 01/18] Documentation: Describe the ux500
 realated audio related DT nodes
Date: Mon, 30 Jul 2012 14:48:04 +0100
Message-ID: <20120730134804.GE4468@opensource.wolfsonmicro.com>
References: <1343393162-11938-1-git-send-email-lee.jones@linaro.org>
 <1343393162-11938-2-git-send-email-lee.jones@linaro.org>
 <20120729203106.GD4384@opensource.wolfsonmicro.com>
 <50163A09.8060203@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id AA6972652D5
 for <alsa-devel@alsa-project.org>; Mon, 30 Jul 2012 15:48:03 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <50163A09.8060203@linaro.org>
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

On Mon, Jul 30, 2012 at 08:38:49AM +0100, Lee Jones wrote:
> On 29/07/12 21:31, Mark Brown wrote:
> >On Fri, Jul 27, 2012 at 01:45:45PM +0100, Lee Jones wrote:

> >>+   - Machine Driver : "stericsson,snd-soc-mop500"
> >>+   - CPU-side DAI   : "stericsson,ux500-msp-i2s"
> >>+   - DMA (platform) : "stericsson,ux500-pcm"
> >>+   - Audio CODEC    : "stericsson,ab8500-codec"

> >What is this a binding document for?  It looks like the binding for a
> >machine driver...

> No, it's a binding document for all of the ux500 driver and CODEC
> blocks. Do you really want me to split it all up? I think the only
> component which could be sanely split-out is the ab8500-codec, which
> could (should?) live in [1].

Yes, of course!  Each device will have a separate binding with different
requirements.

> These properties are relevant for some, but not all of the
> components above, hence why the are listed at 'optional properties'.

Which is part of the problem here, it makes it much harder to tell what
you need to do for the individual devices.
