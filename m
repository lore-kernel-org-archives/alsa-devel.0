From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: [GIT PULL] ASoC updates for 2.6.35
Date: Tue, 27 Apr 2010 14:21:03 +0100
Message-ID: <1272374463.11000.18.camel@odin>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f51.google.com (mail-fx0-f51.google.com
	[209.85.161.51]) by alsa0.perex.cz (Postfix) with ESMTP id 7FDEA24142
	for <alsa-devel@alsa-project.org>;
	Tue, 27 Apr 2010 15:21:12 +0200 (CEST)
Received: by fxm2 with SMTP id 2so229954fxm.38
	for <alsa-devel@alsa-project.org>; Tue, 27 Apr 2010 06:21:11 -0700 (PDT)
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
Cc: alsa-devel <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org


The following changes since commit f4d593280652025f797d432e90f49d49b9334689:
  Peter Ujfalusi (1):
        ASoC: tlv320dac33: Fix for early interrupt in FIFO Mode1

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/lrg/asoc-2.6.git for-2.6.35

Jarkko Nikula (4):
      ASoC: tlv320aic3x: Remove unused version string
      ASoC: tlv320aic3x: Remove needless power off from aic3x_set_bias_level
      ASoC: tlv320aic3x: Change bias management semantics
      ASoC: tlv320aic3x: Add basic regulator support

Peter Ujfalusi (4):
      ASoC: tlv320dac33: Skip calculations in FIFO Bypass mode
      ASoC: tlv320dac33: Change magic numbers used in Mode7
      ASoC: tlv320dac33: Calculate the interface speed during bursts
      ASoC: tlv320dac33: FIFO caused delay reporting

 sound/soc/codecs/tlv320aic3x.c |   81 +++++++-------
 sound/soc/codecs/tlv320dac33.c |  243 ++++++++++++++++++++++++++++++++++++++--
 2 files changed, 272 insertions(+), 52 deletions(-)
