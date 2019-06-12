From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH 0/5] ASoC: SOF: IPC: style,
	logs and suspend improvements
Date: Wed, 12 Jun 2019 11:57:00 -0500
Message-ID: <20190612165705.1858-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id E057AF80791
 for <alsa-devel@alsa-project.org>; Wed, 12 Jun 2019 18:57:11 +0200 (CEST)
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

4 mostly cosmetic patches and a nice one to force recovery on failed
suspend

Dragos Tarcatu (1):
  ASOC: SOF: ipc: prevent logging trace messages

Kai Vehmanen (2):
  ASoC: SOF: intel: extend IPC dump information
  ASoC: SOF: ignore unrecoverable CTX_SAVE IPC errors at suspend

Pierre-Louis Bossart (2):
  ASoC: SOF: uapi: align comments with firmware files
  ASoC: SOF: ipc: clarify operator precedence

 include/sound/sof/topology.h |  4 ++--
 include/sound/sof/trace.h    |  4 +++-
 sound/soc/sof/intel/cnl.c    |  2 ++
 sound/soc/sof/intel/hda.c    | 29 +++++++++++++++++++++++++++++
 sound/soc/sof/intel/hda.h    |  2 ++
 sound/soc/sof/ipc.c          |  9 +++++----
 sound/soc/sof/pm.c           | 11 ++++++++++-
 7 files changed, 53 insertions(+), 8 deletions(-)

-- 
2.20.1
