From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: ASoC update for 2.6.32
Date: Mon, 30 Nov 2009 13:39:40 +0000
Message-ID: <20091130133940.GB18944@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 355C9103836
	for <alsa-devel@alsa-project.org>; Mon, 30 Nov 2009 14:39:42 +0100 (CET)
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

The following changes since commit 50b6bce59d154b5db137907a5c0ed45a4e7a3829:
  Mark Brown (1):
        ASoC: Fix suspend with active audio streams

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound-2.6.git for-2.6.32

This is a bit late and since the breakage in question has been present
for rather a long time it's not super urgent to actually get into 2.6.32
but it'd be nice.

Anuj Aggarwal (1):
      ASoC: AIC23: Fixing infinite loop in resume path

 sound/soc/codecs/tlv320aic23.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)
