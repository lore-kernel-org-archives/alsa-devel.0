From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: [GIT PULL] ASoC updates for-2.6.37
Date: Sat, 23 Oct 2010 15:42:43 +0100
Message-ID: <1287844963.7486.51.camel@odin>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ww0-f41.google.com (mail-ww0-f41.google.com [74.125.82.41])
	by alsa0.perex.cz (Postfix) with ESMTP id EEB1724499
	for <alsa-devel@alsa-project.org>;
	Sat, 23 Oct 2010 16:42:46 +0200 (CEST)
Received: by wwi14 with SMTP id 14so644051wwi.2
	for <alsa-devel@alsa-project.org>; Sat, 23 Oct 2010 07:42:45 -0700 (PDT)
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

Some final updates prior to the ALSA pull request.

Thanks

Liam

---


The following changes since commit ad5e4655f9a920b1cc13972e0389eaf9e0ba10b3:

  ASoC: remove duplicated include for nuc900 (2010-10-05 19:26:00 -0700)

are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/lrg/asoc-2.6.git for-2.6.37

Jarkko Nikula (1):
      ASoC: omap: Remove needless prints from machine drivers

Peter Ujfalusi (3):
      ASoC: tlv320dac33: Control for line output gain
      ASoC: tpa6130a2: Error handling for broken chip
      ASoC: tlv320dac33: Use usleep_range for delays

 sound/soc/codecs/tlv320dac33.c |   28 ++++++++++++++++++++++++----
 sound/soc/codecs/tpa6130a2.c   |   28 ++++++++++++++++++++++------
 sound/soc/omap/am3517evm.c     |    4 +---
 sound/soc/omap/igep0020.c      |    4 +---
 sound/soc/omap/omap2evm.c      |    4 +---
 sound/soc/omap/omap3beagle.c   |    4 +---
 sound/soc/omap/omap3evm.c      |    4 +---
 sound/soc/omap/sdp3430.c       |    4 +---
 sound/soc/omap/sdp4430.c       |    4 +---
 sound/soc/omap/zoom2.c         |    4 +---
 10 files changed, 54 insertions(+), 34 deletions(-)
