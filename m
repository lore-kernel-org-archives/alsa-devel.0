From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 00/11] ASoC: Add support for DAPM at the
	component level
Date: Sun, 18 May 2014 14:24:07 +0200
Message-ID: <1400415858-11025-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-145.synserver.de (smtp-out-151.synserver.de
 [212.40.185.151])
 by alsa0.perex.cz (Postfix) with ESMTP id 8EC80264EAA
 for <alsa-devel@alsa-project.org>; Sun, 18 May 2014 14:24:23 +0200 (CEST)
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
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

Hi,

This series is the next step in componentization. It moves the DAPM support to
the component level. This will allow any component to have DAPM widgets and
routes, which was previously only possible for CODECs, and will allow any
component to have DAPM widgets with controls (i.e. Mixers and MUXs), which was
previously only possible for CODECs. At the end of this patchset the DAPM code
will have (almost) no dependency on snd_soc_codec or snd_soc_platform and the
dependency on snd_soc_component is confined to 4 small helper functions. The
only reason why there is still snd_soc_codec/snd_soc_platform dependent code is
because there are still a lot of drivers which use widget->codec/platform and
dapm->codec/platform. So those still need to be initialized. This will be
cleaned up in a separate series and once that's done the codec and platform
fields will be removed from the widget and DAPM context struct.

One of the major problems of moving DAPM to the component level is that the DAPM
context is directly embedded in the snd_soc_codec and snd_soc_platform structs
and there are many drivers directly accessing that embedded field. This means it
is not possible to move the field without causing a bit of code churn in the
drivers. The patch series solves this by adding two fields to the component
struct. One pointer to a DAPM context, which points to the DAPM context that is
used by the component. And one DAPM context, which is used as the default if no
other DAPM context was provided. Neither of the fields is accessed directly,
instead a inline helper function is added that returns the DAPM context for a
component. This will make it possible to eventually seamlessly switch over once
all direct references to CODEC and platform DAPM contexts have been eliminated.

Depends on topic/component, topic/core, topic/dapm and topic/dt

- Lars

Lars-Peter Clausen (11):
  ASoC: Move name_prefix from CODEC to component
  ASoC: Move name and id from CODEC/platform to component
  ASoC: Split component registration into two steps
  ASoC: Auto disconnect pins from all DAPM contexts
  ASoC: Add helper functions to cast from DAPM context to
    CODEC/platform
  ASoC: Add a set_bias_level() callback to the DAPM context struct
  ASoC: Add DAPM support at the component level
  ASoC: Use component DAPM context for platforms
  ASoC: Add component level stream_event() and seq_notifier() support
  ASoC: Add component level set_bias_level() support
  ASoC: dapm: Remove DAI DAPM context

 include/sound/soc-dai.h        |   1 -
 include/sound/soc-dapm.h       |   6 +-
 include/sound/soc.h            |  78 ++++++++--
 include/trace/events/asoc.h    |   6 +-
 sound/soc/codecs/tlv320dac33.c |   2 +-
 sound/soc/soc-cache.c          |   7 +-
 sound/soc/soc-compress.c       |   8 +-
 sound/soc/soc-core.c           | 328 ++++++++++++++++++++++-------------------
 sound/soc/soc-dapm.c           | 180 ++++++++++++----------
 sound/soc/soc-pcm.c            |   4 +-
 10 files changed, 365 insertions(+), 255 deletions(-)

-- 
1.8.0
