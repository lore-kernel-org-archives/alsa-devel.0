From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: ASoC update for 2.6.37
Date: Tue, 2 Nov 2010 09:31:54 -0400
Message-ID: <20101102133153.GE21476@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 9CCCD103913
	for <alsa-devel@alsa-project.org>; Tue,  2 Nov 2010 14:31:45 +0100 (CET)
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

The following changes since commit 5a0b07433ddd808ecbb5f4287b61be6fa7af1b57:

  ASoC: Update WARN uses in wm_hubs (2010-11-01 15:44:57 -0400)

are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound-2.6.git for-2.6.37

Eric Miao (1):
      ASoC: fix the building issue of missing codec field in 'struct snd_soc_card'

This is a clearly focused build fix.  I'll do a merge up of 2.6.37-rc1
once this is pulled if that's OK?

 sound/soc/pxa/tosa.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)
