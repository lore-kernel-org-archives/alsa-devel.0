From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 00/21] ASoC: Use static DAI format setup
Date: Thu,  1 Jan 2015 17:16:09 +0100
Message-ID: <1420128990-6872-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-118.synserver.de (smtp-out-118.synserver.de
 [212.40.185.118])
 by alsa0.perex.cz (Postfix) with ESMTP id 13E2E2604B1
 for <alsa-devel@alsa-project.org>; Thu,  1 Jan 2015 17:16:35 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>, Sangbeom Kim <sbkim73@samsung.com>, Denis Carikli <denis@eukrea.com>, Manuel Lauss <manuel.lauss@googlemail.com>, Bo Shen <voice.shen@atmel.com>, Shawn Guo <shawn.guo@linaro.org>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Daniel Mack <daniel@zonque.org>
List-Id: alsa-devel@alsa-project.org

There is still a rather large amount of board driver which manually call
snd_soc_dai_set_fmt() for both the CPU and the CODEC DAI, while pretty much
all of them can use static DAI setup by setting the dai_fmt field in the
snd_soc_dai_link struct.

Using the later method results in shorter and cleaner code and will also
make it easier to eventually switch to a component type independent way to
specify the clock master/slave settings (Right now the meaning of the value
depends on whether a DAI belongs to a CODEC or not).

This series converts all the trivial cases of snd_soc_dai_set_fmt() users to
use the dai_fmt field instead.

- Lars

Lars-Peter Clausen (21):
  ASoC: sam9g20_wm8731: Use static DAI format setup
  ASoC: db1200: Use static DAI format setup
  ASoC: eureka-tlv320: Use static DAI format setup
  ASoC: mx27vis-aci32x4: Use static DAI format setup
  ASoC: wm1133-ev1: Use static DAI format setup
  ASoC: mxs-sgtl5000: Use static DAI format setup
  ASoC: ams-delta: Use static DAI format setup
  ASoC: raumfeld: Use static DAI format setup
  ASoC: zylonite: Use static DAI format setup
  ASoC: goni_wm8994: Use static DAI format setup
  ASoC: h1940_uda1380: Use static DAI format setup
  ASoC: jive_wm8750: Use static DAI format setup
  ASoC: neo1973_wm8753: Use static DAI format setup
  ASoC: rx1950_uda1380: Use static DAI format setup
  ASoC: s3c24xx_simtec: Use static DAI format setup
  ASoC: s3c24xx_uda134x: Use static DAI format setup
  ASoC: smartq_wm8987: Use static DAI format setup
  ASoC: smdk_wm8580: Use static DAI format setup
  ASoC: smdk_wm8570pcm: Use static DAI format setup
  ASoC: smdk_wm8994pcm: Use static DAI format setup
  ASoC: migor: Use static DAI format setup

 sound/soc/atmel/sam9g20_wm8731.c    | 30 ++----------------------------
 sound/soc/au1x/db1200.c             | 19 +++----------------
 sound/soc/fsl/eukrea-tlv320.c       | 21 ++-------------------
 sound/soc/fsl/mx27vis-aic32x4.c     | 12 ++----------
 sound/soc/fsl/wm1133-ev1.c          | 12 ++----------
 sound/soc/mxs/mxs-sgtl5000.c        | 27 ++++++---------------------
 sound/soc/omap/ams-delta.c          | 18 +++---------------
 sound/soc/pxa/raumfeld.c            | 35 ++++++++---------------------------
 sound/soc/pxa/zylonite.c            | 12 ++----------
 sound/soc/samsung/goni_wm8994.c     | 23 ++++-------------------
 sound/soc/samsung/h1940_uda1380.c   | 15 ++-------------
 sound/soc/samsung/jive_wm8750.c     | 16 ++--------------
 sound/soc/samsung/neo1973_wm8753.c  | 25 ++++---------------------
 sound/soc/samsung/rx1950_uda1380.c  | 15 ++-------------
 sound/soc/samsung/s3c24xx_simtec.c  | 20 ++------------------
 sound/soc/samsung/s3c24xx_uda134x.c | 12 ++----------
 sound/soc/samsung/smartq_wm8987.c   | 16 ++--------------
 sound/soc/samsung/smdk_wm8580.c     | 21 ++++++---------------
 sound/soc/samsung/smdk_wm8580pcm.c  | 19 +++++--------------
 sound/soc/samsung/smdk_wm8994pcm.c  | 16 ++--------------
 sound/soc/sh/migor.c                | 12 ++----------
 21 files changed, 65 insertions(+), 331 deletions(-)

-- 
1.8.0
