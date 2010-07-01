From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: ASoC updates for 2.6.36
Date: Thu, 1 Jul 2010 19:43:22 +0100
Message-ID: <20100701184322.GI8742@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 91FEB243F8
	for <alsa-devel@alsa-project.org>;
	Thu,  1 Jul 2010 20:43:23 +0200 (CEST)
Content-Disposition: inline
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
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

The following changes since commit e827e32efc313e1a061c81007e96fff439ccb802:

  Merge branch 'for-2.6.36' of git://git.kernel.org/pub/scm/linux/kernel/gi=
t/lrg/asoc-2.6 into topic/asoc (2010-06-24 11:11:41 +0200)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound-2.6.git for-2=
.6.36

Eric B=E9nard (1):
      ASoC: clean i.MX Kconfig

Kuninori Morimoto (1):
      ASoC: ak4642: Add Digital Playback Volume control

Mark Brown (1):
      Merge remote branch 'takashi/topic/asoc' into for-2.6.36

Vladimir Zapolskiy (4):
      ASoC: uda134x: replace a macro with a value in platform struct.
      ASoC: uda134x: fix bias level setup on initialization
      ASoC: uda134x: add DATA011 register found in codecs family
      ASoC: uda134x: correct bias level setup for codecs family

 include/sound/uda134x.h    |   12 ++++++++
 sound/soc/codecs/ak4642.c  |   24 ++++++++++++++--
 sound/soc/codecs/uda134x.c |   64 +++++++++++++++++++++++++++++-----------=
---
 sound/soc/codecs/uda134x.h |    5 ++-
 sound/soc/imx/Kconfig      |   14 ++++-----
 5 files changed, 85 insertions(+), 34 deletions(-)
