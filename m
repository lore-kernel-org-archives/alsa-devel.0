From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: ASoC updates for 2.6.33
Date: Tue, 6 Oct 2009 17:09:40 +0100
Message-ID: <20091006160940.GB8881@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 99B67103911
	for <alsa-devel@alsa-project.org>;
	Tue,  6 Oct 2009 18:09:44 +0200 (CEST)
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

The following changes since commit 88439ac793934a47f47ad285656b63d09f5937c8:
  Peter Ujfalusi (1):
        ASoC: add support for multiple cards/codecs in debugfs

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound-2.6.git for-2.6.33

The new commits that aren't part of v2.6.32-rc3 (which is being merged
up via fix/asoc here) are:

Jonathan Cameron (1):
      ASoC: wm8940: Fix check on error code form snd_soc_codec_set_cache_io

Mark Brown (4):
      Merge branch 'for-2.6.32' into for-2.6.33
      ASoC: Simplify code for DAPM widget updates
      ASoC: Push DAPM enumeration register change test out
      ASoC: Add virtual enumeration support for DAPM muxes

Peter Ujfalusi (2):
      ASoC: Fix SND_SOC_DAPM_LINE handling
      ASoC: Improve the debugfs hierarchy
