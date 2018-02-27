From: =?UTF-8?q?Myl=C3=A8ne=20Josserand?= <mylene.josserand@bootlin.com>
Subject: [PATCH v1 0/4] ASoC: Add support for DAC PCM1789
Date: Tue, 27 Feb 2018 22:24:29 +0100
Message-ID: <20180227212433.2189-1-mylene.josserand@bootlin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com, perex@perex.cz, tiwai@suse.com
Cc: alsa-devel@alsa-project.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, mylene.josserand@bootlin.com, alexandre.belloni@bootlin.com, thomas.petazzoni@bootlin.com
List-Id: alsa-devel@alsa-project.org

Hello everyone,

You will find in this series the support of Texas Instrument's DAC
PCM1789.
This DAC is very minimalist and is similar to PCM1792a except for
some differences in registers.
Series based on asoc tree, "for-next" branch (last commit 130c3888dfdc).

It is important to notice that this DAC needs to always have clocks
enabled (even without any data) otherwise it will be in a "desynchronized"
state and can not send data correctly.
This issue has been solved by performing a reset each time a sound
is played (see patch 04). This reset can produce a "pop" noise.

Thank you in advance for any review.

Best regards,
Mylène

Mylène Josserand (4):
  ASoC: codecs: pcm179x: Add PCM1789 id
  ASoC: codecs: pcm179x: Add support for PCM1789
  ASoC: codecs: pcm179x: Add reset gpio
  ASoC: codecs: pcm179x: Add trigger function to perform a reset

 .../devicetree/bindings/sound/pcm179x.txt          |   2 +-
 sound/soc/codecs/pcm179x-i2c.c                     |  17 +-
 sound/soc/codecs/pcm179x.c                         | 242 ++++++++++++++++++++-
 sound/soc/codecs/pcm179x.h                         |  10 +-
 4 files changed, 264 insertions(+), 7 deletions(-)

-- 
2.11.0
