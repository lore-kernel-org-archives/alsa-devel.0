From: Bryan Wu <cooloney@kernel.org>
Subject: [PATCH 1/9] ASoC: add Blackfin build options to
	Kconfig and Makefile of sound soc framework
Date: Fri,  5 Sep 2008 18:21:34 +0800
Message-ID: <1220610102-7716-2-git-send-email-cooloney@kernel.org>
References: <1220610102-7716-1-git-send-email-cooloney@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nwd2mail10.analog.com (nwd2mail10.analog.com [137.71.25.55])
	by alsa0.perex.cz (Postfix) with ESMTP id D3806245D1
	for <alsa-devel@alsa-project.org>;
	Fri,  5 Sep 2008 12:21:26 +0200 (CEST)
In-Reply-To: <1220610102-7716-1-git-send-email-cooloney@kernel.org>
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
Cc: Cliff Cai <cliff.cai@analog.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Bryan Wu <cooloney@kernel.org>
List-Id: alsa-devel@alsa-project.org

From: Cliff Cai <cliff.cai@analog.com>

Signed-off-by: Cliff Cai <cliff.cai@analog.com>
Signed-off-by: Bryan Wu <cooloney@kernel.org>
---
 sound/soc/Kconfig  |    2 +-
 sound/soc/Makefile |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/Kconfig b/sound/soc/Kconfig
index f743530..0adbc92 100644
--- a/sound/soc/Kconfig
+++ b/sound/soc/Kconfig
@@ -31,7 +31,7 @@ source "sound/soc/sh/Kconfig"
 source "sound/soc/fsl/Kconfig"
 source "sound/soc/davinci/Kconfig"
 source "sound/soc/omap/Kconfig"
-
+source "sound/soc/blackfin/Kconfig"
 # Supported codecs
 source "sound/soc/codecs/Kconfig"
 
diff --git a/sound/soc/Makefile b/sound/soc/Makefile
index 933a66d..d849349 100644
--- a/sound/soc/Makefile
+++ b/sound/soc/Makefile
@@ -2,4 +2,4 @@ snd-soc-core-objs := soc-core.o soc-dapm.o
 
 obj-$(CONFIG_SND_SOC)	+= snd-soc-core.o
 obj-$(CONFIG_SND_SOC)	+= codecs/ at32/ at91/ pxa/ s3c24xx/ sh/ fsl/ davinci/
-obj-$(CONFIG_SND_SOC)	+= omap/ au1x/
+obj-$(CONFIG_SND_SOC)	+= omap/ au1x/ blackfin/
-- 
1.5.6
