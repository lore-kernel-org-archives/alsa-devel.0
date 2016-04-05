From: han.lu@intel.com
Subject: [PATCH V5 0/2] ASoC: Add core API to register DMI
	names to card
Date: Tue,  5 Apr 2016 12:26:32 +0800
Message-ID: <cover.1459825282.git.han.lu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 979D32608CF
 for <alsa-devel@alsa-project.org>; Tue,  5 Apr 2016 06:25:51 +0200 (CEST)
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
  1. Add a core API to register DMI names to card.
  2. Apply the API to bytcr-rt5640 driver.
 
 changes on V5:
  1. Use independent space to store card long_name, to avoid irrelavant
  info sharing from card component
  2. Use letter ';' instead of ':' to separate strings in long name, in
  case name strings may also contain ':' and confusing user
  3. Fix error that vendor name and firmware name were not optional 

 changes on V4:
  1. Replace kmalloc() and snprintf() with ksaprintf() to simplify code
 
 changes on V3:
  1. Split the core API and the API call to two patches
  2. Replace misused strcat() with snprintf()
  3. Code and comment fix 

Lu, Han (2):
  ASoC: core: add API for registering DMI card names
  ASoC: bytcr-rt5640: register DMI names for card

 include/sound/soc.h                   |  3 ++
 sound/soc/intel/boards/bytcr_rt5640.c | 13 +++++++
 sound/soc/soc-core.c                  | 67 +++++++++++++++++++++++++++++++++++
 3 files changed, 83 insertions(+)

-- 
2.5.0
