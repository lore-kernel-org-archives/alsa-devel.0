From: Vinod Koul <vkoul@kernel.org>
Subject: [PATCH 01/14] soundwire: fix kconfig help format
Date: Thu,  2 May 2019 16:29:17 +0530
Message-ID: <20190502105930.9889-2-vkoul@kernel.org>
References: <20190502105930.9889-1-vkoul@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id CAD78F89693
 for <alsa-devel@alsa-project.org>; Thu,  2 May 2019 13:00:15 +0200 (CEST)
In-Reply-To: <20190502105930.9889-1-vkoul@kernel.org>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: alsa-devel@alsa-project.org
Cc: Greg KH <gregkh@linuxfoundation.org>, Sanyog Kale <sanyog.r.kale@intel.com>, Vinod Koul <vkoul@kernel.org>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Shreyas NC <shreyas.nc@intel.com>
List-Id: alsa-devel@alsa-project.org

Move to help format instead of --help-- as that is not recommended and
this makes file consistent with other instance

Signed-off-by: Vinod Koul <vkoul@kernel.org>
---
 drivers/soundwire/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soundwire/Kconfig b/drivers/soundwire/Kconfig
index 84876a74874f..53b55b79c4af 100644
--- a/drivers/soundwire/Kconfig
+++ b/drivers/soundwire/Kconfig
@@ -28,7 +28,7 @@ config SOUNDWIRE_INTEL
 	select SOUNDWIRE_CADENCE
 	select SOUNDWIRE_BUS
 	depends on X86 && ACPI && SND_SOC
-	---help---
+	help
 	  SoundWire Intel Master driver.
 	  If you have an Intel platform which has a SoundWire Master then
 	  enable this config option to get the SoundWire support for that
-- 
2.20.1
