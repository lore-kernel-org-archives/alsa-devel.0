From: mengdong.lin@linux.intel.com
Subject: [PATCH v2 0/3] ASoC: topology: Add support for FE DAI
	& DAI links
Date: Fri, 15 Jan 2016 16:11:49 +0800
Message-ID: <cover.1452844210.git.mengdong.lin@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id 6884E26057A
 for <alsa-devel@alsa-project.org>; Fri, 15 Jan 2016 09:11:37 +0100 (CET)
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
Cc: Mengdong Lin <mengdong.lin@linux.intel.com>, tiwai@suse.de, mengdong.lin@intel.com, liam.r.girdwood@linux.intel.com, vinod.koul@intel.com, jeeja.kp@intel.com, subhransu.s.prusty@intel.com
List-Id: alsa-devel@alsa-project.org

From: Mengdong Lin <mengdong.lin@linux.intel.com>

This series allows topology to create FE DAI and DAI links from the PCM
topology objects defined by the user space.

History:
v2: Remove first 2 patches in v1 that were accepted.
    Add Ack by Takashi to patch 'ALSA: pcm: Add snd_pcm_rate_range_to_bits()'
    and add his comments on the function's assumption to c file.

Mengdong Lin (3):
  ALSA: pcm: Add snd_pcm_rate_range_to_bits()
  ASoC: topology: Add FE DAIs dynamically
  ASoC: topology: Add FE DAI links dynamically

 include/sound/pcm.h          |   2 +
 include/sound/soc-topology.h |  21 +++--
 include/sound/soc.h          |   2 +-
 sound/core/pcm_misc.c        |  30 +++++++
 sound/soc/soc-topology.c     | 195 ++++++++++++++++++++++++++++++++++---------
 5 files changed, 197 insertions(+), 53 deletions(-)

-- 
2.5.0
