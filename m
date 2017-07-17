From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH 1/3] ASoC: fsi: constify dev_pm_ops structure
Date: Sun, 16 Jul 2017 21:12:21 -0500
Message-ID: <69b7f69ba04bc54ddacb6e67251b778d8dbe2263.1500256845.git.gustavo@embeddedor.com>
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
 sound/soc/sh/fsi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/sh/fsi.c b/sound/soc/sh/fsi.c
index 7c4bdd8..005b215 100644
--- a/sound/soc/sh/fsi.c
+++ b/sound/soc/sh/fsi.c
@@ -2109,7 +2109,7 @@ static int fsi_resume(struct device *dev)
 	return 0;
 }
 
-static struct dev_pm_ops fsi_pm_ops = {
+static const struct dev_pm_ops fsi_pm_ops = {
 	.suspend		= fsi_suspend,
 	.resume			= fsi_resume,
 };
-- 
2.5.0
