From: Nik Nyby <nikolas@gnu.org>
Subject: [PATCH] sound/soc: fix typos in Kconfig (trivial)
Date: Sat,  7 Oct 2017 18:26:10 -0400
Message-ID: <20171007222610.17743-1-nikolas@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from eggs.gnu.org (eggs.gnu.org [208.118.235.92])
 by alsa0.perex.cz (Postfix) with ESMTP id 67EB92668F0
 for <alsa-devel@alsa-project.org>; Sun,  8 Oct 2017 00:26:31 +0200 (CEST)
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <nikolas@gnu.org>) id 1e0xYC-0000eH-2z
 for alsa-devel@alsa-project.org; Sat, 07 Oct 2017 18:26:28 -0400
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: lgirdwood@gmail.com, broonie@kernel.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, trivial@kernel.org
Cc: Nik Nyby <nikolas@gnu.org>
List-Id: alsa-devel@alsa-project.org

This fixes a few typos in the snd_designware description.

Signed-off-by: Nik Nyby <nikolas@gnu.org>
---
 sound/soc/dwc/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/dwc/Kconfig b/sound/soc/dwc/Kconfig
index c6fd95fa5ca6..aa0c6ec4d93c 100644
--- a/sound/soc/dwc/Kconfig
+++ b/sound/soc/dwc/Kconfig
@@ -4,8 +4,8 @@ config SND_DESIGNWARE_I2S
 	select SND_SOC_GENERIC_DMAENGINE_PCM
 	help
 	 Say Y or M if you want to add support for I2S driver for
-	 Synopsys desigwnware I2S device. The device supports upto
-	 maximum of 8 channels each for play and record.
+	 Synopsys designware I2S device. The device supports up to
+	 a maximum of 8 channels each for play and record.
 
 config SND_DESIGNWARE_PCM
 	bool "PCM PIO extension for I2S driver"
-- 
2.14.2
