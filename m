From: Cezary Rojewski <cezary.rojewski@intel.com>
Subject: [PATCH 0/4] ASoC: Intel: Haswell: Adjust machine
	device private
Date: Thu, 22 Aug 2019 13:36:12 +0200
Message-ID: <20190822113616.22702-1-cezary.rojewski@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id C2532F80112
 for <alsa-devel@alsa-project.org>; Thu, 22 Aug 2019 13:36:50 +0200 (CEST)
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
Cc: lgirdwood@gmail.com, Cezary Rojewski <cezary.rojewski@intel.com>, broonie@kernel.org, tiwai@suse.com, pierre-louis.bossart@linux.intel.com
List-Id: alsa-devel@alsa-project.org

Apart from Haswell machines, all other devices have their private data
set to snd_soc_acpi_mach instance.

Changes for HSW/ BDW boards introduced with series:
https://patchwork.kernel.org/cover/10782035/

added support for dai_link platform_name adjustments within card probe
routines. These take for granted private_data points to
snd_soc_acpi_mach whereas for Haswell, it's sst_pdata instead. Change
private context of platform_device - representing machine board - to
address this.

Caught by recent cleanups where content of sst_pdata was moved.
Currently, despite the incorrect cast, dereferenced field points happily
to NULL (uninitialized field), so no panics were observed.

Cezary Rojewski (4):
  ASoC: Intel: Haswell: Adjust machine device private context
  ASoC: Intel: haswell: Simplify device probe
  ASoC: Intel: bdw-rt5677: Simplify device probe
  ASoC: Intel: broadwell: Simplify device probe

 sound/soc/intel/boards/bdw-rt5677.c | 6 +-----
 sound/soc/intel/boards/broadwell.c  | 6 +-----
 sound/soc/intel/boards/haswell.c    | 6 +-----
 sound/soc/intel/common/sst-acpi.c   | 3 ++-
 4 files changed, 5 insertions(+), 16 deletions(-)

-- 
2.17.1
