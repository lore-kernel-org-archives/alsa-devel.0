From: Benoit Cousson <bcousson@baylibre.com>
Subject: [PATCH v6 0/5] ASoC: core: Add support for DAI
	multicodec
Date: Tue,  8 Jul 2014 23:19:33 +0200
Message-ID: <1404854378-25828-1-git-send-email-bcousson@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wi0-f169.google.com (mail-wi0-f169.google.com
 [209.85.212.169])
 by alsa0.perex.cz (Postfix) with ESMTP id 18FA2261A7E
 for <alsa-devel@alsa-project.org>; Tue,  8 Jul 2014 23:19:59 +0200 (CEST)
Received: by mail-wi0-f169.google.com with SMTP id hi2so1808841wib.2
 for <alsa-devel@alsa-project.org>; Tue, 08 Jul 2014 14:19:58 -0700 (PDT)
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

Here is the sixth, and hopefully the last, version of the multicodec series.

I've just removed the broken test I forgot to remove last time.

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

v6:
- Remove a broken test in snd_soc_runtime_ignore_pmdown_time

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
