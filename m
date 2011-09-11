From: Mika Westerberg <mika.westerberg@iki.fi>
Subject: [PATCH 0/7] ASoC: ep93xx: convert to use
	snd_soc_register_card()
Date: Sun, 11 Sep 2011 12:28:48 +0300
Message-ID: <cover.1315732452.git.mika.westerberg@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f51.google.com (mail-bw0-f51.google.com
	[209.85.214.51])
	by alsa0.perex.cz (Postfix) with ESMTP id BA5EA103845
	for <alsa-devel@alsa-project.org>;
	Sun, 11 Sep 2011 11:29:09 +0200 (CEST)
Received: by bkbzu17 with SMTP id zu17so740221bkb.38
	for <alsa-devel@alsa-project.org>; Sun, 11 Sep 2011 02:29:09 -0700 (PDT)
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
Cc: rmallon@gmail.com, Mika Westerberg <mika.westerberg@iki.fi>, broonie@opensource.wolfsonmicro.com, hsweeten@visionengravers.com, lrg@ti.com, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

Here is a series of patches which convert ep93xx ASoC drivers to use
snd_soc_register_card(). This has the advantage that the machine drivers get
loaded automatically by udev. Also this gets rid of machine_is_xxx() from the
machine drivers.

Tested on Sim.One. The edb93xx and snappercl15 changes are compile tested
only.

Mika Westerberg (7):
  ASoC: ep93xx-pcm: add MODULE_ALIAS
  ASoC: simone: convert to use snd_soc_register_card()
  ASoC: edb93xx: convert to use snd_soc_register_card()
  ASoC: snappercl15: convert to use snd_soc_register_card()
  ARM: ep93xx: simone: register audio platform device
  ARM: ep93xx: edb93xx: register audio platform device
  ARM: ep93xx: snappercl15: register audio platform device

 arch/arm/mach-ep93xx/edb93xx.c     |    6 +++
 arch/arm/mach-ep93xx/simone.c      |   13 +++++++-
 arch/arm/mach-ep93xx/snappercl15.c |   13 +++++++-
 sound/soc/ep93xx/edb93xx.c         |   60 ++++++++++++++++++---------------
 sound/soc/ep93xx/ep93xx-pcm.c      |    1 +
 sound/soc/ep93xx/simone.c          |   64 ++++++++++++++++++++----------------
 sound/soc/ep93xx/snappercl15.c     |   53 ++++++++++++++++++++---------
 7 files changed, 136 insertions(+), 74 deletions(-)

-- 
1.7.5.4
