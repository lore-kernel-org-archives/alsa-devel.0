From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 13/18] ARM: ux500: Add ux500 PCM to DB8500
	Device Tree
Date: Sun, 29 Jul 2012 21:50:02 +0100
Message-ID: <20120729205001.GK4384@opensource.wolfsonmicro.com>
References: <1343393162-11938-1-git-send-email-lee.jones@linaro.org>
 <1343393162-11938-14-git-send-email-lee.jones@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 5C77A26525E
 for <alsa-devel@alsa-project.org>; Sun, 29 Jul 2012 22:50:01 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1343393162-11938-14-git-send-email-lee.jones@linaro.org>
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

On Fri, Jul 27, 2012 at 01:45:57PM +0100, Lee Jones wrote:
> Nothing special here. We're only providing a compatible string
> to ensure the driver is probed using a Device Tree boot.

> +		pcm: ux500-pcm {
> +			compatible = "stericsson,ux500-pcm";
> +		};
> +

One of two things is wrong here.  Either you've not provided any
information about the hardware so the driver won't be able to work out
what to talk to or you've not provided any data so you're registering a
purely virtual Linux-internal device via the device tree.

Once more, the idea here is to describe the hardware not to dump Linux's
internal data structures into the device tree.
