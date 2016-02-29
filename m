From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 0/9] ASoC: wm*: Fix enum ctl accesses
Date: Mon, 29 Feb 2016 18:01:09 +0100
Message-ID: <1456765278-5435-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 49E3E26084B
 for <alsa-devel@alsa-project.org>; Mon, 29 Feb 2016 18:01:27 +0100 (CET)
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
Cc: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, Mark Brown <broonie@kernel.org>, Richard Fitzgerald <rf@opensource.wolfsonmicro.com>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

Hi,

here is a patchset for correcting the wrong access types to the enum
ctl values in various wm* codec drivers.

I didn't put Cc to stable.  If they might be used for 64 bit
architectures, it's a real problem.  In that case, feel free to put Cc
to stable.


thanks,

Takashi

===

Takashi Iwai (9):
  ASoC: wm8753: Fix enum ctl accesses in a wrong type
  ASoC: wm8904: Fix enum ctl accesses in a wrong type
  ASoC: wm8958: Fix enum ctl accesses in a wrong type
  ASoC: wm8983: Fix enum ctl accesses in a wrong type
  ASoC: wm8985: Fix enum ctl accesses in a wrong type
  ASoC: wm8994: Fix enum ctl accesses in a wrong type
  ASoC: wm8996: Fix enum ctl accesses in a wrong type
  ASoC: wm9081: Fix enum ctl accesses in a wrong type
  ASoC: wm_adsp: Fix enum ctl accesses in a wrong type

 sound/soc/codecs/wm8753.c      |  6 +++---
 sound/soc/codecs/wm8904.c      |  4 ++--
 sound/soc/codecs/wm8958-dsp2.c |  8 ++++----
 sound/soc/codecs/wm8983.c      | 14 +++++++-------
 sound/soc/codecs/wm8985.c      | 14 +++++++-------
 sound/soc/codecs/wm8994.c      |  4 ++--
 sound/soc/codecs/wm8996.c      |  2 +-
 sound/soc/codecs/wm9081.c      |  8 ++++----
 sound/soc/codecs/wm_adsp.c     |  8 ++++----
 9 files changed, 34 insertions(+), 34 deletions(-)

-- 
2.7.2
