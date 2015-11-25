From: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Subject: [PATCH v3 0/2] ALSA: compress: Add procfs info file for compressed nodes
Date: Wed, 25 Nov 2015 13:00:22 +0000
Message-ID: <1448456424-6794-1-git-send-email-rf@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: vinod.koul@intel.com, tiwai@suse.com, broonie@kernel.org
Cc: perex@perex.cz, lgirdwood@gmail.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

This updates the compress core code to create an 'info' file under procfs
for each compressed node, like the PCM core does for PCM nodes.

Based off Takashi's for-next

Richard Fitzgerald (2):
  ALSA: compress: Add procfs info file for compressed nodes
  ALSA: compress: Pass id string to snd_compress_new

 include/sound/compress_driver.h |  7 +++-
 sound/core/compress_offload.c   | 86 ++++++++++++++++++++++++++++++++++++++++-
 sound/soc/soc-compress.c        |  8 +++-
 3 files changed, 97 insertions(+), 4 deletions(-)

-- 
1.9.1
