From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH 0/8] ASoC: SOF: IPC updates
Date: Mon,  3 Jun 2019 11:20:24 -0500
Message-ID: <20190603162032.7626-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 61753F80CC4
 for <alsa-devel@alsa-project.org>; Mon,  3 Jun 2019 18:20:38 +0200 (CEST)
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

Align the Intel IPC code with the recommended hardware sequences
instead of confusing ones, remove useless command and clean-up
interface definition.

Daniel Baluta (1):
  ASoC: SOF: Do not send cmd via SHIM register

Pierre-Louis Bossart (6):
  ASoC: SOF: Intel: cnl-ipc: read all IPC registers first
  ASoC: SOF: Intel: cnl-ipc: move code around for clarity
  ASoC: SOF: Intel: cnl-ipc: re-enable IPC IRQ at end of handler
  ASoC: SOF: Intel: hda-ipc: read all IPC registers first
  ASoC: SOF: Intel: hda-ipc: re-enable IPC IRQ at end of handler
  ASoC: SOF: Intel: ipc: don't check for HIPCCTL register value

Slawomir Blauciak (1):
  ASoC: SOF: ipc: replace fw ready bitfield with explicit bit ordering

 include/sound/sof/info.h      | 20 ++++++-------
 sound/soc/sof/intel/byt.c     |  5 +---
 sound/soc/sof/intel/cnl.c     | 56 +++++++++++++++++------------------
 sound/soc/sof/intel/hda-ipc.c | 43 +++++++++++++--------------
 sound/soc/sof/ipc.c           | 11 ++++---
 5 files changed, 67 insertions(+), 68 deletions(-)

-- 
2.20.1
