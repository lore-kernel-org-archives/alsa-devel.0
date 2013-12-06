From: Nicolin Chen <b42378@freescale.com>
Subject: [PATCH v2 0/2] Enhance imx-wm8962 machine driver
Date: Fri, 6 Dec 2013 23:38:27 +0800
Message-ID: <cover.1386344000.git.b42378@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: broonie@kernel.org, lgirdwood@gmail.com
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, perex@perex.cz, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Although there's no direct relationship between any of these two patches,
I recommend to apply them in order so as to circumvent merging conflicts.

Changlog:
v2:
 * Nothing changed for PATCH-1.
 * Added spinlock potection for boolean fll_locked in PATCH-2
 * Dropped PATCH-3, will try to revise it next time.

Nicolin Chen (2):
  ASoC: fsl: imx-wm8962: Don't update bias_level in machine driver
  ASoC: fsl: imx-wm8962: Grant hw_params/free() permission to control
    FLL

 sound/soc/fsl/imx-wm8962.c | 152 +++++++++++++++++++++++++++++----------------
 1 file changed, 99 insertions(+), 53 deletions(-)

-- 
1.8.4
