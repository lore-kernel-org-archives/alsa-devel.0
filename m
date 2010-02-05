From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: ASoC updates for 2.6.34
Date: Fri, 5 Feb 2010 17:21:23 +0000
Message-ID: <20100205172123.GB31523@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id B990B1038DE
	for <alsa-devel@alsa-project.org>; Fri,  5 Feb 2010 18:21:24 +0100 (CET)
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

The following changes since commit cb67286d6629ecb5bfc44071d664cf1cbd01a350:
  Peter Ujfalusi (1):
        ASoC: TWL4030: Module unloading fix

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound-2.6.git for-2.6.34

Grazvydas Ignotas (2):
      ASoC: pandora: Add APLL supply to fix audio output
      ASoC: pandora: Add DAC regulator support

Mark Brown (1):
      Merge branch 'for-2.6.33' into for-2.6.34

 sound/soc/omap/omap3pandora.c |   43 ++++++++++++++++++++++++++++++++++++----
 1 files changed, 38 insertions(+), 5 deletions(-)
