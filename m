From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 00/17] ASoC: Remove codec field from
	snd_soc_dapm_widget
Date: Thu, 15 Jan 2015 12:52:00 +0100
Message-ID: <1421322737-19077-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-247.synserver.de (smtp-out-247.synserver.de
 [212.40.185.247])
 by alsa0.perex.cz (Postfix) with ESMTP id 1098D26046F
 for <alsa-devel@alsa-project.org>; Thu, 15 Jan 2015 12:52:22 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: Oder Chiou <oder_chiou@realtek.com>, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Jyri Sarha <jsarha@ti.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Bard Liao <bardliao@realtek.com>, Misael Lopez Cruz <misael.lopez@ti.com>
List-Id: alsa-devel@alsa-project.org

This series is the last part of the codec field removal from the
snd_soc_dapm_widget. One small fix for an issue that slipped through
earlier and the conversion of the TI and Realtek CODEC drivers and then
finally the removal itself.

The reason why it is removed is because it doesn't fit to well anymore in
the componentized ASoC hierarchy. And the alternative of
snd_soc_dapm_to_codec(w->dapm) typically generates the same amount of code,
so there is really no reason to keep it.

Depends on topic/w-codec and topic/rt5677.

- Lars

Lars-Peter Clausen (17):
  ASoC: mioa701_wm9713: Fix speaker event
  ASoC: pcm3008: Replace w->codec snd_soc_dapm_to_codec(w->dapm)
  ASoC: tlv320aic31xx: Replace w->codec snd_soc_dapm_to_codec(w->dapm)
  ASoC: tlv320aic3x: Replace w->codec snd_soc_dapm_to_codec(w->dapm)
  ASoC: tlv320dac33: Replace w->codec snd_soc_dapm_to_codec(w->dapm)
  ASoC: twl4030: Replace w->codec snd_soc_dapm_to_codec(w->dapm)
  ASoC: twl6040: Replace w->codec snd_soc_dapm_to_codec(w->dapm)
  ASoC: alc5623: Replace w->codec snd_soc_dapm_to_codec(w->dapm)
  ASoC: alc5632: Replace w->codec snd_soc_dapm_to_codec(w->dapm)
  ASoC: rt286: Replace w->codec snd_soc_dapm_to_codec(w->dapm)
  ASoC: rt5631: Replace w->codec snd_soc_dapm_to_codec(w->dapm)
  ASoC: rt5640: Replace w->codec snd_soc_dapm_to_codec(w->dapm)
  ASoC: rt5645: Replace w->codec snd_soc_dapm_to_codec(w->dapm)
  ASoC: rt5651: Replace w->codec snd_soc_dapm_to_codec(w->dapm)
  ASoC: rt5670: Replace w->codec snd_soc_dapm_to_codec(w->dapm)
  ASoC: rt5677: Replace w->codec snd_soc_dapm_to_codec(w->dapm)
  ASoC: Remove codec field from snd_soc_dapm_widget

 include/sound/soc-dapm.h         |  1 -
 sound/soc/codecs/alc5623.c       |  8 +++---
 sound/soc/codecs/alc5632.c       |  8 +++---
 sound/soc/codecs/pcm3008.c       |  4 +--
 sound/soc/codecs/rt286.c         | 15 ++++++-----
 sound/soc/codecs/rt5631.c        | 28 ++++++++++++--------
 sound/soc/codecs/rt5640.c        | 11 ++++----
 sound/soc/codecs/rt5645.c        | 16 +++++++-----
 sound/soc/codecs/rt5651.c        | 18 +++++++------
 sound/soc/codecs/rt5670.c        | 16 +++++++-----
 sound/soc/codecs/rt5677.c        | 23 +++++++++--------
 sound/soc/codecs/tlv320aic31xx.c |  9 ++++---
 sound/soc/codecs/tlv320aic3x.c   |  2 +-
 sound/soc/codecs/tlv320dac33.c   |  9 ++++---
 sound/soc/codecs/twl4030.c       | 55 +++++++++++++++++++++++++---------------
 sound/soc/codecs/twl6040.c       |  4 +--
 sound/soc/pxa/mioa701_wm9713.c   |  2 +-
 sound/soc/soc-dapm.c             |  2 --
 18 files changed, 132 insertions(+), 99 deletions(-)

-- 
1.8.0
