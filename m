From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH 0/3] constify dev_pm_ops structures
Date: Sun, 16 Jul 2017 21:12:11 -0500
Message-ID: <cover.1500256845.git.gustavo@embeddedor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, "Gustavo A. R. Silva" <gustavo@embeddedor.com>
List-Id: alsa-devel@alsa-project.org

This patchset aims to constify all dev_pm_ops structures that only
stored in the pm field of a device_driver structure. This field is
declared const, so dev_pm_ops structures that have this property
can be declared as const also.

Thanks!

Gustavo A. R. Silva (3):
  ASoC: fsi: constify dev_pm_ops structure
  ASoC: psc-ac97: constify dev_pm_ops structure
  ASoC: au1x: psc-i2s: constify dev_pm_ops structure

 sound/soc/au1x/psc-ac97.c | 2 +-
 sound/soc/au1x/psc-i2s.c  | 2 +-
 sound/soc/sh/fsi.c        | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

-- 
2.5.0
