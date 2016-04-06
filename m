From: han.lu@intel.com
Subject: [PATCH V6 0/2] ASoC: Add core API to register and
	cleanup DMI names for card
Date: Wed,  6 Apr 2016 12:43:20 +0800
Message-ID: <cover.1459917632.git.han.lu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 15496265756
 for <alsa-devel@alsa-project.org>; Wed,  6 Apr 2016 06:42:26 +0200 (CEST)
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

 Share more product information, for user space utils such as PA and UCM to
 distinguish different products.
  1. Add core APIs to register and cleanup DMI names for card.
  2. Apply the APIs to bytcr-rt5640 driver.

 changes on V6:
  1. Use dynamic allocate and cleanup for card long name
  2. Remove unneccessary arguments to simplify the API
  
 changes on V5:
  1. Use independent space to store card long_name, to avoid irrelavant
  info sharing from card component
  2. Use letter ';' instead of ':' to separate strings in long name, in
  case name strings may also contain ':' and confuse user
  3. Fix error that vendor name and firmware name were not optional 
   
 changes on V4:
  1. Replace kmalloc() and snprintf() with ksaprintf() to simplify code
    
 changes on V3:
  1. Split the core API and the API call to two patches
  2. Replace misused strcat() with snprintf()
  3. Code and comment fix 

Lu, Han (2):
  ASoC: core: add API for registering and cleaning up DMI card names
  ASoC: bytcr-rt5640: register DMI names for card

 include/sound/soc.h                   |  3 ++
 sound/soc/intel/boards/bytcr_rt5640.c | 18 ++++++++
 sound/soc/soc-core.c                  | 87 +++++++++++++++++++++++++++++++++++
 3 files changed, 108 insertions(+)

-- 
2.5.0
