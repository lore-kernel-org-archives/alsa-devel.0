From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: [GIT PULL] ASoC updates for 2.6.36
Date: Mon, 02 Aug 2010 10:53:50 +0100
Message-ID: <1280742830.3095.33.camel@odin>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ww0-f51.google.com (mail-ww0-f51.google.com [74.125.82.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 7382C24487
	for <alsa-devel@alsa-project.org>;
	Mon,  2 Aug 2010 11:53:54 +0200 (CEST)
Received: by wwe15 with SMTP id 15so2313672wwe.20
	for <alsa-devel@alsa-project.org>; Mon, 02 Aug 2010 02:53:54 -0700 (PDT)
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
Cc: alsa-devel <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Hi Takashi,

More updates for 2.6.36. Btw, when are you thinking of doing a pull
request for 2.6.36 ? I'm doing a multi-component patch series later
today and if all goes well it would be nice to get it in for the 2.6.36
merge window.

Thanks

Liam

---

The following changes since commit a7e7cd5bd7d1e0134032b8db5e64ceb9dac8b3ca:
  Kuninori Morimoto (1):
        ASoC: da7210: Add HeadPhone Playback Volume control

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/lrg/asoc-2.6.git for-2.6.36

Peter Ujfalusi (7):
      ASoC: TWL4030: Capture route DAPM event fix
      ASoC: tlv320dac33: Revisit the FIFO Mode1 handling
      ASoC: tlv320dac33: Add support for automatic FIFO configuration
      ASoC: omap-mcbsp: Restructure the code within omap_mcbsp_dai_hw_params
      ASoC: omap-mcbsp: Code cleanup in omap_mcbsp_dai_hw_params
      ASoC: omap-mcbsp: Support for sDMA packet mode
      ASoC: omap-mcbsp: Remove period size constraint in THRESHOLD mode

 include/sound/tlv320dac33-plat.h |    2 +
 sound/soc/codecs/tlv320dac33.c   |  125 ++++++++++++++++++++++------------
 sound/soc/codecs/twl4030.c       |    2 -
 sound/soc/omap/omap-mcbsp.c      |  137 +++++++++++++++++++++-----------------
 4 files changed, 158 insertions(+), 108 deletions(-)
