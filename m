From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH 1/8] arm: shmobile: Change platform dependency to
 ARCH_RENESAS
Date: Fri, 20 Apr 2018 17:53:18 +0300
Message-ID: <44b6b9a3-5273-54f4-ee72-0d5fcc36348a@cogentembedded.com>
References: <1524230914-10175-1-git-send-email-geert+renesas@glider.be>
 <1524230914-10175-2-git-send-email-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1524230914-10175-2-git-send-email-geert+renesas@glider.be>
Content-Language: en-MW
Sender: linux-kernel-owner@vger.kernel.org
To: Geert Uytterhoeven <geert+renesas@glider.be>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Russell King <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Dan Williams <dan.j.williams@intel.com>, Vinod Koul <vinod.koul@intel.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, "David S . Miller" <davem@davemloft.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Arnd Bergmann <arnd@arndb.de>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: linux-renesas-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, dmaengine@vger.kernel.org, linux-media@vger.kernel.org, netdev@vger.kernel.org, devel@driverdev.osuosl.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On 04/20/2018 04:28 PM, Geert Uytterhoeven wrote:

> Since commit 9b5ba0df4ea4f940 ("ARM: shmobile: Introduce ARCH_RENESAS")
> is ARCH_RENESAS a more appropriate platform dependency than the legacy

   "ARCH_RENESAS is", no?

> ARCH_SHMOBILE, hence use the former.
> 
> This will allow to drop ARCH_SHMOBILE on ARM in the near future.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
[...]

MBR, Sergei
