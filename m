From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH 0/4] ASoC: SOF: control/topology improvements
Date: Wed, 12 Jun 2019 12:01:44 -0500
Message-ID: <20190612170148.15327-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 2A1C9F80791
 for <alsa-devel@alsa-project.org>; Wed, 12 Jun 2019 19:02:03 +0200 (CEST)
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

3 patches to improve volume handling and DMIC unmute, plus a
long-overdue one to avoid waking-up the DSP when reading from a
kcontrol cached value.

Bard Liao (1):
  ASoC: SOF: dont wake dsp up in kcontrol IO

Seppo Ingalsuo (1):
  ASoC: SOF: Add DMIC token for unmute gain ramp time

Zhu Yingjiang (2):
  ASoC: SOF: topology: add min/max step for volume_table
  ASoC: SOF: topology: pass volume min/max linear value to FW

 include/sound/sof/dai-intel.h   |   3 +-
 include/uapi/sound/sof/abi.h    |   2 +-
 include/uapi/sound/sof/tokens.h |   1 +
 sound/soc/sof/control.c         | 270 +++++---------------------------
 sound/soc/sof/sof-priv.h        |   2 +
 sound/soc/sof/topology.c        |  68 ++++++++
 6 files changed, 112 insertions(+), 234 deletions(-)

-- 
2.20.1
