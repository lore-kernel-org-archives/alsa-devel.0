From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: [GIT PULL] ASoC Final updates for 2.6.38
Date: Wed, 12 Jan 2011 01:07:00 +0000
Message-ID: <1294794420.3338.488.camel@odin>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f193.google.com (mail-wy0-f193.google.com
	[74.125.82.193])
	by alsa0.perex.cz (Postfix) with ESMTP id E62941038C0
	for <alsa-devel@alsa-project.org>; Wed, 12 Jan 2011 02:07:03 +0100 (CET)
Received: by wyb42 with SMTP id 42so16052wyb.8
	for <alsa-devel@alsa-project.org>; Tue, 11 Jan 2011 17:07:03 -0800 (PST)
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
Cc: alsa-devel <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Later than usual since I've been on the road lately.

The following changes since commit 991e02b4469c2e92cc98aa5b04fbde981671b74c:

  Merge branch 'for-2.6.38' of git://git.kernel.org/pub/scm/linux/kernel/git/lrg/asoc-2.6 into topic/asoc (2010-12-17 16:43:17 +0100)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/lrg/asoc-2.6.git for-2.6.38

David Lambert (1):
      ASoC: DMIC codec: Adding a generic DMIC codec

Jorge Eduardo Candelaria (1):
      ASoC: mcbsp: Add McBSP support for OMAP4

Olaya, Margarita (1):
      ASoC: twl6040: Convert HF and HS drivers to use DAPM OUT_DRV widget

Peter Ujfalusi (5):
      ASoC: tlv320dac33: Remove manual FIFO configuration
      ASoC: tlv320dac33: Some cleanup for 32/24 bit support
      ASoC: tlv320dac33: Add 32/24 bit audio support
      ASoC: tlv320dac33: Add DAPM selection for LOM invert
      ASoC: tpa6130a2: Fix compiler warning

 sound/soc/codecs/Kconfig       |    3 +
 sound/soc/codecs/Makefile      |    2 +
 sound/soc/codecs/dmic.c        |   81 ++++++++++++
 sound/soc/codecs/tlv320dac33.c |  269 ++++++++++++++++------------------------
 sound/soc/codecs/tpa6130a2.c   |    1 -
 sound/soc/codecs/twl6040.c     |    8 +-
 sound/soc/omap/omap-mcbsp.c    |   35 +++++-
 sound/soc/omap/omap-mcbsp.h    |    4 +
 8 files changed, 234 insertions(+), 169 deletions(-)
 create mode 100644 sound/soc/codecs/dmic.c
