From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: ASoC updates for 2.6.38
Date: Wed, 2 Mar 2011 11:34:16 +0000
Message-ID: <20110302113415.GA18103@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 927511037EC
	for <alsa-devel@alsa-project.org>; Wed,  2 Mar 2011 12:34:19 +0100 (CET)
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

The following changes since commit 43c63188821dc21b2af23a40a18faea6e386e90a:

  eukrea-tlv320: fix platform_name (2011-02-25 12:57:49 +0000)

are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound-2.6.git for-2.6.38

Dimitris Papastamos (2):
      ASoC: WM8994: Don't disable the AIF[1|2]CLK_ENA unconditionaly
      ASoC: WM8994: Ensure late enable events are processed for the ADCs

Mark Brown (1):
      ASoC: Fix WM9081 platform data initialisation

 sound/soc/codecs/wm8994.c |   51 +++++++++++++++++++++++++++++++++++++--------
 sound/soc/codecs/wm9081.c |    5 ++++
 2 files changed, 47 insertions(+), 9 deletions(-)
