From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 0/5] ASoC: Fix enum ctl accesses in various
	codec drivers
Date: Mon, 29 Feb 2016 18:07:59 +0100
Message-ID: <1456765684-5717-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 2DB71265158
 for <alsa-devel@alsa-project.org>; Mon, 29 Feb 2016 18:08:06 +0100 (CET)
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
Cc: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

Hi,

here are the rest of buggy drivers to be fixed for the wrong ctl
access types to enum ctls.

Again, put Cc to stable appropriately if needed.


thanks,

Takashi

===

Takashi Iwai (5):
  ASoC: ab8500: Fix enum ctl accesses in a wrong type
  ASoC: max98088: Fix enum ctl accesses in a wrong type
  ASoC: max98095: Fix enum ctl accesses in a wrong type
  ASoC: tlv320dac33: Fix enum ctl accesses in a wrong type
  ASoC: wl1273: Fix enum ctl accesses in a wrong type

 sound/soc/codecs/ab8500-codec.c |  8 ++++----
 sound/soc/codecs/max98088.c     |  2 +-
 sound/soc/codecs/max98095.c     |  4 ++--
 sound/soc/codecs/tlv320dac33.c  |  9 ++++-----
 sound/soc/codecs/wl1273.c       | 13 ++++++-------
 5 files changed, 17 insertions(+), 19 deletions(-)

-- 
2.7.2
