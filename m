From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: ASoC updates for 2.6.38
Date: Thu, 10 Mar 2011 14:20:35 +0000
Message-ID: <20110310142035.GA18973@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id D23612414C
	for <alsa-devel@alsa-project.org>; Thu, 10 Mar 2011 15:20:17 +0100 (CET)
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

The following changes since commit ffd6eae2a0d18ca4a741615292a9c9ce904307fb:

  ASoC: AM3517: Update codec name after multi-component update (2011-03-09 11:48:55 +0000)

are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound-2.6.git for-2.6.38

Mark Brown (4):
      ASoC: Fix broken bitfield definitions in WM8978
      ASoC: Use the correct DAPM context when cleaning up final widget set
      ASoC: Fix typo in late revision WM8994 DAC2R name
      ASoC: Ensure WM8958 gets all WM8994 late revision widgets

The DAPM context fix is essential for multi-component DAPM, without it
we will try to apply updates from the end of DAPM sequences to the wrong
device which isn't terribly clever.  On other systems the change will be
a noop.

The other three updates are device specific ones, the WM8994/58 ones are
slightly more invasive but are critical to WM8958.

There may be one more update (for mini2440) coming later.

 sound/soc/codecs/wm8978.c |   14 ++++++++------
 sound/soc/codecs/wm8994.c |   10 +++++++++-
 sound/soc/soc-dapm.c      |    2 +-
 3 files changed, 18 insertions(+), 8 deletions(-)
