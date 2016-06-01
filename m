From: sathyanarayana.nujella@intel.com
Subject: [REPOST PATCH 0/2]ASoC: Intel: Add Broxton-P Dialog
	Maxim machine driver
Date: Tue, 31 May 2016 23:33:14 -0700
Message-ID: <20160601063316.30042-1-sathyanarayana.nujella@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id C05EB266B90
 for <alsa-devel@alsa-project.org>; Wed,  1 Jun 2016 08:33:32 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org, vinod.koul@intel.com
Cc: alsa-devel@alsa-project.org, srinivas.sripathi@intel.com, yang.a.fang@intel.com, liam.r.girdwood@linux.intel.com, harshapriya.n@intel.com, Sathyanarayana Nujella <sathyanarayana.nujella@intel.com>, vedang.patel@intel.com
List-Id: alsa-devel@alsa-project.org

From: Sathyanarayana Nujella <sathyanarayana.nujella@intel.com>

Reposting this patchset as some recipents didn't get and also alsa-devel rejected.

This patch set adds the Intel Broxton-P machine driver and updates machine table.

Sathyanarayana Nujella (2):
  ASoC: Intel: Add Broxton-P Dialog Maxim machine driver
  ASoC: Intel: Add Broxton-P Dialog+Maxim machine driver entry

 sound/soc/intel/Kconfig                       |  16 +
 sound/soc/intel/boards/Makefile               |   2 +
 sound/soc/intel/boards/bxt_da7219_max98357a.c | 460 ++++++++++++++++++++++++++
 sound/soc/intel/skylake/skl.c                 |   1 +
 4 files changed, 479 insertions(+)
 create mode 100644 sound/soc/intel/boards/bxt_da7219_max98357a.c

-- 
2.8.3
