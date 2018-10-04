From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 0/5] ASoC: Fix fall-through annotations
Date: Thu,  4 Oct 2018 20:30:01 +0200
Message-ID: <20181004183006.23983-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 9B1FF267737
 for <alsa-devel@alsa-project.org>; Thu,  4 Oct 2018 20:30:09 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: Oder Chiou <oder_chiou@realtek.com>, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Jie Yang <yang.jie@linux.intel.com>, Liam Girdwood <lgirdwood@gmail.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Bard Liao <bardliao@realtek.com>
List-Id: alsa-devel@alsa-project.org

Hi,

this is a patch set to add / fix the "fall through" annotations to be
compliant with gcc's -Wimplicit-fallthrough option.


Takashi

===

Takashi Iwai (5):
  ASoC: adau1761: Use the standard fall-through annotation
  ASoC: pcm186x: Use the standard fall-through annotation
  ASoC: rt274: Add fall-through annotations
  ASoC: intel: skylake: Add fall-through annotation
  ASoC: topology: Use the standard fall-through annotations

 sound/soc/codecs/adau1761.c       | 3 ++-
 sound/soc/codecs/pcm186x.c        | 3 ++-
 sound/soc/codecs/rt274.c          | 2 ++
 sound/soc/intel/skylake/skl-pcm.c | 1 +
 sound/soc/soc-topology.c          | 4 ++--
 5 files changed, 9 insertions(+), 4 deletions(-)

-- 
2.18.0
