From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH 0/6] ASoC: SOF: small update to align with
	Mark's tree
Date: Thu,  9 May 2019 15:10:21 -0500
Message-ID: <20190509201027.3906-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 4E463F8073C
 for <alsa-devel@alsa-project.org>; Thu,  9 May 2019 22:10:35 +0200 (CEST)
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: alsa-devel@alsa-project.org
Cc: tiwai@suse.de, broonie@kernel.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

This small patchset removes unneeded include files, fixes a race
condition seen in QEMU tests, removes unnecessary PM calls, fixes
typos and updates ICL configurations.

Jaska Uimonen (1):
  ASoC: SOF: uapi: remove unused sof header files

Kai Vehmanen (1):
  ASoC: SOF: fix race in FW boot timeout handling

Ranjani Sridharan (2):
  ASoC: SOF: pcm: remove runtime PM calls during pcm open/close
  ASoC: SOF: fix error in verbose ipc command parsing

Zhu Yingjiang (2):
  ASoC: SOF: Intel: ICL: add Icelake SSP count
  ASoC: SOF: Intel: ICL add Icelake chip info struct

 include/uapi/sound/sof/eq.h       | 172 ---------------------------
 include/uapi/sound/sof/manifest.h | 188 ------------------------------
 include/uapi/sound/sof/tone.h     |  21 ----
 include/uapi/sound/sof/trace.h    |  66 -----------
 sound/soc/sof/intel/cnl.c         |  19 +++
 sound/soc/sof/intel/hda.h         |   2 +
 sound/soc/sof/ipc.c               |   2 +-
 sound/soc/sof/loader.c            |   2 +
 sound/soc/sof/pcm.c               |  29 +----
 sound/soc/sof/sof-pci-dev.c       |   2 +-
 10 files changed, 27 insertions(+), 476 deletions(-)
 delete mode 100644 include/uapi/sound/sof/eq.h
 delete mode 100644 include/uapi/sound/sof/manifest.h
 delete mode 100644 include/uapi/sound/sof/tone.h
 delete mode 100644 include/uapi/sound/sof/trace.h

-- 
2.17.1
