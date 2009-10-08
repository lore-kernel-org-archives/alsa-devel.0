From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: ASoC updates for 2.6.32
Date: Thu, 8 Oct 2009 10:45:50 +0100
Message-ID: <20091008094550.GA31257@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id D124510391E
	for <alsa-devel@alsa-project.org>;
	Thu,  8 Oct 2009 11:45:53 +0200 (CEST)
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

The following changes since commit 2a0f5cb32772e9a9560209e241a80bfbbc31dbc3:
  Mark Brown (1):
        Merge branch 'for-2.6.32' of git://git.kernel.org/.../broonie/sound-2.6 into for-2.6.32

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound-2.6.git for-2.6.32

Mark Brown (3):
      ASoC: Remove absent SYNC and TDM DAI format options from i.MX SSI
      ASoC: WM8350 capture PGA mutes are inverted
      Merge branch 'upstream/wm8350' into for-2.6.32

 sound/soc/codecs/wm8350.c |    4 ++--
 sound/soc/imx/mxc-ssi.c   |    8 --------
 2 files changed, 2 insertions(+), 10 deletions(-)
