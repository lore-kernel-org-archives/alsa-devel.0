From: Ian Molton <ian@mnementh.co.uk>
Subject: [Pull request] Support for wm9705 codec and two
 machines that use it.
Date: Thu, 15 Jan 2009 01:13:52 +0000
Message-ID: <496E8DD0.4090006@mnementh.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mnementh.co.uk (mail.mnementh.co.uk [173.45.232.4])
	by alsa0.perex.cz (Postfix) with ESMTP id 9BEA4103807
	for <alsa-devel@alsa-project.org>; Thu, 15 Jan 2009 02:13:30 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA development <alsa-devel@alsa-project.org>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>
List-Id: alsa-devel@alsa-project.org

The following changes since commit 6d3455ecb7d564789e8dd493fb876f4a8706e3b2:
   Mark Brown (1):
         Fix leftover merge issue.

are available in the git repository at:

   git://git.mnementh.co.uk/linux-2.6-im.git asoc

Ian Molton (3):
       ASoc: codec: Driver for wm9705 AC97 codec.
       ASoC: machine driver for Toshiba e750
       ASoC: machine driver for Toshiba e800

  arch/arm/mach-pxa/e750.c                      |    5 +
  arch/arm/mach-pxa/include/mach/eseries-gpio.h |   10 +
  sound/soc/codecs/Kconfig                      |    4 +
  sound/soc/codecs/Makefile                     |    2 +
  sound/soc/codecs/wm9705.c                     |  401 ++++++++++++++++++
  sound/soc/codecs/wm9705.h                     |   14 +
  sound/soc/pxa/Kconfig                         |    9 +
  sound/soc/pxa/Makefile                        |    2 +
  sound/soc/pxa/e750_wm9705.c                   |  185 ++++++++++++
  sound/soc/pxa/e800_wm9712.c                   |  115 +++++++-
  10 files changed, 733 insertions(+), 14 deletions(-)
  create mode 100644 sound/soc/codecs/wm9705.c
  create mode 100644 sound/soc/codecs/wm9705.h
  create mode 100644 sound/soc/pxa/e750_wm9705.c
