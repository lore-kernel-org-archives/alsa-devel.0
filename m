From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 0/3] ASoC: dapm: add PGA kcontrol,
	dai_link enhancement &
Date: Tue, 20 Oct 2015 21:08:49 +0530
Message-ID: <1445355532-28310-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 06083266594
 for <alsa-devel@alsa-project.org>; Tue, 20 Oct 2015 17:36:02 +0200 (CEST)
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
Cc: liam.r.girdwood@linux.intel.com, patches.audio@intel.com, broonie@kernel.org, Vinod Koul <vinod.koul@intel.com>
List-Id: alsa-devel@alsa-project.org

This adds few small patches in DAPM which we require for Intel DSPs
Firsts adds support for having kcontrol on PGAs. This is required for
modules which are modelled as PGA but cna be user configurable. Next is new
callback on snd_soc_dai_link_events(). Lastly a macro to return widget
associated with a kcontrol

Jeeja KP (2):
  ASoC: dapm: Add kcontrol support for PGAs
  ASoC: dapm: Add startup & shutdown for dai_links

Mythri P K (1):
  ASoC: dapm: Add snd_soc_dapm_kcontrol_widget()

 include/sound/soc-dapm.h |  3 +++
 sound/soc/soc-dapm.c     | 64 ++++++++++++++++++++++++++++++++++++++++++------
 2 files changed, 60 insertions(+), 7 deletions(-)

-- 
1.9.1
