From: Liam Girdwood <lrg@ti.com>
Subject: [GIT PULL] ASoC fixes for 3.0
Date: Mon, 4 Jul 2011 22:10:20 +0100
Message-ID: <4E122C3C.8080909@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from devils.ext.ti.com (devils.ext.ti.com [198.47.26.153])
	by alsa0.perex.cz (Postfix) with ESMTP id 27649103877
	for <alsa-devel@alsa-project.org>;
	Mon,  4 Jul 2011 23:10:26 +0200 (CEST)
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

The following changes since commit 4a787a3ff3f419c23ab0a5cef677fa441356b818:

  Merge branch 'for-2.6.40' of git://git.kernel.org/pub/scm/linux/kernel/git/lrg/asoc-2.6 into topic/asoc (2011-05-20 11:25:32 +0200)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/lrg/asoc-2.6.git for-3.0

Jarkko Nikula (2):
      ASoC: tlv320aic3x: Don't sync first two registers from register cache
      ASoC: tlv320aic3x: Do soft reset to codec when going to bias off state

Michael Williamson (1):
      audio: tlv320aic26: fix PLL register configuration

 sound/soc/codecs/tlv320aic26.c |   14 +++++++++++---
 sound/soc/codecs/tlv320aic3x.c |    9 ++++++++-
 2 files changed, 19 insertions(+), 4 deletions(-)
