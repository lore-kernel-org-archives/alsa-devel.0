From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 13/17] ASoC: Fix Blackfin AC97 DAI probe
	function return code
Date: Tue, 18 Nov 2008 12:38:19 +0000
Message-ID: <1227011903-2825-13-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1227011903-2825-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1227011903-2825-2-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1227011903-2825-3-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1227011903-2825-4-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1227011903-2825-5-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1227011903-2825-6-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1227011903-2825-7-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1227011903-2825-8-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1227011903-2825-9-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1227011903-2825-10-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1227011903-2825-11-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1227011903-2825-12-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 8CE7D10381E
	for <alsa-devel@alsa-project.org>; Tue, 18 Nov 2008 13:38:28 +0100 (CET)
In-Reply-To: <1227011903-2825-12-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Cliff Cai <cliff.cai@analog.com>, Michael Hennerich <michael.hennerich@analog.com>, Bryan Wu <cooloney@kernel.org>
List-Id: alsa-devel@alsa-project.org

From: Michael Hennerich <michael.hennerich@analog.com>

A probe function should have a clean return 0 path.

Cc: Cliff Cai <cliff.cai@analog.com>
Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
Signed-off-by: Bryan Wu <cooloney@kernel.org>
Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/blackfin/bf5xx-ac97.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/sound/soc/blackfin/bf5xx-ac97.c b/sound/soc/blackfin/bf5xx-ac97.c
index 65c162c..5dcd3f6 100644
--- a/sound/soc/blackfin/bf5xx-ac97.c
+++ b/sound/soc/blackfin/bf5xx-ac97.c
@@ -378,6 +378,8 @@ static int bf5xx_ac97_probe(struct platform_device *pdev,
 		goto sport_config_err;
 	}
 
+	return 0;
+
 sport_config_err:
 	kfree(sport_handle);
 sport_err:
-- 
1.5.6.5
