From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: ASoC updates for 2.6.37
Date: Tue, 5 Oct 2010 12:14:00 -0700
Message-ID: <20101005191359.GA23315@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 58584103937
	for <alsa-devel@alsa-project.org>;
	Tue,  5 Oct 2010 21:13:46 +0200 (CEST)
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

The following changes since commit 45605a87b3f34fb71bbc6446e2d49a469e9e10dd:

  Merge branch 'for-2.6.37' of git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound-2.6 into topic/asoc (2010-10-05 07:50:11 +0200)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound-2.6.git for-2.6.37

Dimitris Papastamos (2):
      ASoC: soc-cache: Add spi_write support for all I/O types
      ASoC: WM8804: Retrieve the device revision and print it

Guennadi Liakhovetski (1):
      ASoC: sh: fix build error: terminate the platform device ID list

Mark Brown (1):
      Merge branch 'topic/asoc' of git://git.kernel.org/.../tiwai/sound-2.6 into for-2.6.37

Nicolas Kaiser (1):
      ASoC: remove duplicated include for nuc900

Troy Kisky (1):
      ALSA: ASoc: DaVinci Delay start of ASP to trigger

 sound/soc/codecs/wm8804.c       |    8 +++
 sound/soc/davinci/davinci-i2s.c |    6 ---
 sound/soc/nuc900/nuc900-ac97.c  |    1 -
 sound/soc/sh/fsi.c              |    1 +
 sound/soc/soc-cache.c           |   96 +++++++++++++++++++++++++++++++++++++++
 5 files changed, 105 insertions(+), 7 deletions(-)
