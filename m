From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 0/5] ALSA: Fix remaining NULL device with
	memory allocations
Date: Mon,  4 Feb 2019 14:42:17 +0100
Message-ID: <20190204134222.9560-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 5BB1526746F
 for <alsa-devel@alsa-project.org>; Mon,  4 Feb 2019 14:42:26 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Mark Brown <broonie@kernel.org>, Christoph Hellwig <hch@lst.de>
List-Id: alsa-devel@alsa-project.org

Hi,

this patchset covers the still remaining drivers calling the memory
allocation with NULL device pointer.  Simply card->dev is passed
there.


Mark, two of them are trivial fixes for ASoC, and I'd like to merge
them through my tree, since the last patch adds an explicit WARN_ON().
Give me Ack's if they are OK.


thanks,

Takashi

===

Takashi Iwai (5):
  ALSA: x86: Avoid passing NULL to memory allocators
  ALSA: arm: Avoid passing NULL to memory allocators
  ASoC: amd: Avoid passing NULL to memory allocators
  ASoC: sh: Avoid passing NULL to memory allocators
  ALSA: core: Don't allow NULL device for memory allocation

 sound/arm/aaci.c                    | 3 ++-
 sound/core/memalloc.c               | 2 ++
 sound/soc/amd/raven/acp3x-pcm-dma.c | 3 ++-
 sound/soc/sh/siu_pcm.c              | 2 +-
 sound/x86/intel_hdmi_audio.c        | 3 ++-
 5 files changed, 9 insertions(+), 4 deletions(-)

-- 
2.16.4
