From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: ASoC updates for 2.6.32
Date: Fri, 4 Sep 2009 22:03:45 +0100
Message-ID: <20090904210345.GB4927@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 6D310243A5
	for <alsa-devel@alsa-project.org>;
	Fri,  4 Sep 2009 23:03:52 +0200 (CEST)
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The following changes since commit 5c0d38c9478e79ab7deb1b470dd181d2308a608e:
  jassi brar (1):
        ASoC: Debugged improper setting of PLL fields in WM8580 driver

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound-2.6.git for-2.6.32

Mark Brown (1):
      ASoC: Fully specify DC servo bits to update in wm_hubs

Robert Schwebel (1):
      ASoC: fix pxa2xx-ac97.c breakage

 sound/arm/pxa2xx-ac97.c    |    2 +-
 sound/soc/codecs/wm_hubs.c |   12 ++----------
 2 files changed, 3 insertions(+), 11 deletions(-)
