From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: ASoC updates for 2.6.30
Date: Mon, 6 Apr 2009 23:48:44 +0100
Message-ID: <20090406224844.GB3622@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 780001037F1
	for <alsa-devel@alsa-project.org>;
	Tue,  7 Apr 2009 00:48:50 +0200 (CEST)
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The following changes since commit 103f211d0be2bed75b5739de62a10415ef0bbc25:
  Peter Ujfalusi (1):
        ASoC: TWL4030: Add actual support for 96KHz playback support

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound-2.6.git for-2.6.30

Anton Vorontsov (1):
      ASoC: fsl_dma: Pass the proper device for dma mapping routines

Dan Carpenter (1):
      ASoC: Fix null dereference in ak4535_remove()

 sound/soc/codecs/ak4535.c |    3 ++-
 sound/soc/fsl/fsl_dma.c   |   12 ++++++------
 2 files changed, 8 insertions(+), 7 deletions(-)
