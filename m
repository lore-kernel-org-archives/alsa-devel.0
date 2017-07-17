From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH 2/3] ASoC: psc-ac97: constify dev_pm_ops structure
Date: Sun, 16 Jul 2017 21:12:39 -0500
Message-ID: <4aef0a53684236f691ff485daa2944e9d79577cb.1500256845.git.gustavo@embeddedor.com>
References: <cover.1500256845.git.gustavo@embeddedor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <cover.1500256845.git.gustavo@embeddedor.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, "Gustavo A. R. Silva" <gustavo@embeddedor.com>
List-Id: alsa-devel@alsa-project.org

This dev_pm_ops structure is only stored in the pm field of a
device_driver structure. This field is declared const, so
dev_pm_ops structures that have this property can be declared
as const also.

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 sound/soc/au1x/psc-ac97.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/au1x/psc-ac97.c b/sound/soc/au1x/psc-ac97.c
index bb53c70..a2050ae 100644
--- a/sound/soc/au1x/psc-ac97.c
+++ b/sound/soc/au1x/psc-ac97.c
@@ -474,7 +474,7 @@ static int au1xpsc_ac97_drvresume(struct device *dev)
 	return 0;
 }
 
-static struct dev_pm_ops au1xpscac97_pmops = {
+static const struct dev_pm_ops au1xpscac97_pmops = {
 	.suspend	= au1xpsc_ac97_drvsuspend,
 	.resume		= au1xpsc_ac97_drvresume,
 };
-- 
2.5.0
