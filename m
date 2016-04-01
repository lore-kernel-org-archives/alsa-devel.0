From: han.lu@intel.com
Subject: [PATCH V4 0/2] ASoC: share more product information
	with user space
Date: Fri,  1 Apr 2016 13:46:30 +0800
Message-ID: <cover.1459488225.git.han.lu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 810D926506E
 for <alsa-devel@alsa-project.org>; Fri,  1 Apr 2016 07:45:26 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org, tiwai@suse.de, vinod.koul@intel.com, pierre-louis.bossart@linux.intel.com, liam.r.girdwood@linux.intel.com, alsa-devel@alsa-project.org
Cc: "Lu, Han" <han.lu@intel.com>
List-Id: alsa-devel@alsa-project.org

From: "Lu, Han" <han.lu@intel.com>

 Share more product information, so user space utils such as PA and UCM can
 distinguish different products.
  1. Add a core API.
  2. Apply the API to bytcr-rt5640 driver.
    
 changes on V4:
  1. Replace kmalloc() and snprintf() with ksaprintf() to simplify code

 changes on V3:
  1. Split the core API and the API call to two patches
  2. Replace misused strcat() with snprintf()
  3. Code and comment fix 
	  
Lu, Han (2):
  ASoC: core: add API for registering DMI card names
  ASoC: bytcr-rt5640: register DMI names to card

 include/sound/soc.h                   |  3 ++
 sound/soc/intel/boards/bytcr_rt5640.c | 15 ++++++++++
 sound/soc/soc-core.c                  | 56 +++++++++++++++++++++++++++++++++++
 3 files changed, 74 insertions(+)

-- 
2.5.0
