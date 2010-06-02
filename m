From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: ASoC updates for 2.6.35
Date: Wed, 2 Jun 2010 11:46:20 +0100
Message-ID: <20100602104620.GA3020@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id A7A5E24615
	for <alsa-devel@alsa-project.org>;
	Wed,  2 Jun 2010 12:46:09 +0200 (CEST)
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

The following changes since commit 1fab79b8a1bf0d46a7c7e6a1c06dbed1803f403c:

  Merge branch 'for-2.6.36' of git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound-2.6 into topic/asoc (2010-05-31 18:13:20 +0200)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound-2.6.git for-2.6.35

Simple Kconfig fixes, should only affect the relevant platforms.

Sascha Hauer (2):
      ASoC: Add missing Kconfig entry for Phytec boards
      ASoC: MX31ads sound support should depend on MACH_MX31ADS_WM1133_EV1

 sound/soc/imx/Kconfig |   11 ++++++++++-
 1 files changed, 10 insertions(+), 1 deletions(-)
