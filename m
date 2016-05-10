From: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Subject: [PATCH 0/5] ASoC: da7213: clocking related
	improvements for codec
Date: Tue, 10 May 2016 16:11:03 +0100
Message-ID: <cover.1462892732.git.Adam.Thomson.Opensource@diasemi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.bemta5.messagelabs.com (mail1.bemta5.messagelabs.com
 [195.245.231.137])
 by alsa0.perex.cz (Postfix) with ESMTP id EB9DC261600
 for <alsa-devel@alsa-project.org>; Tue, 10 May 2016 17:11:04 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Support Opensource <support.opensource@diasemi.com>
List-Id: alsa-devel@alsa-project.org

This is a collection of updates with regards to clocking on da7213 codec,
including power efficiency & stability improvements.

Patches are based on v4.6-rc7 kernel.

Adam Thomson (5):
  ASoC: da7213: Add DAI DAPM event to control DAI clocks
  ASoC: da7213: Add checking of SRM lock status before enabling DAI
  ASoC: da7213: Default PC counter to free-running when DAI disabled
  ASoC: da7213: Update PLL ranges to improve locking at frequency
    boundary
  ASoC: da7213: Allow PLL disable/bypass when using 32KHz sysclk

 sound/soc/codecs/da7213.c | 99 +++++++++++++++++++++++++++++++++++++++--------
 sound/soc/codecs/da7213.h | 35 ++++++++++-------
 2 files changed, 102 insertions(+), 32 deletions(-)

--
1.9.3
