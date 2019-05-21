From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH v6 0/2] ASoC: CX2072X codec support (revised,
	v6)
Date: Tue, 21 May 2019 08:26:51 +0200
Message-ID: <20190521062653.734-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id DEF67F806E7
 for <alsa-devel@alsa-project.org>; Tue, 21 May 2019 08:26:56 +0200 (CEST)
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

Hi,

the merge window was closed, and now it's time for fun again.
This is a v6 revision of ASoC CX2072X codec support patchset for Intel
platforms.


Takashi

===

v5->v6: Drop buggy&untested EQ and DRC codes
	Lots of code reduction/cleanup in codec driver
	Add more comments about platform-specific stuff

v4->v5: Move clk management to runtime PM
	Sparse warning fixes
	Some more code simplification
	Drop tricky regcache fiddling
	Apply mutex locks around possible racy sequences
	Move exported jack detection stuff into set_jack callback

v3->v4: Fix the wrong endianess conversion in reg write
	Minor code cleanups

v2->v3: CX2072X codec driver:
	* Move register tables to appropriate place
	* Remove some confusing codes
	* Set snd_ctl_boolean_* helpers directly
	* Fix EQ put callback
	* Rename to "DAC1 Switch" from "DAC1 Mute Switch"
	* Drop superfluous regmap calls at shutdown
	* Avoid regmap_register_patch()
	* Add missing register definitions
	* Fix register access on big-endian machine
	* Remove regcache messes
	CX2072X machine driver:
	* Add Pierre's ack
	* Drop superfluous ssp0 routes

v1->v2: Uncomment SOF entries in ACPI binding
        Move snd_soc_dai_set_bclk_ratio() call into init callback

The original cover letter is below:

===

It's been long time ago the first version of CX2072X codec patch was
submitted, and I hoped that it'd be resubmitted, but never happened,
as the original author seems to have left, unfortunately.

Since I have such a laptop (ASUS E200HA), I took some time to cook and
brush up the patches.  The patches are for 5.2, should be applicable
to ASoC tree for-next branch.

Will post the corresponding UCM profile patch once when this gets
accepted.


thanks,

Takashi

===

Simon Ho (1):
  ASoC: Add support for Conexant CX2072X CODEC

Takashi Iwai (1):
  ASoC: Intel: Add machine driver for CX2072X on BYT/CHT platforms

 sound/soc/codecs/Kconfig                          |    7 +
 sound/soc/codecs/Makefile                         |    2 +
 sound/soc/codecs/cx2072x.c                        | 1727 +++++++++++++++++++++
 sound/soc/codecs/cx2072x.h                        |  314 ++++
 sound/soc/intel/boards/Kconfig                    |   11 +
 sound/soc/intel/boards/Makefile                   |    2 +
 sound/soc/intel/boards/bytcht_cx2072x.c           |  262 ++++
 sound/soc/intel/common/soc-acpi-intel-byt-match.c |    8 +
 sound/soc/intel/common/soc-acpi-intel-cht-match.c |    8 +
 9 files changed, 2341 insertions(+)
 create mode 100644 sound/soc/codecs/cx2072x.c
 create mode 100644 sound/soc/codecs/cx2072x.h
 create mode 100644 sound/soc/intel/boards/bytcht_cx2072x.c

-- 
2.16.4
