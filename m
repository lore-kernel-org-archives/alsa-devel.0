From: Clemens Ladisch <clemens@ladisch.de>
Subject: [GIT PULL] fixes for wrong DB_RANGE_HEADER sizes
Date: Sun, 20 Nov 2011 16:21:03 +0100
Message-ID: <4EC91ADF.30702@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out2.smtp.messagingengine.com (out2.smtp.messagingengine.com
	[66.111.4.26]) by alsa0.perex.cz (Postfix) with ESMTP id 36DC924844
	for <alsa-devel@alsa-project.org>; Sun, 20 Nov 2011 16:21:16 +0100 (CET)
Received: from compute5.internal (compute5.nyi.mail.srv.osa [10.202.2.45])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 06F452102B
	for <alsa-devel@alsa-project.org>; Sun, 20 Nov 2011 10:21:15 -0500 (EST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The following changes since commit 1ea6b8f48918282bdca0b32a34095504ee65bab5:

  Linux 3.2-rc1 (2011-11-07 16:16:02 -0800)

are available in the git repository at:
  git://git.alsa-project.org/alsa-kprivate.git DB_RANGE-size-fixes

Clemens Ladisch (7):
      ASoC: adau1373: fix DB_RANGE size
      ASoC: rt5631: fix DB_RANGE size
      ASoC: sgtl5000: fix DB_RANGE size
      ASoC: wm8962: fix DB_RANGE size
      ASoC: wm8993: fix DB_RANGE size
      ASoC: wm9090: fix DB_RANGE size
      ASoC: wm_hubs: fix DB_RANGE size

 sound/soc/codecs/adau1373.c |    2 +-
 sound/soc/codecs/rt5631.c   |    2 +-
 sound/soc/codecs/sgtl5000.c |    2 +-
 sound/soc/codecs/wm8962.c   |    4 ++--
 sound/soc/codecs/wm8993.c   |    2 +-
 sound/soc/codecs/wm9090.c   |    6 +++---
 sound/soc/codecs/wm_hubs.c  |    2 +-
 7 files changed, 10 insertions(+), 10 deletions(-)
