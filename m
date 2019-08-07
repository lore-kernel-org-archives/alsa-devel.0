From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH 0/6] ASoC: SOF: refactor duplicated code
	between Intel and i.MX8
Date: Wed,  7 Aug 2019 10:01:57 -0500
Message-ID: <20190807150203.26359-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id EC296F800E4
 for <alsa-devel@alsa-project.org>; Wed,  7 Aug 2019 17:02:12 +0200 (CEST)
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

During the initial i.MX patch reviews on GitHub, we realized a lot of
the i.MX mailbox/window code was common with the Intel loader code
except for a couple of offsets. Most of the credit goes to Daniel
Baluta for working on this series which adds a better abstraction and
reduces code duplication. Comments from Keyon and Ranjani helped
remove unnecessary parts kept for historical reasons and improve the
code overall.

Daniel Baluta (6):
  ASoC: SOF: Remove call to snd_sof_dsp_mailbox_init
  ASoC: SOF: Introduce snd_sof_dsp_get_mailbox_offset
  ASoC: SOF: Introduce snd_sof_dsp_get_window_offset
  ASoC: SOF: Intel: byt: Refactor fw ready / mem windows creation
  ASoC: SOF: Intel: bdw: Use generic function for fw ready / mem windows
    creation
  ASoC: SOF: Intel: hda: Use generic function for fw ready / mem windows
    creation

 sound/soc/sof/intel/apl.c     |   4 +-
 sound/soc/sof/intel/bdw.c     | 161 +++-----------------------------
 sound/soc/sof/intel/byt.c     | 169 ++++------------------------------
 sound/soc/sof/intel/cnl.c     |   4 +-
 sound/soc/sof/intel/hda-ipc.c | 150 +-----------------------------
 sound/soc/sof/intel/hda.h     |   4 +-
 sound/soc/sof/loader.c        | 168 +++++++++++++++++++++++++++++++++
 sound/soc/sof/ops.h           |  18 ++++
 sound/soc/sof/sof-priv.h      |   6 ++
 9 files changed, 237 insertions(+), 447 deletions(-)

-- 
2.20.1
