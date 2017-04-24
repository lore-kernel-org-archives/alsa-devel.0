From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH v2 0/2] ASoC: Give prettier longname based on
	DMI
Date: Mon, 24 Apr 2017 08:54:40 +0200
Message-ID: <20170424065442.13490-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id AA248266C8B
 for <alsa-devel@alsa-project.org>; Mon, 24 Apr 2017 08:54:44 +0200 (CEST)
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
Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>, Vinod Koul <vinod.koul@intel.com>, alsa-devel@alsa-project.org, Jie Yang <yang.jie@linux.intel.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

Hi,

this is the revised patchset to set the card longname based on DMI
so that a unique UCM profile can be picked up.

v1->v2: Fix the missnig NULL argument in the function call


Takashi

===

Takashi Iwai (2):
  ASoC: Provide a dummy wrapper of snd_soc_set_dmi_name()
  ASoC: Call snd_soc_set_dmi_name() unconditionally

 include/sound/soc.h                | 8 ++++++++
 sound/soc/intel/boards/broadwell.c | 3 ---
 sound/soc/soc-core.c               | 5 +++++
 3 files changed, 13 insertions(+), 3 deletions(-)

-- 
2.11.1
