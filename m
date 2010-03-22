From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: ASoC updates for 2.6.34
Date: Mon, 22 Mar 2010 16:46:25 +0000
Message-ID: <20100322164625.GA16836@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 073EE103923
	for <alsa-devel@alsa-project.org>; Mon, 22 Mar 2010 17:46:27 +0100 (CET)
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

The following changes since commit 220bf991b0366cc50a94feede3d7341fa5710ee4:
  Linus Torvalds (1):
        Linux 2.6.34-rc2

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound-2.6.git for-2.6.34

Plus a merge up of 2.6.34-rc2 which means that the ARM build issues are
pretty much gone.  Only the two new patches for ASoC are listed below.

Daniel Mack (1):
      ASoC: pxa-pcm-lib: initialize DMA channel to -1

Mark Brown (1):
      ASoC: Remove BROKEN from i.MX audio after dependencies merged

 sound/arm/pxa2xx-pcm-lib.c     |    1 +
 sound/soc/imx/Kconfig          |    2 +-
