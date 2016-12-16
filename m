From: mengdong.lin@linux.intel.com
Subject: [RFC PATCH 0/2] ASoC: Use DMI name in sound card long
	name
Date: Fri, 16 Dec 2016 10:50:13 +0800
Message-ID: <cover.1481856472.git.mengdong.lin@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 830B4267474
 for <alsa-devel@alsa-project.org>; Fri, 16 Dec 2016 03:47:48 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, broonie@kernel.org
Cc: tiwai@suse.de, liam.r.girdwood@linux.intel.com, vinod.koul@intel.com, Mengdong Lin <mengdong.lin@linux.intel.com>, mengdong.lin@intel.com
List-Id: alsa-devel@alsa-project.org

From: Mengdong Lin <mengdong.lin@linux.intel.com>

This series is based on Liam's idea to use DMI name as the sound card
short name in the audio workshop. After testing on serveral machines,
we changed the design a little:
- Not change the card name (short name), keep it simple. So the card ID
  won't change as well.
- Use short name and DMI name together to make a readable and unqique
  long name.

Machine drivers can use a new API to get this feature.

We hope to get aligned on the kernel side at first, then we'll update UCM
code in alsa-lib: when the sound server ask UCM to open a sound card,
UCM will try to find the best configuration file that matches the card
long name, and only if not avaiable, fallback to the default configuration
file that matches the card name (short name).

Liam Girdwood (1):
  ASoC: core: Add API to use DMI name in sound card long name

Mengdong Lin (1):
  ASoC: Intel: Use DMI name for sound card long name in Broadwell
    machine driver

 include/sound/soc.h                |   5 ++
 sound/soc/intel/boards/broadwell.c |   2 +
 sound/soc/soc-core.c               | 134 +++++++++++++++++++++++++++++++++++++
 3 files changed, 141 insertions(+)

-- 
2.5.0
