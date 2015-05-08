From: Jean-Francois Moine <moinejf@free.fr>
Subject: [PATCH v12 3/6] sound/core: remove the trace from the DRM ELD helper
Date: Fri, 8 May 2015 10:07:59 +0200
Message-ID: <ff645b668ab3fa3cbebde9e4e14e3541d9cf2b33.1431083916.git.moinejf@free.fr>
References: <cover.1431083916.git.moinejf@free.fr>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1431083916.git.moinejf@free.fr>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Dave Airlie <airlied@gmail.com>, Andrew Jackson <Andrew.Jackson@arm.com>, Jyri Sarha <jsarha@ti.com>, alsa-devel@alsa-project.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Jean-Francois Moine <moinejf@free.fr>
---
 sound/core/pcm_drm_eld.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/core/pcm_drm_eld.c b/sound/core/pcm_drm_eld.c
index 47d9b60..a553d30 100644
--- a/sound/core/pcm_drm_eld.c
+++ b/sound/core/pcm_drm_eld.c
@@ -42,7 +42,6 @@ static int eld_limit_rates(struct snd_pcm_hw_params *params,
 			if (c->min <= channels)
 				rate_mask |= sad[1];
 		}
-printk("%s: r %d-%d c %d-%d m %x\n", __func__, r->min, r->max, c->min, c->max, rate_mask);
 	}
 
 	return snd_interval_list(r, ARRAY_SIZE(eld_rates), eld_rates,
-- 
2.1.4
