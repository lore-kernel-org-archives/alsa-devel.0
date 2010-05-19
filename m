From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: [GIT PULL] ASoC updates for 2.6.35
Date: Wed, 19 May 2010 17:15:58 +0100
Message-ID: <1274285758.3240.189.camel@odin>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f51.google.com (mail-fx0-f51.google.com
	[209.85.161.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 676BB103963
	for <alsa-devel@alsa-project.org>;
	Wed, 19 May 2010 18:16:12 +0200 (CEST)
Received: by fxm18 with SMTP id 18so2362705fxm.38
	for <alsa-devel@alsa-project.org>; Wed, 19 May 2010 09:16:10 -0700 (PDT)
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

The last one for 2.6.35 :)

Thanks

Liam

----

The following changes since commit 2d4cdd6fc974716555fcbaf7ec1d4dda22784c1b:
  Peter Ujfalusi (1):
        ASoC: tlv320dac33: Avoid powering off while in BIAS_OFF

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/lrg/asoc-2.6.git for-2.6.35

Jarkko Nikula (1):
      ASoC: tpa6130a2: Define output pins with SND_SOC_DAPM_OUTPUT

Jorge Eduardo Candelaria (2):
      ASoC: SDP4430: Add support for Earphone speaker
      ASoC: TWL6040: Enable earphone path in codec

Liam Girdwood (1):
      ASoC: sdp4430 - add sdp4430 pcm ops to DAI.

Misael Lopez Cruz (1):
      ASoC: SDP4430: Add sdp4430 machine driver

 sound/soc/codecs/tpa6130a2.c |    4 +-
 sound/soc/codecs/twl6040.c   |   21 ++++-
 sound/soc/omap/Kconfig       |    9 ++
 sound/soc/omap/Makefile      |    2 +
 sound/soc/omap/sdp4430.c     |  233 ++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 266 insertions(+), 3 deletions(-)
 create mode 100644 sound/soc/omap/sdp4430.c
