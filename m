From: Kirill Marinushkin <kmarinushkin@birdec.tech>
Subject: [PATCH 0/1] ASoC: pcm3060: Add codec driver
Date: Tue, 21 Aug 2018 18:52:45 +0200
Message-ID: <20180821165246.9479-1-kmarinushkin@birdec.tech>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from host.euro-space.net (host.euro-space.net [87.117.239.2])
 by alsa0.perex.cz (Postfix) with ESMTP id 0FBA126766E
 for <alsa-devel@alsa-project.org>; Tue, 21 Aug 2018 18:52:25 +0200 (CEST)
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
Cc: alsa-devel@alsa-project.org, Kirill Marinushkin <kmarinushkin@birdec.tech>, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Vishwas A Deshpande <vishwas.a.deshpande@ti.com>, M R Swami Reddy <mr.swami.reddy@ti.com>, Kevin Cernekee <cernekee@chromium.org>
List-Id: alsa-devel@alsa-project.org

Hello Mark,

I am developing sound support for a Linux-based device, with playback and
capture through the TI PCM3060 codec.

With the following patch, I propose to add the PCM3060 codec driver into
the kernel.

Best Regards,
Kirill

Kirill Marinushkin (1):
  ASoC: pcm3060: Add codec driver

 .../devicetree/bindings/sound/pcm3060.txt          |  17 ++
 MAINTAINERS                                        |   7 +
 sound/soc/codecs/Kconfig                           |  17 ++
 sound/soc/codecs/Makefile                          |   6 +
 sound/soc/codecs/pcm3060-i2c.c                     |  61 +++++
 sound/soc/codecs/pcm3060-spi.c                     |  60 +++++
 sound/soc/codecs/pcm3060.c                         | 290 +++++++++++++++++++++
 sound/soc/codecs/pcm3060.h                         |  88 +++++++
 8 files changed, 546 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/pcm3060.txt
 create mode 100644 sound/soc/codecs/pcm3060-i2c.c
 create mode 100644 sound/soc/codecs/pcm3060-spi.c
 create mode 100644 sound/soc/codecs/pcm3060.c
 create mode 100644 sound/soc/codecs/pcm3060.h

-- 
2.13.6
