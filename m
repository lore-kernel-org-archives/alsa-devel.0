From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: [GIT PULL] ASoC updates for 2.6.35
Date: Tue, 18 May 2010 11:19:45 +0100
Message-ID: <1274177985.3254.8.camel@odin>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179]) by alsa0.perex.cz (Postfix) with ESMTP id 70077248F8
	for <alsa-devel@alsa-project.org>;
	Tue, 18 May 2010 12:19:56 +0200 (CEST)
Received: by wyf19 with SMTP id 19so872330wyf.38
	for <alsa-devel@alsa-project.org>; Tue, 18 May 2010 03:19:52 -0700 (PDT)
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

Please pull the following ASoC updates for 2.6.35. We do have Tony's Ack
for the OMAP mcbsp stuff (as it simplifies the merging).

Thanks

Liam

---

The following changes since commit 6a2f1ee1f9bb5346644105c9355e9e06f6a847d3:
  Mark Brown (1):
        ASoC: Don't restart unconfigured WM8994 FLLs

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/lrg/asoc-2.6.git for-2.6.35

Felipe Balbi (1):
      ASoC: tlv320dac33: Use dev_dbg in dac33_hard_power function

Jorge Eduardo Candelaria (2):
      ARM: McBSP: Fix request for irq in OMAP4
      ARM: McBSP: Add support for omap4 in McBSP driver

Peter Ujfalusi (2):
      ASoC: TWL4030: Add control for digimic Left Right swap
      ASoC: tlv320dac33: Avoid powering off while in BIAS_OFF

Sergey Lapin (1):
      OMAP: McBSP: Add 32-bit mode support

 arch/arm/mach-omap2/mcbsp.c    |   12 ++++--------
 arch/arm/plat-omap/mcbsp.c     |   34 +++++++++++++++++++---------------
 sound/soc/codecs/tlv320dac33.c |    5 ++++-
 sound/soc/codecs/twl4030.c     |   12 ++++++++++++
 sound/soc/omap/omap-mcbsp.c    |   28 ++++++++++++++++++++++++----
 5 files changed, 63 insertions(+), 28 deletions(-)
