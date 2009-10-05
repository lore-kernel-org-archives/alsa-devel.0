From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: ASoC updates for 2.6.32
Date: Mon, 5 Oct 2009 10:35:52 +0100
Message-ID: <20091005093552.GA14528@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 57BFD2437C
	for <alsa-devel@alsa-project.org>;
	Mon,  5 Oct 2009 11:35:54 +0200 (CEST)
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

The following changes since commit 834eb6c599a8efa1fe9b77d469562e0c78c876e1:
  Mark Brown (1):
        Merge remote branch 'takashi/fix/asoc' into for-2.6.32

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound-2.6.git for-2.6.32

Jonathan Cameron (1):
      ASoC: wm8940: Fix check on error code form snd_soc_codec_set_cache_io

Peter Ujfalusi (1):
      ASoC: Fix SND_SOC_DAPM_LINE handling

 sound/soc/codecs/wm8940.c |    2 +-
 sound/soc/soc-dapm.c      |    5 +++--
 2 files changed, 4 insertions(+), 3 deletions(-)
