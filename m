From: mengdong.lin@linux.intel.com
Subject: [PATCH v3 0/2] ASoC: topology: Add support for FE DAI
	& DAI links
Date: Tue, 16 Feb 2016 13:39:37 +0800
Message-ID: <cover.1455599774.git.mengdong.lin@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id A76842655DB
 for <alsa-devel@alsa-project.org>; Tue, 16 Feb 2016 06:38:52 +0100 (CET)
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
Cc: Mengdong Lin <mengdong.lin@linux.intel.com>, vinod.koul@intel.com, hardik.t.shah@intel.com, liam.r.girdwood@linux.intel.com, mengdong.lin@intel.com, jeeja.kp@intel.com, subhransu.s.prusty@intel.com
List-Id: alsa-devel@alsa-project.org

From: Mengdong Lin <mengdong.lin@linux.intel.com>

This series allows topology to create FE DAI and DAI links from the PCM
topology objects defined by the user space.

History:
v2: Remove first 2 patches in v1 that were accepted.
    Add Ack by Takashi to patch 'ALSA: pcm: Add snd_pcm_rate_range_to_bits()'
    and add his comments on the function's assumption to c file.


v3: remove 1st patch in v2 that was accepted.
    Revise setting of a stream's rates/rate_min/rate_max as Lars suggested.

Mengdong Lin (2):
  ASoC: topology: Add FE DAIs dynamically
  ASoC: topology: Add FE DAI links dynamically

 include/sound/soc-topology.h |  21 +++--
 include/sound/soc.h          |   2 +-
 sound/soc/soc-topology.c     | 195 ++++++++++++++++++++++++++++++++++---------
 3 files changed, 165 insertions(+), 53 deletions(-)

-- 
2.5.0
