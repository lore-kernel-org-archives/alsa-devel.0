From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 0/2] Support for button reporting on jacks
Date: Wed, 17 Mar 2010 18:22:43 +0000
Message-ID: <20100317182242.GA990@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 8F3731037F3
	for <alsa-devel@alsa-project.org>; Wed, 17 Mar 2010 19:22:46 +0100 (CET)
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

This patch series adds support for key reporting to the generic ALSA
jack API.  Currently a series of switches are supported, with the jack
implementation assuming that only switches will be used.  This isn't
ideal for things like the simple buttons implemented in headsets which
are used in the same way as keyboard keys and physically resemble them
more closely than switches.

If this is applied I'd like if possible to merge the topic into the ASoC
tree so that I can use it in machine drivers there.

The following changes since commit 57d54889cd00db2752994b389ba714138652e60c:
  Linus Torvalds (1):
        Linux 2.6.34-rc1

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound-2.6.git topic/jack

Mark Brown (2):
      ALSA: Rename jack switch table in preparation for button support
      ALSA: Add support for key reporting via the jack interface

 include/sound/jack.h |    8 +++++
 sound/core/jack.c    |   71 +++++++++++++++++++++++++++++++++++++++++++++----
 2 files changed, 73 insertions(+), 6 deletions(-)
