From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: [PATCH 0/2] ASoC: TWL4030: Vibra and APLL fixes
Date: Thu, 29 Oct 2009 11:58:08 +0200
Message-ID: <1256810290-20478-1-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx09.nokia.com (smtp.nokia.com [192.100.105.134])
	by alsa0.perex.cz (Postfix) with ESMTP id C617E24657
	for <alsa-devel@alsa-project.org>; Thu, 29 Oct 2009 10:58:29 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: broonie@opensource.wolfsonmicro.com, ext-jari.vanhala@nokia.com
List-Id: alsa-devel@alsa-project.org

Hello,

Audio driven vibrator output fix:
To have correct audio routed to the vibra output, we also need to configure
the VIBRA_SET register, which in theory has nothing to do with the vibra, when
it is driven with audio.

and fix for the APLL powering sequence:
The APLL in the past was enabled at set_dai_sysclk function, but it has been
fixed, which introduced some really strange signals on the outputs.

This series applies on top of Mark's tree, for-2.6.33 branch at:
git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound-2.6.git

Since the underlying twl4030 patches are not yet in the topic/asoc of
Takashi's tree.

---
Jari Vanhala (1):
  ASoC: TWL4030: Vibra motor stop fix when it is driven with audio

Peter Ujfalusi (1):
  ASoC: TWL4030: Change APLL powering sequence

 sound/soc/codecs/twl4030.c |   38 ++++++++++++++++++++++++++++++++++----
 1 files changed, 34 insertions(+), 4 deletions(-)
