From: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Subject: [PATCH 0/2] ASoC: da7219: Small clocking related
	updates for PLL and sysclk
Date: Tue, 19 Apr 2016 15:19:01 +0100
Message-ID: <cover.1461071847.git.Adam.Thomson.Opensource@diasemi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.bemta5.messagelabs.com (mail1.bemta5.messagelabs.com
 [195.245.231.149])
 by alsa0.perex.cz (Postfix) with ESMTP id 1E2B7264ED5
 for <alsa-devel@alsa-project.org>; Tue, 19 Apr 2016 16:19:03 +0200 (CEST)
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

The patch set contains 2 small fixes/updates relating to clocking in the codec.
The first improves PLL locking for a corner scenario with a low frequency MCLK
provided, and the second is to remove 32KHz support from the codec
set_dai_sysclk() function, to align with updates already made to the
set_dai_pll() function.

Patches are based on v4.6-rc4 kernel version.

Adam Thomson (2):
  ASoC: da7219: Update PLL ranges and dividers to improve locking
  ASoC: da7219: Disallow unsupported 32KHz clock setting in
    set_dai_sysclk()

 sound/soc/codecs/da7219.c | 30 +++++++++++++++---------------
 sound/soc/codecs/da7219.h | 20 ++++++++++----------
 2 files changed, 25 insertions(+), 25 deletions(-)

--
1.9.3
