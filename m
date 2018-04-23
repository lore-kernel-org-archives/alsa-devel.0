From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH 6/8] ASoC: sh: Update menu title and platform dependency
Date: Mon, 23 Apr 2018 09:56:43 +0200
Message-ID: <20180423075642.avhihfr44se7dfz6@verge.net.au>
References: <1524230914-10175-1-git-send-email-geert+renesas@glider.be>
 <1524230914-10175-7-git-send-email-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <driverdev-devel-bounces@linuxdriverproject.org>
Content-Disposition: inline
In-Reply-To: <1524230914-10175-7-git-send-email-geert+renesas@glider.be>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: alsa-devel@alsa-project.org, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Liam Girdwood <lgirdwood@gmail.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, devel@driverdev.osuosl.org, Mauro Carvalho Chehab <mchehab@kernel.org>, Vinod Koul <vinod.koul@intel.com>, Magnus Damm <magnus.damm@gmail.com>, Russell King <linux@armlinux.org.uk>, linux-media@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Mark Brown <broonie@kernel.org>, Dan Williams <dan.j.williams@intel.com>, Jaroslav Kysela <perex@perex.cz>, linux-arm-kernel@lists.infradead.org, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Takashi Iwai <tiwai@suse.com>, linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org, netdev@vger.kernel.org, dmaengine@vger.kern
List-Id: alsa-devel@alsa-project.org

On Fri, Apr 20, 2018 at 03:28:32PM +0200, Geert Uytterhoeven wrote:
> Change the menu title to refer to "Renesas SoCs" instead of "SuperH", as
> both SuperH and ARM SoCs are supported.
> 
> Since commit 9b5ba0df4ea4f940 ("ARM: shmobile: Introduce ARCH_RENESAS")
> is ARCH_RENESAS a more appropriate platform dependency for Renesas ARM
> SoCs than the legacy ARCH_SHMOBILE, hence use the former.
> Renesas SuperH SH-Mobile SoCs are still covered by the SUPERH
> dependency.
> 
> This will allow to drop ARCH_SHMOBILE on ARM and ARM64 in the near
> future.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
