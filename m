From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Merge of 2.6.32-rc3 into fix/asoc
Date: Tue, 6 Oct 2009 13:03:23 +0100
Message-ID: <20091006120323.GD10118@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id A0FDA24405
	for <alsa-devel@alsa-project.org>;
	Tue,  6 Oct 2009 14:03:24 +0200 (CEST)
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

I've pushed an update of the fix/asoc branch which has 2.6.32-rc3 merged
up to my git.  This gets underlying platform support from other trees
into the branch and will also (once it's merged up there) give topic/asoc
access to things like the genirq improvements for I2C and SPI devices
which were merged during the merge window.

The following changes since commit e655a43544bd3c45a83da93b00a4b115b4fa758e:
  Jonathan Cameron (1):
        ASoC: wm8940: Fix check on error code form snd_soc_codec_set_cache_io

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound-2.6.git for-2.6.32-merge

Changelog omitted - the only changes since your fix/asoc should be those
from Linus' tree and the merge commit.
