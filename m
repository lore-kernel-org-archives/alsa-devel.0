From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH 5/8] staging: emxx_udc: Change platform
 dependency to ARCH_RENESAS
Date: Mon, 23 Apr 2018 09:56:26 +0200
Message-ID: <20180423075625.utzf6sgu4rlvb55r@verge.net.au>
References: <1524230914-10175-1-git-send-email-geert+renesas@glider.be>
 <1524230914-10175-6-git-send-email-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from kirsty.vergenet.net (kirsty.vergenet.net [202.4.237.240])
 by alsa0.perex.cz (Postfix) with ESMTP id 89A652675D0
 for <alsa-devel@alsa-project.org>; Mon, 23 Apr 2018 09:56:30 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1524230914-10175-6-git-send-email-geert+renesas@glider.be>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: alsa-devel@alsa-project.org, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Liam Girdwood <lgirdwood@gmail.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, devel@driverdev.osuosl.org, Mauro Carvalho Chehab <mchehab@kernel.org>, Vinod Koul <vinod.koul@intel.com>, Magnus Damm <magnus.damm@gmail.com>, Russell King <linux@armlinux.org.uk>, linux-media@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Mark Brown <broonie@kernel.org>, Dan Williams <dan.j.williams@intel.com>, linux-arm-kernel@lists.infradead.org, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Takashi Iwai <tiwai@suse.com>, linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org, netdev@vger.kernel.org, dmaengine@vger.kernel.org, "David S . Miller" <davem@>
List-Id: alsa-devel@alsa-project.org

On Fri, Apr 20, 2018 at 03:28:31PM +0200, Geert Uytterhoeven wrote:
> Emma Mobile is a Renesas ARM SoC.  Since commit 9b5ba0df4ea4f940 ("ARM:
> shmobile: Introduce ARCH_RENESAS") is ARCH_RENESAS a more appropriate
> platform dependency than the legacy ARCH_SHMOBILE, hence use the
> former.
> 
> This will allow to drop ARCH_SHMOBILE on ARM in the near future.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
