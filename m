From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: [GIT PULL] ASoC updates for 2.6.36
Date: Mon, 31 May 2010 11:29:08 +0100
Message-ID: <1275301748.3174.13.camel@odin>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179]) by alsa0.perex.cz (Postfix) with ESMTP id 4EC9B24401
	for <alsa-devel@alsa-project.org>;
	Mon, 31 May 2010 12:36:47 +0200 (CEST)
Received: by wyb32 with SMTP id 32so314719wyb.38
	for <alsa-devel@alsa-project.org>; Mon, 31 May 2010 03:36:46 -0700 (PDT)
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

Hi Takashi,

Please pull the following ASoC updates for 2.6.36.

Thanks

Liam

---

The following changes since commit ad8332c1302bcb4f80d593fd3eb477be9d7f5604:
  Jarkko Nikula (1):
        ASoC: tpa6130a2: Remove CPVSS and HPVdd supplies

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/lrg/asoc-2.6.git for-2.6.36

Jorge Eduardo Candelaria (1):
      ASoC: TWL6040: Fix playback with 19.2 Mhz MCLK

Peter Ujfalusi (8):
      ASoC: TWL4030: Revisit codec defaults
      ASoC: TWL4030: Remove wrapper for power down
      ASoC: TWL4030: Make offset cancellation path configurable
      ASoC: TWL4030: Optimize the power up sequence
      ASoC: TWL4030: Helper to check chip default registers
      ASoC: TWL4030: Correct the ARXR2_APGA_CTL chip default
      ASoC: TWL4030: Use BIAS_OFF instead of BIAS_STANDBY, when not in use
      ASoC: TWL4030: Add functionalty to reset the registers

 sound/soc/codecs/twl4030.c |  291 +++++++++++++++++++++++++-------------------
 sound/soc/codecs/twl4030.h |    3 +
 sound/soc/codecs/twl6040.c |    2 +-
 3 files changed, 170 insertions(+), 126 deletions(-)
