From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: ASoC updates for 2.6.33
Date: Thu, 3 Dec 2009 11:05:06 +0000
Message-ID: <20091203110505.GE13165@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 1A0E31038AD
	for <alsa-devel@alsa-project.org>; Thu,  3 Dec 2009 12:05:07 +0100 (CET)
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

The following changes since commit a649d1fcc9bd2299cb06b6594fabb429fa50f174:
  Daniel Mack (1):
        ASoC: pxa/raumfeld: adopt new snd_soc_dai_set_pll() API

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound-2.6.git for-2.6.33

Very last minute but these would qualify as bug fixes during the release
cycle so I feel comfortable merging them now.

Manuel Lauss (2):
      ASoC: au1x: dbdma2: fix oops on soc device removal.
      ASoC: au1x: dbdma2: plug memleak in pcm device creation error path

 sound/soc/au1x/dbdma2.c |    6 ++----
 1 files changed, 2 insertions(+), 4 deletions(-)
