From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: ASoC updates for 2.6.38
Date: Tue, 8 Feb 2011 11:34:25 +0000
Message-ID: <20110208113425.GD29850@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 72E212447B
	for <alsa-devel@alsa-project.org>; Tue,  8 Feb 2011 12:34:26 +0100 (CET)
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
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

The following changes since commit f019ee5feb344ff0b22b58df4568676295aae14f:

  ASoC: CX20442: fix NULL pointer dereference (2011-02-01 14:13:56 +0000)

are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound-2.6.git for-2.6.38

Janusz Krzysztofik (1):
      ASoC: fill in snd_soc_pcm_runtime.card before calling snd_soc_dai_link.init()

Mark Brown (2):
      ASoC: Create an AIF1ADCDAT signal widget to match AIF2
      ASoC: Improve WM8994 digital power sequencing

Vaibhav Bedia (1):
      asoc: davinci: da830/omap-l137: correct cpu_dai_name

 sound/soc/codecs/wm8994.c       |   26 ++++++++++++++++++++++----
 sound/soc/davinci/davinci-evm.c |   18 +++++++++++++++---
 sound/soc/soc-core.c            |    2 +-
 3 files changed, 38 insertions(+), 8 deletions(-)
