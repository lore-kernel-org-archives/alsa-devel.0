From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: ASoC updates for 2.6.37
Date: Fri, 22 Oct 2010 10:32:52 -0700
Message-ID: <20101022173252.GB17881@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id B6C08103838
	for <alsa-devel@alsa-project.org>;
	Fri, 22 Oct 2010 19:32:44 +0200 (CEST)
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

The following changes since commit c429ffbe038a649d121e6cecba5cf66777f39370:

  ASoC: WM8580: Remove useless assignment (2010-10-19 03:07:10 -0700)

are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound-2.6.git for-2.6.37

Dimitris Papastamos (2):
      ASoC: soc-core: Fix codec->name memory leak
      ASoC: max98088: Staticise m98088_eq_band

 sound/soc/codecs/max98088.c |    2 +-
 sound/soc/soc-core.c        |    1 +
 2 files changed, 2 insertions(+), 1 deletions(-)
