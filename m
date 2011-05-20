From: Liam Girdwood <lrg@ti.com>
Subject: [GIT PULL] ASoC updates for 2.6.40
Date: Fri, 20 May 2011 10:07:15 +0100
Message-ID: <4DD62F43.4070206@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from comal.ext.ti.com (comal.ext.ti.com [198.47.26.152])
	by alsa0.perex.cz (Postfix) with ESMTP id 89E3A103AA0
	for <alsa-devel@alsa-project.org>;
	Fri, 20 May 2011 11:07:17 +0200 (CEST)
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Hi Takashi,

Final updates for 2.6.40

Liam

---

The following changes since commit 1209842af4db98ffd7364ec9cf7d1a59293aa74c:

  Merge branch 'for-2.6.40' of git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound-2.6 into topic/asoc (2011-05-10 09:24:50 +0200)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/lrg/asoc-2.6.git for-2.6.40

Liam Girdwood (2):
      ASoC: twl6040 - fix LINEGAIN volume control
      MAINTAINERS: ASoC and Regulator email address change.

Peter Ujfalusi (7):
      ASoC: tlv320dac33: Update e-mail address
      ASoC: tpa6130a2: Update e-mail address
      ASoC: omap-mcbsp: Update e-mail address
      ASoC: omap-pcm: Update e-mail address
      ASoC: RX51: Update e-mail address
      MAINTAINERS: Update e-mail address for asoc/twl4030
      ASoC: omap-pcm: Period wakeup disabling on OMAP2+

Sanjeev Premi (1):
      ASoC: omap-mcbsp: Remove restrictive checks for cpu type

 MAINTAINERS                      |    6 +++---
 include/sound/tlv320dac33-plat.h |    2 +-
 include/sound/tpa6130a2-plat.h   |    2 +-
 sound/soc/codecs/tlv320dac33.c   |    4 ++--
 sound/soc/codecs/tlv320dac33.h   |    2 +-
 sound/soc/codecs/tpa6130a2.c     |    4 ++--
 sound/soc/codecs/tpa6130a2.h     |    2 +-
 sound/soc/codecs/twl6040.c       |    6 +++---
 sound/soc/omap/omap-mcbsp.c      |    6 +++---
 sound/soc/omap/omap-mcbsp.h      |    2 +-
 sound/soc/omap/omap-pcm.c        |    7 ++++---
 sound/soc/omap/omap-pcm.h        |    2 +-
 sound/soc/omap/rx51.c            |    2 +-
 13 files changed, 24 insertions(+), 23 deletions(-)
