From: Jerome Brunet <jbrunet@baylibre.com>
Subject: [PATCH 0/2] ASoC: dpcm: add runtime rate merge of BE.
Date: Thu,  5 Jul 2018 12:13:47 +0200
Message-ID: <20180705101349.7520-1-jbrunet@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f68.google.com (mail-wm0-f68.google.com [74.125.82.68])
 by alsa0.perex.cz (Postfix) with ESMTP id 4867C267214
 for <alsa-devel@alsa-project.org>; Thu,  5 Jul 2018 12:13:57 +0200 (CEST)
Received: by mail-wm0-f68.google.com with SMTP id v16-v6so10176104wmv.5
 for <alsa-devel@alsa-project.org>; Thu, 05 Jul 2018 03:13:57 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Jerome Brunet <jbrunet@baylibre.com>
List-Id: alsa-devel@alsa-project.org

This patchset adds the possibility to merge BE rates in the dpcm runtime
hw, like it is done for formats and channels.

This first patch is a simple rework of format and channel merge to ease
the addition of rate merge.

Jerome Brunet (2):
  ASoC: dpcm: rework runtime stream merge
  ASoC: dpcm: add rate merge to the BE stream merge

 include/sound/soc.h |  2 ++
 sound/soc/soc-pcm.c | 99 ++++++++++++++++++++++++++++++++++++++++-------------
 2 files changed, 77 insertions(+), 24 deletions(-)

-- 
2.14.4
