From: Adam Thomson <Adam.Thomson.Opensource-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH 0/6] ASoC: da7219: AB Silicon related updates and small fixes.
Date: Tue, 22 Dec 2015 18:27:49 +0000
Message-ID: <cover.1450807642.git.Adam.Thomson.Opensource@diasemi.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Takashi Iwai <tiwai-IBi9RG/b67k@public.gmane.org>, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Cc: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Support Opensource <support.opensource-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

This is a small collection of updates & fixes, put together for ease.

For changes relating to AB silicon, previous silicon revision is obsolete and
was unavailable outside of Dialog, so does not require driver support in the
future.

Changes are based on v4.4-rc6 kernel.

Adam Thomson (6):
  ASoC: da7219: Disable regulators on probe() failure
  ASoC: da7219: Fix Sidetone to work regardless of DAI capture
  ASoC: da7219: Update REFERENCES reg default, in-line with HW
  ASoC: da7219: Remove internal LDO features of codec
  ASoC: da7219: Add support for 1.6V micbias level
  ASoC: da7219: Remove support for 32KHz PLL mode

 Documentation/devicetree/bindings/sound/da7219.txt |  8 +-
 include/sound/da7219.h                             | 14 +---
 sound/soc/codecs/da7219.c                          | 87 +++++++---------------
 sound/soc/codecs/da7219.h                          |  9 ---
 4 files changed, 32 insertions(+), 86 deletions(-)

--
1.9.3

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
