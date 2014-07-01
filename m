From: Benoit Cousson <bcousson@baylibre.com>
Subject: [PATCH v4 0/8] ASoC: core: Add support for DAI
	multicodec
Date: Tue,  1 Jul 2014 09:47:53 +0200
Message-ID: <1404200881-32253-1-git-send-email-bcousson@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wi0-f182.google.com (mail-wi0-f182.google.com
 [209.85.212.182])
 by alsa0.perex.cz (Postfix) with ESMTP id 1637F264F03
 for <alsa-devel@alsa-project.org>; Tue,  1 Jul 2014 09:48:22 +0200 (CEST)
Received: by mail-wi0-f182.google.com with SMTP id bs8so7243279wib.3
 for <alsa-devel@alsa-project.org>; Tue, 01 Jul 2014 00:48:21 -0700 (PDT)
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

Hi Lars, Mark and Liam,

Sorry for the delay. Here is the fourth version of the multicodec series.

I had to split it in smaller chunks since the previous patch was exceeding the 
size limit of the ML :-(

I think (and hope) I did address all the v3 comments from Lars.

I did not address the codec to codec link in multicodec case as suggested
by Lars.

There is still an open point about enforcing the number of channels for the
CPU dai in case the TDM slots are set for the CODEC dais.
I guess this point could be addressed later.

Please note that I have a very simple setup based on BBB to check if the series
is working, so it will be good to test it on various platforms to ensure
this is not generating any regression.

The series is based on asoc/for-next (v3.16-rc1).

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

v4:
- Improve the TDM management
- Split the orginal patch in smaller chunks
- Ignore the CODEC to CODEC link case for the moment
- Add iteration for multicodecs everywhere


Benoit Cousson (8):
  ASoC: core: Change soc_link_dai_widgets signature for multiple codecs
  ASoC: pcm: Refactor soc_pcm_apply_msb for multicodecs
  ASoC: core: Add initial support for DAI multicodec
  ASoC: pcm: Add support for DAI multicodec
  ASoC: dapm: Add support for DAI multicodec
  ASoC: compress: Add support for DAI multicodec
  ASoC: pcm: Add soc_dai_hw_params helper
  ASoC: core: Add a warning for link_dai_widget in the multicodec case

 include/sound/soc-dai.h  |   4 +
 include/sound/soc.h      |  17 ++
 sound/soc/soc-compress.c |  94 +++++---
 sound/soc/soc-core.c     | 348 +++++++++++++++++++----------
 sound/soc/soc-dapm.c     |  93 ++++----
 sound/soc/soc-pcm.c      | 563 ++++++++++++++++++++++++++++++++---------------
 6 files changed, 751 insertions(+), 368 deletions(-)

-- 
1.9.1
