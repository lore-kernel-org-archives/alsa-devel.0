From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: ASoC updates for 2.6.34
Date: Mon, 29 Mar 2010 21:10:54 +0100
Message-ID: <20100329201053.GA7197@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 67AE6243E7
	for <alsa-devel@alsa-project.org>;
	Mon, 29 Mar 2010 22:10:55 +0200 (CEST)
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

The following changes since commit 3cc4e53f86dab635166929bfa47cc68d59b28c26:
  Mark Brown (1):
        ASoC: Remove BROKEN from i.MX audio after dependencies merged

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound-2.6.git for-2.6.34

A couple of fairly straightforward bug fixes.  The ac97 patch is
mildly invasive but it tested OK for me (and should be very obvious if
it fails).

Dan Carpenter (1):
      ASoC: wm8994: playback => capture

Graham Gower (1):
      ASoC: Fix passing platform_data to ac97 bus users and fix a leak

 sound/soc/codecs/ac97.c   |   15 +++++++++------
 sound/soc/codecs/wm8994.c |    2 +-
 sound/soc/soc-core.c      |    3 ++-
 3 files changed, 12 insertions(+), 8 deletions(-)
