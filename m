From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 0/7] ASoC: Constify hw_constraints
Date: Thu,  8 Jun 2017 23:37:18 +0200
Message-ID: <20170608213725.5378-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id BD3922673DA
 for <alsa-devel@alsa-project.org>; Thu,  8 Jun 2017 23:37:33 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, Vinod Koul <vinod.koul@intel.com>, Brian Austin <brian.austin@cirrus.com>, Krzysztof Kozlowski <krzk@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Paul Handrigan <Paul.Handrigan@cirrus.com>, Matthias Brugger <matthias.bgg@gmail.com>
List-Id: alsa-devel@alsa-project.org

Hi,

this is a series of trivial patches to add const prefix appropriately
to the possible hw_constraint static objects like the previous
patchset for other ALSA drivers.  It's just for hardening.


thanks,

Takashi

===

Takashi Iwai (7):
  ASoC: cs35l34: Constify hw_constraints
  ASoC: cs53l30: Constify hw_constraints
  ASoC: intel: bxt: Constify hw_constraints
  ASoC: intel: byt: Constify hw_constraints
  ASoC: intel: skl: Constify hw_constraints
  ASoC: mediatek: Constify hw_constraints
  ASoC: samsung: Constify hw_constraints

 sound/soc/codecs/cs35l34.c                      |  4 ++--
 sound/soc/codecs/cs53l30.c                      |  2 +-
 sound/soc/intel/boards/bxt_da7219_max98357a.c   | 12 ++++++------
 sound/soc/intel/boards/bxt_rt298.c              | 12 ++++++------
 sound/soc/intel/boards/bytcht_nocodec.c         |  4 ++--
 sound/soc/intel/boards/bytcr_rt5651.c           |  4 ++--
 sound/soc/intel/boards/skl_nau88l25_max98357a.c | 16 ++++++++--------
 sound/soc/intel/boards/skl_nau88l25_ssm4567.c   | 16 ++++++++--------
 sound/soc/intel/boards/skl_rt286.c              | 12 ++++++------
 sound/soc/mediatek/mt2701/mt2701-cs42448.c      |  2 +-
 sound/soc/samsung/s3c24xx_uda134x.c             |  2 +-
 11 files changed, 43 insertions(+), 43 deletions(-)

-- 
2.13.0
