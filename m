From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH v2 0/3] ASoC: SOF: suspend/resume debug tools
Date: Wed, 12 Jun 2019 11:47:23 -0500
Message-ID: <20190612164726.26768-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 93D7DF80791
 for <alsa-devel@alsa-project.org>; Wed, 12 Jun 2019 18:47:33 +0200 (CEST)
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

These patches were submitted in an earlier series but not merged and
then conflicted with the IPC flood test.

Resending, no new functionality. These helpers are really helpful for
e.g. SoundWire or HDaudio bringup.

Pierre-Louis Bossart (3):
  ASoC: SOF: trace: move to opt-in with Kconfig and module parameter
  ASoC: SOF: acpi: add module param to disable pm_runtime
  ASoC: SOF: pci: add module param to disable pm_runtime

 sound/soc/sof/Kconfig        |  8 ++++++++
 sound/soc/sof/core.c         | 26 ++++++++++++++++++++------
 sound/soc/sof/sof-acpi-dev.c | 12 +++++++++++-
 sound/soc/sof/sof-pci-dev.c  | 12 +++++++++++-
 sound/soc/sof/sof-priv.h     |  1 +
 sound/soc/sof/trace.c        | 17 ++++++++++++++++-
 6 files changed, 67 insertions(+), 9 deletions(-)

-- 
2.20.1
