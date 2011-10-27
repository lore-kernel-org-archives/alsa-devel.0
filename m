From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: ASoC updates for 3.2
Date: Thu, 27 Oct 2011 09:22:04 +0200
Message-ID: <20111027072203.GA3481@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 96C8924607
	for <alsa-devel@alsa-project.org>;
	Thu, 27 Oct 2011 09:22:06 +0200 (CEST)
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

The following changes since commit 226d0f22d044f0151287bb7cf334b85182248f0e:

  ASoC: keep pointer to resource so it can be freed (2011-10-22 10:46:35 +0100)

are available in the git repository at:
  git://opensource.wolfsonmicro.com/linux-2.6-asoc.git for-3.2

Axel Lin (2):
      ASoC: max98095: Convert codec->hw_write to snd_soc_write
      ASoC: wm8940: Properly set codec->dapm.bias_level

 sound/soc/codecs/max98095.c |   13 ++++++-------
 sound/soc/codecs/wm8940.c   |    2 ++
 2 files changed, 8 insertions(+), 7 deletions(-)
