From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: ASoC updates for 3.2
Date: Tue, 8 Nov 2011 10:46:32 +0000
Message-ID: <20111108104632.GC25591@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 3764F2436A
	for <alsa-devel@alsa-project.org>; Tue,  8 Nov 2011 11:46:35 +0100 (CET)
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
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

The following changes since commit 1ea6b8f48918282bdca0b32a34095504ee65bab5:

  Linux 3.2-rc1 (2011-11-07 16:16:02 -0800)

are available in the git repository at:
  git://opensource.wolfsonmicro.com/linux-2.6-asoc.git for-3.2

This is mostly a merge up of 3.2 rather than new code.

Mark Brown (5):
      ASoC: Update git repository URL
      ASoC: Don't use wm8994->control_data in wm8994_readable_register()
      ASoC: Don't use wm8994->control_data when requesting IRQs
      ASoC: Ensure we get an impedence reported for WM8958 jack detect
      Merge branch 'for-3.2' of git://git.kernel.org/.../broonie/sound into for-3.2

 MAINTAINERS                          |    2 +-
 include/linux/mfd/wm8994/registers.h |   15 ++++++++++++
 sound/soc/codecs/wm8994.c            |   43 +++++++++++++++++++++++-----------
 3 files changed, 45 insertions(+), 15 deletions(-)
