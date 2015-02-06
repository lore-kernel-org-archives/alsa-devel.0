From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH v2 0/3] Switch to ioremap_wc in the SRAM allocator code
Date: Fri, 6 Feb 2015 15:44:11 +0000
Message-ID: <20150206154411.GF23190@e104818-lin.cambridge.arm.com>
References: <1423230328-6721-1-git-send-email-a.kesavan@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1423230328-6721-1-git-send-email-a.kesavan@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Abhilash Kesavan <a.kesavan@samsung.com>
Cc: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "hirokazu.takata.wj@renesas.com" <hirokazu.takata.wj@renesas.com>, Will Deacon <Will.Deacon@arm.com>, "heiko@sntech.de" <heiko@sntech.de>, "shc_work@mail.ru" <shc_work@mail.ru>, "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>, "nicoleotsuka@gmail.com" <nicoleotsuka@gmail.com>, "padma.v@samsung.com" <padma.v@samsung.com>, "arnd@arndb.de" <arnd@arndb.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "shawn.guo@linaro.org" <shawn.guo@linaro.org>, "bcousson@baylibre.com" <bcousson@baylibre.com>, "tony@atomide.com" <tony@atomide.com>, "kernel@pengutronix.de" <kernel@pengutronix.de>, "kgene@kernel.org" <kgene@kernel.org>
List-Id: alsa-devel@alsa-project.org

On Fri, Feb 06, 2015 at 01:45:25PM +0000, Abhilash Kesavan wrote:
> Fix alignment faults seen during play-back of files with specific
> sampling rates such as 44.1K. This is based on the discussion here:
> http://www.spinics.net/lists/arm-kernel/msg384647.html
> 
> Patch 1 is needed as m32r arch does not define ioremap_wc. Patch 2 adds a
> resource managed helper function for ioremap_wc which is used in patch 3.
> 
> Changes since v1:
> 	- Fix the compilation error with m32r due to missing ioremap_wc
> 	definition.
> 	- Fixed minor indentation issues.
> 
> Note: Other architectures either have ioremap_wc defined or are including
> generic "io.h"/"iomap.h". c6x arch is the only one I am not sure of.
> 
> Abhilash Kesavan (3):
>   m32r: add definition of ioremap_wc to io.h
>   lib: devres: add a helper function for ioremap_wc
>   misc: sram: switch to ioremap_wc from ioremap
> 
>  Documentation/driver-model/devres.txt |    1 +
>  arch/m32r/include/asm/io.h            |    1 +
>  drivers/misc/sram.c                   |   17 ++++++++++++++---
>  include/linux/io.h                    |    2 ++
>  lib/devres.c                          |   28 ++++++++++++++++++++++++++++
>  5 files changed, 46 insertions(+), 3 deletions(-)

For the series:

Acked-by: Catalin Marinas <catalin.marinas@arm.com>

Thanks.

-- 
Catalin
