From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: ASoC updates for 2.6.37
Date: Thu, 2 Dec 2010 13:28:10 +0000
Message-ID: <20101202132810.GF859@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 81443103840
	for <alsa-devel@alsa-project.org>; Thu,  2 Dec 2010 14:28:12 +0100 (CET)
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

The following changes since commit 649e5fb033bbadbfa78aba5e2711f1faf2affaf0:

  Merge branch 'for-2.6.37' into for-2.6.38 (2010-11-29 18:33:47 +0000)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound-2.6.git for-2=
.6.37

All isolated bug fixes in drivers, and in the case of s6000 the fact
that it won't build anyway does lower the risk :)

Axel Lin (1):
      ASoC: Fix missing spin_unlock_irqrestore

Daniel Gl=F6ckner (3):
      s6000-i2s: fix compilation
      s6000-pcm: fix compilation
      s6105-ipcam: fix compilation

Dimitris Papastamos (1):
      ASoC: WM8731: Fix incorrect mask for bypass path disable

 sound/soc/codecs/wm8731.c     |    2 +-
 sound/soc/nuc900/nuc900-pcm.c |    9 +++++----
 sound/soc/s6000/s6000-i2s.c   |    2 +-
 sound/soc/s6000/s6000-pcm.c   |    2 +-
 sound/soc/s6000/s6105-ipcam.c |    2 +-
 5 files changed, 9 insertions(+), 8 deletions(-)
