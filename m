From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 0/3] ASoC: Kill BUG_ON() usages
Date: Thu,  7 Sep 2017 10:59:15 +0200
Message-ID: <20170907085918.4496-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 007B2267478
 for <alsa-devel@alsa-project.org>; Thu,  7 Sep 2017 10:59:29 +0200 (CEST)
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

I found a few stupid BUG_ON() usages in the code, let's kill or
replace them.


Takashi

===

Takashi Iwai (3):
  ASoC: tas571x: Kill BUG_ON() usage
  ASoC: davinci: Kill BUG_ON() usage
  ASoC: intel: Kill BUG_ON() usage

 sound/soc/codecs/tas571x.c            | 3 ++-
 sound/soc/davinci/davinci-mcasp.c     | 3 ++-
 sound/soc/intel/atom/sst/sst_loader.c | 1 -
 sound/soc/intel/atom/sst/sst_stream.c | 1 -
 4 files changed, 4 insertions(+), 4 deletions(-)

-- 
2.14.1
