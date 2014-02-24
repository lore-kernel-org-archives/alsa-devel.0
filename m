From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: [PATCH 0/7] ASoC: Intel: Add support for Baytrail SST
	DSP
Date: Mon, 24 Feb 2014 17:26:55 +0200
Message-ID: <1393255622-31365-1-git-send-email-jarkko.nikula@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id C0264261A18
 for <alsa-devel@alsa-project.org>; Mon, 24 Feb 2014 16:27:10 +0100 (CET)
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
Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>, Mark Brown <broonie@kernel.org>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

This set adds support for Baytrail SST DSP with RT5640 based machine
driver. Design is quite similar and is actually inherited from Intel
Haswell SST DSP drivers that were posted recently. Reason for another
implementation is that there are more differences than similarities
between Haswell and Baytrail.

First difference comes from the SHIM registers that are 32-bit on
Haswell and 64-bit on Baytrail. Also memory map and message mailbox is
different. Second difference is message passing and message headers
between host and SST DSP. For instance the DSP notifies the host using
different SHIM registers and bits than on Haswell.

Biggest difference comes from the DSP firmware. It has different IPC
messages, stream setup and how DMA pointer is tracked. Currently
firmware has less features than Haswell DSP firmware and it doesn't
support compress offload and volume controls support.

The RT5640 based machine driver is for our customer reference boards
but at quick test it appears to work on Asus T100 too. Note currently
the SST is the I2S master on this machine driver and codec is set to
use I2C BCLK as it's input clock.

Jarkko Nikula (7):
  ASoC: Intel: Add Baytrail SST ID and Baytrail specific register bits
  ASoC: Intel: Add Intel Baytrail SST DSP support
  ASoC: Intel: Add Intel Baytrail SST DSP IPC support
  ASoC: Intel: Add Intel Baytrail SST PCM platform driver
  ASoC: Intel: Add machine driver for Baytrail SST with RT5640 codec
  ASoC: Intel: Add Baytrail SST and byt-rt5640 machine driver probing
  ASoC: Intel: Add build support for Baytrail SST

 sound/soc/intel/Kconfig            |  14 +-
 sound/soc/intel/Makefile           |   5 +
 sound/soc/intel/byt-rt5640.c       | 194 +++++++++
 sound/soc/intel/sst-acpi.c         |  17 +
 sound/soc/intel/sst-baytrail-dsp.c | 372 ++++++++++++++++
 sound/soc/intel/sst-baytrail-ipc.c | 866 +++++++++++++++++++++++++++++++++++++
 sound/soc/intel/sst-baytrail-ipc.h |  69 +++
 sound/soc/intel/sst-baytrail-pcm.c | 422 ++++++++++++++++++
 sound/soc/intel/sst-dsp-priv.h     |   1 +
 sound/soc/intel/sst-dsp.h          |  11 +
 10 files changed, 1970 insertions(+), 1 deletion(-)
 create mode 100644 sound/soc/intel/byt-rt5640.c
 create mode 100644 sound/soc/intel/sst-baytrail-dsp.c
 create mode 100644 sound/soc/intel/sst-baytrail-ipc.c
 create mode 100644 sound/soc/intel/sst-baytrail-ipc.h
 create mode 100644 sound/soc/intel/sst-baytrail-pcm.c

-- 
1.8.5.3
