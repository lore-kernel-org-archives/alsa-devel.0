From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH 0/3] ASoC: SOF: initial support for i.MX8
Date: Thu, 15 Aug 2019 10:44:57 -0500
Message-ID: <20190815154500.29090-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 606C0F801DF
 for <alsa-devel@alsa-project.org>; Thu, 15 Aug 2019 17:45:16 +0200 (CEST)
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

The reviews for these patches took place already on mailing lists and
GitHub, and the code is already integrated in the SOF tree (along with
dependencies already accepted in the i.MX tree)

As agreed with Daniel, I am sending these patches as part of my weekly
updates so that we avoid conflicts with other contributions (the next
series adds Intel ALH/SoundWire suport which changes the same files)

Daniel Baluta (3):
  ASoC: SOF: Add OF DSP device support
  ASoC: SOF: imx: Add i.MX8 HW support
  ASoC: SOF: topology: Add dummy support for i.MX8 DAIs

 include/sound/sof/dai.h         |   2 +
 include/uapi/sound/sof/tokens.h |   8 +
 sound/soc/sof/Kconfig           |  11 +
 sound/soc/sof/Makefile          |   4 +
 sound/soc/sof/imx/Kconfig       |  22 ++
 sound/soc/sof/imx/Makefile      |   4 +
 sound/soc/sof/imx/imx8.c        | 394 ++++++++++++++++++++++++++++++++
 sound/soc/sof/sof-of-dev.c      | 143 ++++++++++++
 sound/soc/sof/topology.c        |  30 +++
 9 files changed, 618 insertions(+)
 create mode 100644 sound/soc/sof/imx/Kconfig
 create mode 100644 sound/soc/sof/imx/Makefile
 create mode 100644 sound/soc/sof/imx/imx8.c
 create mode 100644 sound/soc/sof/sof-of-dev.c

-- 
2.20.1
