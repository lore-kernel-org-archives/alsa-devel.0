From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 00/13] ASoC: Componentization: Unified
	probe/remove path
Date: Tue, 19 Aug 2014 15:51:17 +0200
Message-ID: <1408456290-13945-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-165.synserver.de (smtp-out-167.synserver.de
 [212.40.185.167])
 by alsa0.perex.cz (Postfix) with ESMTP id 2705F26581B
 for <alsa-devel@alsa-project.org>; Tue, 19 Aug 2014 15:57:43 +0200 (CEST)
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

This patch-set starts with consolidating the probe and remove paths of
snd_soc_codec and snd_soc_platform drivers. Once that has been done it uses the
new generic paths to also add probe and remove support to snd_soc_component
drivers. With that in place the AUX dev handling is then moved to the component
layer as there is no longer any snd_soc_codec specifics required to handle
them. The later patches in the series deal with cleaning things up and
consolidating a few code paths between CPU and CODEC DAI handling.

After this patch-set the core of the ASoC core is now fully componentized and
doesn't care anymore (except for one small hack which is documented in the
commit) about whether something is a snd_soc_codec, snd_soc_platform or
snd_soc_component. This does unfortunately not mean that componentization is
done yet. There are still a few things left to do. This includes bringing more
things to the component level for example clock and PCM handling. There is also
still the issue that we handle CPU DAIs and CODEC DAIs differently. For CODEC
DAIs the capture stream is output and the playback stream is input while it is
the other way around for CPU DAIs. Also we expect them to handle the
SND_SOC_DAIFMT_CBx_CFx settings depending on whether they are a CPU or CODEC
DAI. So we need a way to distinguish between the two.

At this point it is already possible though to convert simple snd_soc_codec
drivers that don't need any of this (e.g. some of the external amplifier
drivers) to snd_soc_components. Since the series adds a centralized path for
probing and removing it also paves the way towards easier integration of the
drivers/base/component.c framework, which in turn will allow some cleanups and
to fix some long standing bugs in the way hot-unplug is handled (or rather not
handled).

- Lars

Lars-Peter Clausen (13):
  ASoC: Move debugfs registration to the component level
  ASoC: Consolidate platform and CODEC probe/remove
  ASoC: Make rtd->codec optional
  ASoC: Add component level probe/remove support
  ASoC: Move AUX dev support to the component level
  ASoC: Pass component instead of DAPM context to AUX dev init callback
  ASoC: Move component->probed check into
    soc_{remove,probe}_component()
  ASoC: Cleanup DAI module reference counting
  ASoC: Consolidate CPU and CODEC DAI removal
  ASoC: Consolidate CPU and CODEC DAI look-up
  ASoC: Automatically initialize regmap for all components
  ASoC: Remove support for legacy snd_soc_platform IO
  ASoC: Replace list_empty(&card->codec_dev_list) with
    !card->instantiated

 include/sound/soc.h                   |  67 ++--
 sound/soc/samsung/speyside.c          |   6 +-
 sound/soc/soc-core.c                  | 667 ++++++++++++++++------------------
 sound/soc/soc-generic-dmaengine-pcm.c |   4 +-
 sound/soc/soc-io.c                    |  28 --
 5 files changed, 357 insertions(+), 415 deletions(-)

-- 
1.8.0
