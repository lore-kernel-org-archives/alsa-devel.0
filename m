From: Bryan Wu <cooloney@kernel.org>
Subject: [PATCH 8/8] ASoC: Blackfin: always set a default value
	for that GPIO range
Date: Tue, 18 Nov 2008 16:18:22 +0800
Message-ID: <1226996302-10234-9-git-send-email-cooloney@kernel.org>
References: <1226996302-10234-1-git-send-email-cooloney@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nwd2mail11.analog.com (nwd2mail11.analog.com [137.71.25.57])
	by alsa0.perex.cz (Postfix) with ESMTP id BDAD9244CE
	for <alsa-devel@alsa-project.org>; Tue, 18 Nov 2008 09:17:02 +0100 (CET)
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
Cc: Cliff Cai <cliff.cai@analog.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Mike Frysinger <vapier.adi@gmail.com>, Bryan Wu <cooloney@kernel.org>
List-Id: alsa-devel@alsa-project.org

From: Mike Frysinger <vapier.adi@gmail.com>

Cc: Cliff Cai <cliff.cai@analog.com>
Signed-off-by: Mike Frysinger <vapier.adi@gmail.com>
Signed-off-by: Bryan Wu <cooloney@kernel.org>
---
 sound/soc/blackfin/Kconfig |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/sound/soc/blackfin/Kconfig b/sound/soc/blackfin/Kconfig
index f0fd235..e162cbb 100644
--- a/sound/soc/blackfin/Kconfig
+++ b/sound/soc/blackfin/Kconfig
@@ -104,5 +104,6 @@ config SND_BF5XX_RESET_GPIO_NUM
 	range 0 159
 	default 19 if BFIN548_EZKIT
 	default 5 if BFIN537_STAMP
+	default 0
 	help
 	  Set the correct GPIO for RESET the sound chip.
-- 
1.5.6.3
