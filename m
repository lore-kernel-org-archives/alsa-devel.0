From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 0/2] ALSA jack updates for 2.6.30
Date: Wed, 7 Jan 2009 20:11:34 +0000
Message-ID: <20090107201131.GA6413@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id DABD71037F0
	for <alsa-devel@alsa-project.org>; Wed,  7 Jan 2009 21:20:55 +0100 (CET)
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The following changes since commit 6a94cb73064c952255336cc57731904174b2c58f:
  Linus Torvalds (1):
        Merge branch 'for-linus' of git://oss.sgi.com/xfs/xfs

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound-2.6.git topic/jack-core

Jani Nikula (1):
      ALSA: Add support for video out to the jack reporting API

Mark Brown (1):
      ALSA: Reduce boilerplate for new jack types

 include/linux/input.h |    1 +
 include/sound/jack.h  |    5 +++++
 sound/core/jack.c     |   45 +++++++++++++++++++++------------------------
 3 files changed, 27 insertions(+), 24 deletions(-)
