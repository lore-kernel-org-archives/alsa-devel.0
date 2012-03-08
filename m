From: Grazvydas Ignotas <notasas@gmail.com>
Subject: [PATCH 0/3] ASoC: omap-mcbsp: fixes for some underflow
	problems
Date: Fri,  9 Mar 2012 01:19:14 +0200
Message-ID: <1331248757-3408-1-git-send-email-notasas@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ww0-f51.google.com (mail-ww0-f51.google.com [74.125.82.51])
	by alsa0.perex.cz (Postfix) with ESMTP id D594410BB1B
	for <alsa-devel@alsa-project.org>; Fri,  9 Mar 2012 00:19:28 +0100 (CET)
Received: by wgbed3 with SMTP id ed3so778100wgb.20
	for <alsa-devel@alsa-project.org>; Thu, 08 Mar 2012 15:19:27 -0800 (PST)
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
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>, Grazvydas Ignotas <notasas@gmail.com>
List-Id: alsa-devel@alsa-project.org

With these series I'm trying to deal with underflow problems I was
complaining about earlier. This mostly tries to get minimum period
size large enough for things to work.

To illustrate the problems I wrote a testcase with alsalib, hopefully it
shows the problem more clearly:
http://notaz.gp2x.de/misc/alsa_period_test.c

Applies on top of mcbsp move series.

Grazvydas Ignotas (3):
  ASoC: omap-mcbsp: fix snd_pcm_hw_rule_add arguments
  ASoC: omap-mcbsp: place size constrain on period, not buffer
  ASoC: omap-mcbsp: make minimum period size larger than FIFO

 sound/soc/omap/omap-mcbsp.c |   31 +++++++++++++++++++++----------
 1 files changed, 21 insertions(+), 10 deletions(-)
