From: Benoit Cousson <bcousson@baylibre.com>
Subject: [RFT v3 0/3] ASoC: core: Add support for DAI multicodec
Date: Thu, 24 Apr 2014 14:01:43 +0200
Message-ID: <1398340906-5017-1-git-send-email-bcousson@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wi0-f173.google.com (mail-wi0-f173.google.com
 [209.85.212.173])
 by alsa0.perex.cz (Postfix) with ESMTP id 80DE026525B
 for <alsa-devel@alsa-project.org>; Thu, 24 Apr 2014 14:02:01 +0200 (CEST)
Received: by mail-wi0-f173.google.com with SMTP id z2so921231wiv.12
 for <alsa-devel@alsa-project.org>; Thu, 24 Apr 2014 05:02:01 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org, lgirdwood@gmail.com, lars@metafoo.de
Cc: misael.lopez@ti.com, alsa-devel@alsa-project.org, Benoit Cousson <bcousson@baylibre.com>
List-Id: alsa-devel@alsa-project.org

Hi Mark, Liam and Lars,

Sorry for the delay. Here is the third version of the multicodec series.

I changed the way to store the multiple codec_dai as suggested by Lars and
added the missing iterations in all the places pointed by Lars in his comments.

Please note that I have a very simple setup based on BBB to check if the series
is working, so it will be good to test it on various platforms to ensure
this is not generating any regression. Hence this version is still RFT.

The series is based on asoc/for-next (v3.15-rc2).

Test and comments are welcome.

Thanks,
Benoit


v1: http://comments.gmane.org/gmane.linux.alsa.devel/120532

v2: http://comments.gmane.org/gmane.linux.alsa.devel/121024
- Split the first version in several patches.
- Remove the TDM fixup 

v3: 
- Fixed all the places that were not iterating over all the codecs.
- Change the structure and split it.


Benoit Cousson (2):
  ASoC: core: Add one dai_get_widget helper instead of two rtd based ones
  ASoC: core: Add support for DAI multicodec

Misael Lopez Cruz (1):
  ASoC: core: Add helpers for dai link and aux dev init

 include/sound/soc-dai.h  |   5 +
 include/sound/soc.h      |  13 ++
 sound/soc/soc-compress.c |  83 +++++---
 sound/soc/soc-core.c     | 401 +++++++++++++++++++++++++----------
 sound/soc/soc-dapm.c     |  71 ++++---
 sound/soc/soc-pcm.c      | 529 +++++++++++++++++++++++++++++++----------------
 6 files changed, 763 insertions(+), 339 deletions(-)

-- 
1.8.3.2
