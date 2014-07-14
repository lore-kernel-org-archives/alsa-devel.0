From: Jie Yang <yang.jie@intel.com>
Subject: [PATCH 0/5] ASoC: Intel: Enable BDW/HSW SRAM power
	gating
Date: Mon, 14 Jul 2014 16:37:50 +0800
Message-ID: <1405327075-27831-1-git-send-email-yang.jie@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [143.182.124.21])
 by alsa0.perex.cz (Postfix) with ESMTP id 1D0B62610D2
 for <alsa-devel@alsa-project.org>; Mon, 14 Jul 2014 10:38:35 +0200 (CEST)
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
Cc: mengdong.lin@intel.com, broonie@kernel.org, liam.r.girdwood@intel.com
List-Id: alsa-devel@alsa-project.org

Hi Mark,

Here is the patch series for enable Intel Broadwell/Haswell ADSP
SRAM power gating feature.

Patches 0001~0003 implement FW module persistent area allocate during
FW parse;
Patch 0004 add dummy read to workaround SRAM write missing bytes issue;
Patch 0005 will make SRAM start with all memory banks disabled, and
enabled required banks during boot procedure.

thanks,
Keyon

Jie Yang (5):
  ASoC: Intel: Add persistent area alloc
  ASoC: Intel: Merge wild cat point ADSP DRAM regions
  ASoC: Intel: Use a table for ADSP SRAM shift
  ASoC: Intel: Add dummy read for SRAM block enable
  ASoC: Intel: Start with all memory banks disabled

 sound/soc/intel/sst-dsp-priv.h    |  2 ++
 sound/soc/intel/sst-firmware.c    | 52 ++++++++++++++++++++++++++++++
 sound/soc/intel/sst-haswell-dsp.c | 68 ++++++++++++++++++++++++++++++---------
 3 files changed, 106 insertions(+), 16 deletions(-)

-- 
1.8.3.2
