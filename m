From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH 00/15] ASoC: Intel: pass platform name to
	machine drivers
Date: Fri, 25 Jan 2019 14:34:54 -0600
Message-ID: <20190125203509.22994-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id DCF9B26680F
 for <alsa-devel@alsa-project.org>; Fri, 25 Jan 2019 21:35:14 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: tiwai@suse.de, liam.r.girdwood@linux.intel.com, vkoul@kernel.org, broonie@kernel.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

To reuse the same machine drivers with Atom/SST, Skylake and SOF, we
need to change the default platform_name (or platforms->name in the
"modern" representation).

So far, this override was done with an automatic override, which was
broken by a set of changes for DT platforms related to deferred probe
handling.

This automatic override is actually not really needed, the machine
driver can already receive the platform name as a platform_data
parameter. This is used e.g. for HDaudio support where we have
different PCI aliases used for different platforms. We can reuse the
same mechanism and modify the machine drivers to override the dailinks
prior to registrating the card.

This will require additional work for SOF, but with this helper it'll
be just two lines of additional code per machine driver which is
reused, not the end of the world.

This helper can be simplified when all drivers have transitioned to
the "modern" representation of dailinks.

While these changes are simple and largely mechanical, there is always
a risk. These patches were tested with Asus T100 (rt5640), rt5651,
rt5682, pcm512x, both in SST and SOF cases. Additional tests are
on-going for Chromebook platforms and Broadwell. I figured it was
better to share this patchset earlier to get more feedback.

Note that byt-max98080, byt-rt5640 were not modified since they are
deprecated. bytcht-nocodec and the Skylake/Kabylake machine drivers
changes were not changed since SOF does not support them. There may be
additional changes if and when Skylake/Kabylake are supported by SOF
(largely a firmware authentication issue, not technical difficulty).

Pierre-Louis Bossart (15):
  ASoC: add helper to change platform name for all dailinks
  ASoC: Intel: haswell: platform name fixup support
  ASoC: Intel: broadwell: platform name fixup support
  ASoC: Intel: bdw-rt5677: platform name fixup support
  ASoC: Intel: bytcr_rt5640: platform name fixup support
  ASoC: Intel: bytcr_rt5651: platform name fixup support
  ASoC: Intel: bytcht_da7213: platform name fixup support
  ASoC: Intel: bytcht_es8316: platform name fixup support
  ASoC: Intel: cht_bsw_max98090_ti: platform name fixup support
  ASoC: Intel: cht_bsw_nau8824: platform name fixup support
  ASoC: Intel: cht_bsw_rt5645: platform name fixup support
  ASoC: Intel: cht_bsw_rt5672: platform name fixup support
  ASoC: Intel: bxt_da7219_max98357a: platform name fixup support
  ASoC: Intel: bxt_rt298: platform name fixup support
  ASoC: Intel: glk_rt5682_max98357a: platform name fixup support

 include/sound/soc.h                           | 31 +++++++++++++++++++
 sound/soc/intel/boards/bdw-rt5677.c           | 14 +++++++++
 sound/soc/intel/boards/broadwell.c            | 16 ++++++++++
 sound/soc/intel/boards/bxt_da7219_max98357a.c | 13 ++++++++
 sound/soc/intel/boards/bxt_rt298.c            | 13 ++++++++
 sound/soc/intel/boards/bytcht_da7213.c        |  8 +++++
 sound/soc/intel/boards/bytcht_es8316.c        |  9 ++++++
 sound/soc/intel/boards/bytcr_rt5640.c         |  9 ++++++
 sound/soc/intel/boards/bytcr_rt5651.c         |  9 ++++++
 sound/soc/intel/boards/cht_bsw_max98090_ti.c  | 12 +++++++
 sound/soc/intel/boards/cht_bsw_nau8824.c      | 12 +++++++
 sound/soc/intel/boards/cht_bsw_rt5645.c       |  9 ++++++
 sound/soc/intel/boards/cht_bsw_rt5672.c       |  9 ++++++
 sound/soc/intel/boards/glk_rt5682_max98357a.c | 21 ++++++++++---
 sound/soc/intel/boards/haswell.c              | 15 +++++++++
 15 files changed, 196 insertions(+), 4 deletions(-)

-- 
2.17.1
