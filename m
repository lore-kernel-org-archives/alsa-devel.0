From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/3] mfd: arizona: Add support for CS47L24
Date: Wed, 12 Nov 2014 09:34:04 +0000
Message-ID: <20141112093404.GC23178@opensource.wolfsonmicro.com>
References: <20141111165227.GA24344@opensource.wolfsonmicro.com>
 <20141111170319.GA25738@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 4E75D26530C
 for <alsa-devel@alsa-project.org>; Wed, 12 Nov 2014 10:34:05 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20141111170319.GA25738@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Cc: gnurou@gmail.com, alsa-devel@alsa-project.org, tiwai@suse.de, linux-kernel@vger.kernel.org, linus.walleij@linaro.org, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com, linux-gpio@vger.kernel.org, broonie@kernel.org, lee.jones@linaro.org
List-Id: alsa-devel@alsa-project.org

On Tue, Nov 11, 2014 at 05:03:19PM +0000, Richard Fitzgerald wrote:
> Signed-off-by: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
> ---
>  drivers/mfd/Kconfig              |    6 +
>  drivers/mfd/Makefile             |    3 +
>  drivers/mfd/arizona-core.c       |   91 ++-
>  drivers/mfd/arizona-irq.c        |   42 +-
>  drivers/mfd/arizona-spi.c        |    9 +
>  drivers/mfd/arizona.h            |    5 +
>  drivers/mfd/cs47l24-tables.c     | 1632 ++++++++++++++++++++++++++++++++++++++
>  include/linux/mfd/arizona/core.h |    4 +
>  8 files changed, 1765 insertions(+), 27 deletions(-)
>  create mode 100644 drivers/mfd/cs47l24-tables.c

Its worth noting this patch chain depends on the three MFD
patches Lee merged the other day from me so it would probably
make sense to push the whole series through the MFD tree if
possible.

Thanks,
Charles
