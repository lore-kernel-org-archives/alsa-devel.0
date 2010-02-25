From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: ASoC updates for 2.6.34
Date: Thu, 25 Feb 2010 16:10:00 +0000
Message-ID: <20100225160959.GA3241@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 5F43F1039BF
	for <alsa-devel@alsa-project.org>; Thu, 25 Feb 2010 17:09:57 +0100 (CET)
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
To: Takasi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

The following changes since commit d62abe563fa4718e7f85f3e871655434db92366d:
  Misael Lopez Cruz (1):
        OMAP4: PMIC: Add support for twl6030 codec

are available in the git repository at:

  git://opensource.wolfsonmicro.com/linux-2.6-asoc.git for-2.6.34

These wind up being a bug fix, without fixing the reporting of the
periods a lot of hardware is going to get lots of clock domain issues.

Mark Brown (2):
      ASoC: Remove a unused variables from i.MX FIQ runtime data
      ASoC: Check progress when reporting periods from i.MX FIQ handler

 sound/soc/imx/imx-pcm-fiq.c |   40 ++++++++++++++++++++++++++++++----------
 1 files changed, 30 insertions(+), 10 deletions(-)
