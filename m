From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: [GIT PULL] ASoC updates for 2.6.38
Date: Tue, 23 Nov 2010 11:06:47 +0000
Message-ID: <1290510407.3449.50.camel@odin>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ww0-f51.google.com (mail-ww0-f51.google.com [74.125.82.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 5CA6410390B
	for <alsa-devel@alsa-project.org>; Tue, 23 Nov 2010 12:06:51 +0100 (CET)
Received: by wwe15 with SMTP id 15so1139494wwe.20
	for <alsa-devel@alsa-project.org>; Tue, 23 Nov 2010 03:06:51 -0800 (PST)
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

Some updates for 2.6.38 too :-


The following changes since commit 33ee617f4dad370bee016e4462e69481257453b0:

  Merge remote branch 'tiwai/topic/asoc' into for-2.6.38 (2010-11-03 14:18:42 +0000)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/lrg/asoc-2.6.git for-2.6.38

Axel Lin (1):
      ASoC: Move kfree(twl4030) to twl4030_soc_remove()

Jarkko Nikula (3):
      ASoC: tlv320aic3x: Use gpio_is_valid in checking for valid gpio_reset
      ASoC: tlv320aic3x: Add support to shared common reset line
      ASoC: tpa6130a2: Revisit power-up sequence

 sound/soc/codecs/tlv320aic3x.c |   32 +++++++++++++++++++++++++++-----
 sound/soc/codecs/tpa6130a2.c   |    6 +++---
 sound/soc/codecs/twl4030.c     |    6 +++---
 3 files changed, 33 insertions(+), 11 deletions(-)
