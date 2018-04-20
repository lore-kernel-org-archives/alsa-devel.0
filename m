From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 5/8] staging: emxx_udc: Change platform dependency to
 ARCH_RENESAS
Date: Fri, 20 Apr 2018 15:28:31 +0200
Message-ID: <1524230914-10175-6-git-send-email-geert+renesas@glider.be>
References: <1524230914-10175-1-git-send-email-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <driverdev-devel-bounces@linuxdriverproject.org>
In-Reply-To: <1524230914-10175-1-git-send-email-geert+renesas@glider.be>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
To: Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Russell King <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Dan Williams <dan.j.williams@intel.com>, Vinod Koul <vinod.koul@intel.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, "David S . Miller" <davem@davemloft.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Arnd Bergmann <arnd@arndb.de>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: devel@driverdev.osuosl.org, alsa-devel@alsa-project.org, Geert Uytterhoeven <geert+renesas@glider.be>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org, dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Emma Mobile is a Renesas ARM SoC.  Since commit 9b5ba0df4ea4f940 ("ARM:
shmobile: Introduce ARCH_RENESAS") is ARCH_RENESAS a more appropriate
platform dependency than the legacy ARCH_SHMOBILE, hence use the
former.

This will allow to drop ARCH_SHMOBILE on ARM in the near future.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/staging/emxx_udc/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/emxx_udc/Kconfig b/drivers/staging/emxx_udc/Kconfig
index d7577096fb25ae7a..e50e722183648c55 100644
--- a/drivers/staging/emxx_udc/Kconfig
+++ b/drivers/staging/emxx_udc/Kconfig
@@ -1,6 +1,6 @@
 config USB_EMXX
 	tristate "EMXX USB Function Device Controller"
- 	depends on USB_GADGET && (ARCH_SHMOBILE || (ARM && COMPILE_TEST))
+	depends on USB_GADGET && (ARCH_RENESAS || (ARM && COMPILE_TEST))
 	help
 	   The Emma Mobile series of SoCs from Renesas Electronics and
 	   former NEC Electronics include USB Function hardware.
-- 
2.7.4
