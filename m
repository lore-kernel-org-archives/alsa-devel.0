From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: ASoC updates for 2.6.36
Date: Wed, 16 Jun 2010 15:23:35 +0100
Message-ID: <20100616142335.GB24491@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 53D4E103868
	for <alsa-devel@alsa-project.org>;
	Wed, 16 Jun 2010 16:23:38 +0200 (CEST)
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

The following changes since commit 67884e215bf24ad9c244cc8b9eb3c243e85385a1:

  Merge branch 'for-2.6.35' into for-2.6.36 (2010-06-15 11:55:35 +0100)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound-2.6.git for-2.6.36

Tweak to the WM2000 driver and a fix for the error reporting issues with
volsw_2r_sx.

Mark Brown (2):
      ASoC: Default WM2000 ANC and speaker to enabled
      ASoC: Pay attention to write errors in volsw_2r_sx

 sound/soc/codecs/wm2000.c |    2 ++
 sound/soc/soc-core.c      |    6 ++----
 2 files changed, 4 insertions(+), 4 deletions(-)
