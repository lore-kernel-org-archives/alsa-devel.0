From: Bryan Wu <cooloney@kernel.org>
Subject: [PATCH 1/3] ASoC: Blackfin: tweak SPORT range for
	non-BF54x so we get proper behavior for BF52x parts
Date: Tue, 21 Oct 2008 11:36:11 +0800
Message-ID: <1224560173-8728-2-git-send-email-cooloney@kernel.org>
References: <1224560173-8728-1-git-send-email-cooloney@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nwd2mail10.analog.com (nwd2mail10.analog.com [137.71.25.55])
	by alsa0.perex.cz (Postfix) with ESMTP id E0CAF24704
	for <alsa-devel@alsa-project.org>;
	Tue, 21 Oct 2008 05:35:48 +0200 (CEST)
In-Reply-To: <1224560173-8728-1-git-send-email-cooloney@kernel.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: broonie@sirena.org.uk
Cc: alsa-devel@alsa-project.org, Bryan Wu <cooloney@kernel.org>, Mike Frysinger <vapier.adi@gmail.com>
List-Id: alsa-devel@alsa-project.org

From: Mike Frysinger <vapier.adi@gmail.com>

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
1.5.6
