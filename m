From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: ASoC update for 2.6.36
Date: Mon, 23 Aug 2010 13:36:15 +0100
Message-ID: <20100823123615.GB14504@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id B26BB10393F
	for <alsa-devel@alsa-project.org>;
	Mon, 23 Aug 2010 14:36:16 +0200 (CEST)
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

The following changes since commit b2c1e07b81a126e5846dfc3d36f559d861df59f4:

  ASoC: Remove DSP mode support for WM8776 (2010-08-16 11:46:57 +0100)

are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound-2.6.git for-2.6.36

Sascha Hauer (1):
      ASoC: i.MX ssi: use SSI_STCCR in synchronous mode

Simple, non-invasive bug fix.

 sound/soc/imx/imx-ssi.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)
