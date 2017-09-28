From: Lori Hikichi <lori.hikichi@broadcom.com>
Subject: [PATCH v1 0/3] Minor updates to driver
Date: Thu, 28 Sep 2017 15:29:31 -0700
Message-ID: <1506637775-18293-1-git-send-email-lori.hikichi@broadcom.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, Jon Mason <jonmason@broadcom.com>, bcm-kernel-feedback-list@broadcom.com
Cc: alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Lori Hikichi <lori.hikichi@broadcom.com>
List-Id: alsa-devel@alsa-project.org

This patchset contains a few small updates to the DAI driver. 

Lori Hikichi (3):
  ASoC: cygnus: Add EXPORT_SYMBOL for helper function
  ASoC: cygnus: Remove set_fmt from SPDIF dai ops
  ASoC: cygnus: Remove support for 8 bit audio and for mono

 sound/soc/bcm/cygnus-ssp.c | 32 +++++++++++++-------------------
 1 file changed, 13 insertions(+), 19 deletions(-)

-- 
1.9.1
