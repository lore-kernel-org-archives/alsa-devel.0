From: Benoit Cousson <bcousson@baylibre.com>
Subject: [PATCH v5 0/5] ASoC: core: Add support for DAI
	multicodec
Date: Fri,  4 Jul 2014 18:07:50 +0200
Message-ID: <1404490075-24997-1-git-send-email-bcousson@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wg0-f52.google.com (mail-wg0-f52.google.com [74.125.82.52])
 by alsa0.perex.cz (Postfix) with ESMTP id 9499B2659C4
 for <alsa-devel@alsa-project.org>; Fri,  4 Jul 2014 18:08:02 +0200 (CEST)
Received: by mail-wg0-f52.google.com with SMTP id b13so1848584wgh.35
 for <alsa-devel@alsa-project.org>; Fri, 04 Jul 2014 09:08:02 -0700 (PDT)
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

Here is the fifth version of the multicodec series.

It mostly fixes the remaining comments from Lars on the series.
It removes as well the support for soc-compress.c based on Vinod
comment.

Please note that I have a very simple setup based on BBB to check if the series
is working, so it will be good to test it on various platforms to ensure
this is not generating any regression.

The series is based on asoc/for-next (v3.16-rc3).

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

v5:
- Remove multicodec support for soc-compress
- Simplify the code a little thanks to Lars component series


Benoit Cousson (5):
  ASoC: core: Add initial support for DAI multicodec
  ASoC: pcm: Add support for DAI multicodec
  ASoC: dapm: Add support for DAI multicodec
  ASoC: compress: Prevent multicodec for compressed stream
  ASoC: pcm: Add soc_dai_hw_params helper

 include/sound/soc-dai.h  |   4 +
 include/sound/soc.h      |  17 ++
 sound/soc/soc-compress.c |   5 +
 sound/soc/soc-core.c     | 293 +++++++++++++++++--------
 sound/soc/soc-dapm.c     |  95 ++++----
 sound/soc/soc-pcm.c      | 555 ++++++++++++++++++++++++++++++++---------------
 6 files changed, 665 insertions(+), 304 deletions(-)

-- 
1.9.1
