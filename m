From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: ASoC updates for 3.2
Date: Wed, 30 Nov 2011 10:28:00 +0000
Message-ID: <20111130102800.GE2791@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id E30F91039A7
	for <alsa-devel@alsa-project.org>; Wed, 30 Nov 2011 11:28:10 +0100 (CET)
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
Cc: alsa-devel@alsa-project.org, Liam Girdwod <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

The following changes since commit fc8e6e8668e74fbf8e00d6e143d7f43b20f73f32:

  ASoC: Supply dcs_codes for newer WM1811 revisions (2011-11-28 23:18:38 +0000)

are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-3.2

fixing some bugs in the SigmaDSP code.  It's in the firmware subsystem
but that's orphaned and changes in -next move the code over to the ASoC
tree as these DSPs are specialist DSPs for audio use.

Lars-Peter Clausen (3):
      firmware: Sigma: Prevent out of bounds memory access
      firmware: Sigma: Skip header during CRC generation
      firmware: Sigma: Fix endianess issues

 drivers/firmware/sigma.c |   81 +++++++++++++++++++++++++++++++++-------------
 include/linux/sigma.h    |   13 ++-----
 2 files changed, 62 insertions(+), 32 deletions(-)
