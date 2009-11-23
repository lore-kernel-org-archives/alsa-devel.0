From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: ASoC update for 2.6.32
Date: Mon, 23 Nov 2009 15:51:55 +0000
Message-ID: <20091123155155.GA30562@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id BFB9C2414F
	for <alsa-devel@alsa-project.org>; Mon, 23 Nov 2009 16:51:56 +0100 (CET)
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
Cc: alsa-devel@alsa-project.org, jy0922.shim@samsung.com, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

The following changes since commit bab0212467e58929470ae3ae32515f17e30c3926:
  Troy Kisky (1):
        ASoC: tlv320aic23 fix rate selection

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound-2.6.git for-2.6.32

It might be a little late to get this one in but it's a nasty bug.

Mark Brown (1):
      ASoC: Fix suspend with active audio streams

 sound/soc/soc-dapm.c |   20 +++++++++++++++++---
 1 files changed, 17 insertions(+), 3 deletions(-)
