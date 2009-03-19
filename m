From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: ASoC updates for 2.6.30
Date: Thu, 19 Mar 2009 12:00:28 +0000
Message-ID: <20090319120028.GA27550@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id BAA661038EC
	for <alsa-devel@alsa-project.org>; Thu, 19 Mar 2009 13:00:31 +0100 (CET)
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

The following changes since commit da88b48b84e1a504b6a19aff9d5b8236a59e228a:
  Mark Brown (1):
        Merge branch 'pxa-ssp' into for-2.6.30

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound-2.6.git for-2.6.30

Jarkko Nikula (2):
      ASoC: OMAP: N810: Mark not connected input pins
      ASoC: OMAP: N810: Add more jack functions

Lopez Cruz, Misael (1):
      ASoC: Declare Headset as Mic and Headphone widgets for SDP3430

Mark Brown (3):
      ASoC: Further optimise WM8400 bias configuration sequence
      ASoC: Add separate AVDD for WM8400
      ASoC: Add FLL support for WM8400

 sound/soc/codecs/wm8400.c |  159 ++++++++++++++++++++++++++++++++++++++-------
 sound/soc/omap/n810.c     |   33 +++++++++-
 sound/soc/omap/sdp3430.c  |   24 +++++--
 3 files changed, 181 insertions(+), 35 deletions(-)
