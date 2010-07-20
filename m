From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: ASoC update for 2.6.35
Date: Tue, 20 Jul 2010 10:41:26 +0100
Message-ID: <20100720094125.GM10222@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 6CABE1037FC
	for <alsa-devel@alsa-project.org>;
	Tue, 20 Jul 2010 11:41:28 +0200 (CEST)
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

The following changes since commit 637727838a5e82bc9285ab078a793eaae590bacb:

  ASoC: fsi: fixup wrong value setting order of TDM (2010-07-13 12:26:26 +0100)

are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound-2.6.git for-2.6.35

Axel Lin (2):
      ASoC: wm8727: add a missing return in wm8727_platform_probe
      ASoC:: remove a redundant snd_soc_unregister_codec call in wm8988_register

Chanwoo Choi (1):
      ASoC: Select wm_hubs automatically for WM8994

Mark Brown (1):
      ASoC: Remove duplicate AUX definition from WM8776

Another series of small, driver-specific fixes.

 sound/soc/codecs/Kconfig  |    4 ++--
 sound/soc/codecs/wm8727.c |    2 ++
 sound/soc/codecs/wm8776.c |    1 -
 sound/soc/codecs/wm8988.c |    1 -
 4 files changed, 4 insertions(+), 4 deletions(-)
