From: Philipp Zabel <p.zabel@pengutronix.de>
Subject: Re: [PATCH v2 3/3] misc: sram: switch to ioremap_wc from ioremap
Date: Fri, 06 Feb 2015 17:10:07 +0100
Message-ID: <1423239007.3864.44.camel@pengutronix.de>
References: <1423230328-6721-1-git-send-email-a.kesavan@samsung.com>
	 <1423230328-6721-4-git-send-email-a.kesavan@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1423230328-6721-4-git-send-email-a.kesavan@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Abhilash Kesavan <a.kesavan@samsung.com>
Cc: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, hirokazu.takata.wj@renesas.com, catalin.marinas@arm.com, Will.Deacon@arm.com, heiko@sntech.de, shc_work@mail.ru, nicoleotsuka@gmail.com, padma.v@samsung.com, arnd@arndb.de, alsa-devel@alsa-project.org, shawn.guo@linaro.org, bcousson@baylibre.com, tony@atomide.com, kernel@pengutronix.de, kgene@kernel.org
List-Id: alsa-devel@alsa-project.org

Am Freitag, den 06.02.2015, 19:15 +0530 schrieb Abhilash Kesavan:
> Currently, the SRAM allocator returns device memory via ioremap.
> This causes issues on ARM64 when the internal SoC SRAM allocated by
> the generic sram driver is used for audio playback. The destination
> buffer address (which is ioremapped SRAM) is not 64-bit aligned for
> certain streams (e.g. 44.1k sampling rate). In such cases we get
> unhandled alignment faults. Use ioremap_wc in place of ioremap which
> gives us normal non-cacheable memory instead of device memory.
> 
> Signed-off-by: Abhilash Kesavan <a.kesavan@samsung.com>
> Tested-by: Tony Lindgren <tony@atomide.com>
> Tested-by: Heiko Stuebner <heiko@sntech.de>

Acked-by: Philipp Zabel <p.zabel@pengutronix.de>

regards
Philipp
