From: Jie Yang <yang.jie@intel.com>
Subject: [PATCH v2 0/4] ASoC: Intel: Enable BDW/HSW SRAM power
	gating
Date: Mon, 14 Jul 2014 17:11:08 +0800
Message-ID: <1405329072-28679-1-git-send-email-yang.jie@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 8DBF326172C
 for <alsa-devel@alsa-project.org>; Mon, 14 Jul 2014 11:12:17 +0200 (CEST)
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

Patches 0001~0002 merge wcp DRAM regions and correct the SRAM bit shift
for it;

Patch 0003 add dummy read to workaround SRAM write missing bytes issue;

Patch 0004 will make SRAM start with all memory banks disabled, and
enabled required banks during boot procedure.

thanks,
Keyon

Changes in v2:
* remove the Add persistent area alloc patch, for it is not so related
  with power gating feature.

Jie Yang (4):
  ASoC: Intel: Merge wild cat point ADSP DRAM regions
  ASoC: Intel: Use a table for ADSP SRAM shift
  ASoC: Intel: Add dummy read for SRAM block enable
  ASoC: Intel: Start with all memory banks disabled

 sound/soc/intel/sst-haswell-dsp.c | 61 +++++++++++++++++++++++++++++----------
 1 file changed, 46 insertions(+), 15 deletions(-)

-- 
1.8.3.2
