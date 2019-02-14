From: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Subject: [PATCH v2 0/2] ASoC: da7219: BCLK and TDM flexibility
	improvements
Date: Thu, 14 Feb 2019 10:13:28 +0000
Message-ID: <cover.1550138803.git.Adam.Thomson.Opensource@diasemi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.bemta26.messagelabs.com (mail1.bemta26.messagelabs.com
 [85.158.142.1]) by alsa0.perex.cz (Postfix) with ESMTP id B8E3F267482
 for <alsa-devel@alsa-project.org>; Thu, 14 Feb 2019 11:13:32 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Takashi Iwai <tiwai@suse.com>, Jaroslav Kysela <perex@perex.cz>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Support Opensource <support.opensource@diasemi.com>, Akshu Agrawal <Akshu.Agrawal@amd.com>
List-Id: alsa-devel@alsa-project.org

This patch set updates the driver to be more flexible regarding the BCLK and
TDM configurations of the device.

Previously the BCLK rate was fixed at 64 periods per WCLK, when the codec is
DAI clock master, but to satisfy devices which prefer a lower rate, and to save
power, the BCLK rate is now calculated based on hw_params() data.

As a fallout of the BCLK efforts it was also apparent that the TDM code could be
made more flexible as well. The device is capable of automatically detecting
the BCLK rate when it is clock slave, so previous limitations imposed were
not necessary. The mask handling is now used as an input to determine the BCLK
offset to align closer with other examples within ALSA.

Changes in v2:
 - Update 0001 patch to use '&&' instead of '&' in hw_params() to decide if
   BCLK rate should be configured or not.

Adam Thomson (2):
  ASoC: da7219: Add support for master mode BCLK rate adjustment
  ASoC: da7219: Update TDM usage to be more flexible

 sound/soc/codecs/da7219.c | 116 +++++++++++++++++++++++++++++-----------------
 sound/soc/codecs/da7219.h |   1 +
 2 files changed, 74 insertions(+), 43 deletions(-)

-- 
1.9.1
