From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: ASoC updates for 2.6.38
Date: Mon, 27 Dec 2010 17:43:07 +0000
Message-ID: <20101227174306.GA15296@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 1FB0324686
	for <alsa-devel@alsa-project.org>; Mon, 27 Dec 2010 18:42:57 +0100 (CET)
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

The following changes since commit d08935711b542c3fe5c51abf290e172536d4cf09:

  Merge branch 'for-2.6.38' of git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound-2.6 into topic/asoc (2010-12-23 13:39:59 +0100)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound-2.6.git for-2.6.38

Mark Brown (4):
      ASoC: Remove incorrect WM8903 erratum workaround
      ASoC: Remove WM8995 write sequencer bitfield definitions
      ASoC: Fix typo in x86 workaround
      ASoC: Fix double comment start

 sound/soc/codecs/wm8903.c |   20 +-
 sound/soc/codecs/wm8903.h |   21 -
 sound/soc/codecs/wm8962.c |    2 +-
 sound/soc/codecs/wm8995.h | 4480 ---------------------------------------------
 4 files changed, 7 insertions(+), 4516 deletions(-)
