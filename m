From: Javier Martinez Canillas <javier@osg.samsung.com>
Subject: [RFC PATCH 0/2] ASoC: Prevent the snow ASoC driver to spam due probe deferrals
Date: Wed, 19 Oct 2016 14:21:04 -0300
Message-ID: <1476897666-13974-1-git-send-email-javier@osg.samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Javier Martinez Canillas <javier@osg.samsung.com>, Jaroslav Kysela <perex@perex.cz>, alsa-devel@alsa-project.org, Sangbeom Kim <sbkim73@samsung.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Krzysztof Kozlowski <krzk@kernel.org>
List-Id: alsa-devel@alsa-project.org

Hello Mark,

Since v4.8 the Samsung snow ASoC driver needs more probe deferrals to
wait for all the resources to be available before its probe succeeds.

But this makes the error messages printed in the deferral path to do a
lot of spam in the kernel log. Slowing the boot process and even making
some boot testing to fail due timeouts [0].

This is an RFC series to prevent this to happen by limiting to one-time
messages in the case of deferrals. I know you mentioned in the past that
the correct fix for this is to have a proper dependency handling and be
able to probe in the correct order. But I'm sending as RFC in case you
think this can be a workaround to avoid the log spamming, until we have
support for that.

[0]: http://arm-soc.lixom.net/bootlogs/mainline/v4.8-14644-ge9f8f48/pi-arm-exynos_defconfig.html

Best regards,
Javier


Javier Martinez Canillas (2):
  ASoC: core: Print one-time messages if missing resources when binding
    DAIs
  ASoC: samsung: Print a one-time message if the snow driver's probe
    defers

 sound/soc/samsung/snow.c |  8 +++++++-
 sound/soc/soc-core.c     | 13 +++++++------
 2 files changed, 14 insertions(+), 7 deletions(-)

-- 
2.7.4
