From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: ASoC updates for 2.6.35
Date: Tue, 11 May 2010 14:38:56 +0100
Message-ID: <20100511133855.GA27925@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 888DD2484E
	for <alsa-devel@alsa-project.org>;
	Tue, 11 May 2010 15:38:59 +0200 (CEST)
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

The following changes since commit 896060c76bdfd8a45eb33b3dd1a8307fe37f6c04:
  Mark Brown (1):
        ASoC: Use more idiomatic driver name for WM8731

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound-2.6.git for-2.6.35

A bunch of minor WM8993/4 enhancements and Peter's invert handling.

Mark Brown (4):
      ASoC: Add register write logging for WM8994
      ASoC: Add additional WM hubs DC servo trace
      ASoC: Reorder power down sequence for WM hubs devices
      ASoC: Don't restart unconfigured WM8994 FLLs

Peter Ujfalusi (1):
      ASoC: core: Fix for the volume limiting when invert is in use

 include/sound/soc.h        |   23 ++++++++++++-----------
 sound/soc/codecs/wm8994.c  |    5 +++++
 sound/soc/codecs/wm_hubs.c |   12 ++++++++----
 sound/soc/soc-core.c       |   30 +++++++++++++++++++++---------
 4 files changed, 46 insertions(+), 24 deletions(-)
