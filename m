From: Benoit Cousson <bcousson@baylibre.com>
Subject: [RFT v2 0/6] ASoC: core: Add support for DAI multicodec
Date: Fri, 21 Mar 2014 16:27:24 +0100
Message-ID: <1395415650-20045-1-git-send-email-bcousson@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wi0-f180.google.com (mail-wi0-f180.google.com
 [209.85.212.180])
 by alsa0.perex.cz (Postfix) with ESMTP id EABCE2610A7
 for <alsa-devel@alsa-project.org>; Fri, 21 Mar 2014 16:27:45 +0100 (CET)
Received: by mail-wi0-f180.google.com with SMTP id hn9so626079wib.1
 for <alsa-devel@alsa-project.org>; Fri, 21 Mar 2014 08:27:45 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org, lgirdwood@gmail.com
Cc: alsa-devel@alsa-project.org, lars@metafoo.de, Benoit Cousson <bcousson@baylibre.com>
List-Id: alsa-devel@alsa-project.org

Hi Mark and Liam,

Here is the second version of the multicodec series. I mostly rebased the code
to asoc-next, added smaller patches to introduce helpers before the main patch
and thus reduce the overal size of that patch and modified the TDM slot fixup.

Please note that I have a very simple setup based on BBB to check if the series
is working, so it will be good to test the series on various setup to ensure
this is not generating any regression.
Hence the RFT for this version.

The series is based on asoc-v3.15-2-245-g876dea8.

Test and comments are welcome.

Thanks,
Benoit

v1: http://comments.gmane.org/gmane.linux.alsa.devel/120532

v2:
- Split the first version in several patches.
- Remove the TDM fixup 


---
Misael Lopez Cruz (6):
  ASoC: core: Add helpers for codec and codec_dai search
  ASoC: core: Add helpers for codec DAI probe & remove
  ASoC: core: Add helper for DAI widgets linking
  ASoC: core: Add function for ac97 codec registration
  ASoC: core: Add helpers for dai link and aux dev init
  ASoC: core: Add support for DAI multicodec

 include/sound/soc-dai.h |   5 +
 include/sound/soc.h     |  16 ++
 sound/soc/soc-core.c    | 578 ++++++++++++++++++++++++++++++++++--------------
 sound/soc/soc-dapm.c    |  39 +++-
 sound/soc/soc-pcm.c     | 438 +++++++++++++++++++++++++-----------
 5 files changed, 761 insertions(+), 315 deletions(-)

-- 
1.8.3.2
