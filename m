From: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
Subject: [PATCH v3 0/3] ASoC: Intel: Skylake: Add Support for
	MIC select module
Date: Wed, 31 May 2017 10:30:23 +0530
Message-ID: <1496206826-28125-1-git-send-email-subhransu.s.prusty@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id 7F09E2668BF
 for <alsa-devel@alsa-project.org>; Wed, 31 May 2017 07:14:53 +0200 (CEST)
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
Cc: tiwai@suse.de, patches.audio@intel.com, broonie@kernel.org, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

This series adds support in DSP to add support for MIC select module which
allows user to select 1 to N channels from DMIC channel input.

Further it also adds support in bxt-rt298 machine for such a module.

Changes in v2:
	- check for index in array range

Changes in v3:
	- Use enumerated value instead of integer
	- Use c99 style initialization for kcontrol ops

Dharageswari R (3):
  ASoC: Intel: Skylake: Add mic-select module type
  ASoC: Intel: Skylake: Add enum control for mic selection
  ASoC: Intel: Boards: Add 4-channel DMIC fixup.

 sound/soc/intel/boards/bxt_rt298.c           |   7 +-
 sound/soc/intel/skylake/skl-messages.c       |   2 +
 sound/soc/intel/skylake/skl-topology.c       | 159 +++++++++++++++++++++++++++
 sound/soc/intel/skylake/skl-topology.h       |  20 ++++
 sound/soc/intel/skylake/skl-tplg-interface.h |   2 +
 5 files changed, 185 insertions(+), 5 deletions(-)

-- 
1.9.1
