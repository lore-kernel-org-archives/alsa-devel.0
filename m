From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: ASoC updates for 2.6.31
Date: Mon, 18 May 2009 16:04:53 +0100
Message-ID: <20090518150453.GA1576@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 2565A243C7
	for <alsa-devel@alsa-project.org>;
	Mon, 18 May 2009 17:04:55 +0200 (CEST)
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

The following changes since commit 5b740ea975c4ce3da12ac21b56f9e43354ca4327:
  Julia Lawall (1):
        sound: use dev_set_drvdata

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound-2.6.git for-2.6.31

Mark Brown (4):
      ASoC: Split DAPM power checks from sequencing of power changes
      ASoC: Make DAPM sysfs entries non-optional
      ASoC: Integrate bias management with DAPM power management
      ASoC: Add debug trace for bias level transitions

Misael Lopez Cruz (1):
      ASoC: TWL4030: Enable/disable voice digital filters

 include/sound/soc-dapm.h   |    5 +-
 include/sound/soc.h        |    3 +
 sound/soc/codecs/twl4030.c |   37 +++++++++
 sound/soc/codecs/twl4030.h |    2 +-
 sound/soc/soc-core.c       |   61 +++------------
 sound/soc/soc-dapm.c       |  187 ++++++++++++++++++++++++++++++--------------
 6 files changed, 183 insertions(+), 112 deletions(-)
