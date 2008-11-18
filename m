From: Bryan Wu <cooloney@kernel.org>
Subject: [PATCH 1/8] ASoC: Blackfin: updates Kconfig for SPORT
Date: Tue, 18 Nov 2008 16:18:15 +0800
Message-ID: <1226996302-10234-2-git-send-email-cooloney@kernel.org>
References: <1226996302-10234-1-git-send-email-cooloney@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nwd2mail11.analog.com (nwd2mail11.analog.com [137.71.25.57])
	by alsa0.perex.cz (Postfix) with ESMTP id 8E7F5244CC
	for <alsa-devel@alsa-project.org>; Tue, 18 Nov 2008 09:16:59 +0100 (CET)
In-Reply-To: <1226996302-10234-1-git-send-email-cooloney@kernel.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: broonie@sirena.org.uk, tiwai@suse.de
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Mike Frysinger <vapier.adi@gmail.com>, Bryan Wu <cooloney@kernel.org>
List-Id: alsa-devel@alsa-project.org

From: Mike Frysinger <vapier.adi@gmail.com>

tweak SPORT range for non-BF54x so we get proper behavior for BF52x parts

Signed-off-by: Mike Frysinger <vapier.adi@gmail.com>
Signed-off-by: Bryan Wu <cooloney@kernel.org>
---
 sound/soc/blackfin/Kconfig |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/soc/blackfin/Kconfig b/sound/soc/blackfin/Kconfig
index dc00620..3fce187 100644
--- a/sound/soc/blackfin/Kconfig
+++ b/sound/soc/blackfin/Kconfig
@@ -80,7 +80,7 @@ config SND_BF5XX_SPORT_NUM
 	int "Set a SPORT for Sound chip"
 	depends on (SND_BF5XX_I2S || SND_BF5XX_AC97)
 	range 0 3 if BF54x
-	range 0 1 if (BF53x || BF561)
+	range 0 1 if !BF54x
 	default 0
 	help
 	  Set the correct SPORT for sound chip.
-- 
1.5.6.3
