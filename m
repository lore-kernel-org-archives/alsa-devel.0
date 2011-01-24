From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: ASoC updates for 2.6.38
Date: Mon, 24 Jan 2011 15:17:38 +0000
Message-ID: <20110124151737.GG29925@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id DB99E244BA
	for <alsa-devel@alsa-project.org>; Mon, 24 Jan 2011 16:17:41 +0100 (CET)
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

The following changes since commit f758b53a79ce6076542739563985d5ff0521dc5a:

  Merge branch 'topic/hda' (2011-01-22 17:29:50 +0100)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound-2.6.git for-2.6.38

Usual small, driver-specific updates.

Dimitris Papastamos (1):
      ASoC: WM8995: Fix incorrect use of snd_soc_update_bits()

Mark Brown (1):
      ASoC: Handle low measured DC offsets for wm_hubs devices

Qiao Zhou (1):
      ASoC: WM8994: fix wrong value in tristate function

Rajashekhara, Sudhakar (1):
      ASoC: da8xx/omap-l1xx: match codec_name with i2c ids

 sound/soc/codecs/wm8994.c       |    2 +-
 sound/soc/codecs/wm8995.c       |    2 +-
 sound/soc/codecs/wm_hubs.c      |   15 +++++++--------
 sound/soc/davinci/davinci-evm.c |    2 +-
 4 files changed, 10 insertions(+), 11 deletions(-)
