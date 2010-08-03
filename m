From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: [GIT PULL] Updates for 2.6.36
Date: Wed, 04 Aug 2010 00:46:55 +0100
Message-ID: <1280879215.3112.92.camel@odin>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ww0-f51.google.com (mail-ww0-f51.google.com [74.125.82.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 6E18E24333
	for <alsa-devel@alsa-project.org>;
	Wed,  4 Aug 2010 01:46:59 +0200 (CEST)
Received: by wwb17 with SMTP id 17so1826108wwb.20
	for <alsa-devel@alsa-project.org>; Tue, 03 Aug 2010 16:46:59 -0700 (PDT)
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

A last update for 2.6.36.

Thanks

Liam

---

The following changes since commit 116bcd9cf22c00c22402c2a2be6ef8e81289a574:
  Axel Lin (1):
        ASoC: wm9081: fix resource reclaim in wm9081_register error path

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/lrg/asoc-2.6.git for-2.6.36

Peter Ujfalusi (1):
      ASoC: TWL4030: Capture route runtime DAPM ordering fix

 sound/soc/codecs/twl4030.c |   48 +++++++++++---------------------------------
 1 files changed, 12 insertions(+), 36 deletions(-)
