From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: ASoC updates for 3.0
Date: Sat, 9 Jul 2011 11:11:17 +0900
Message-ID: <20110709021115.GI18860@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id A21E4103860
	for <alsa-devel@alsa-project.org>;
	Mon, 11 Jul 2011 12:11:01 +0200 (CEST)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

The following changes since commit 873bd4cb4fbba6a3e99f750e17ef2ba6ef96e9d3:

  ASoC: Don't set invalid name string to snd_card->driver field (2011-07-05 14:39:27 +0200)

are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound-2.6.git for-3.0

The WM8731 patch fixes resume when we suspend with an active playback or
record.

Kuninori Morimoto (1):
      ASoC: ak4642: fixup snd_soc_update_bits mask for PW_MGMT2

Mark Brown (1):
      ASoC: Manage WM8731 ACTIVE bit as a supply widget

 sound/soc/codecs/ak4642.c |    2 +-
 sound/soc/codecs/wm8731.c |   29 +++--------------------------
 2 files changed, 4 insertions(+), 27 deletions(-)
