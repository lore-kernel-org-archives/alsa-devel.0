From: Vinod Koul <vinod.koul@linux.intel.com>
Subject: [PATCH 0/3] ASoC: add compress stream support
Date: Thu, 16 Aug 2012 17:10:39 +0530
Message-ID: <1345117242-26975-1-git-send-email-vinod.koul@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [143.182.124.21])
 by alsa0.perex.cz (Postfix) with ESMTP id D131F265B5D
 for <alsa-devel@alsa-project.org>; Thu, 16 Aug 2012 13:08:56 +0200 (CEST)
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
Cc: Vinod Koul <vinod.koul@linux.intel.com>, broonie@opensource.wolfsonmicro.com, lrg@ti.com
List-Id: alsa-devel@alsa-project.org

Here is the much delayed support for compress audio streams in ASoC.
The v2 incorprates feedback discussed on v1 patches and this also adds
the support in Intel drivers.

Namarta Kohli (1):
  ASoC: add compress stream support

Vinod Koul (2):
  ASoC: add definations for compressed operations
  ASoC: mid-x86 - add support for compressed streams

 include/sound/compress_driver.h  |    1 +
 include/sound/soc-dai.h          |    3 +
 include/sound/soc.h              |   16 ++-
 sound/soc/Kconfig                |    1 +
 sound/soc/Makefile               |    2 +-
 sound/soc/mid-x86/mfld_machine.c |    9 ++
 sound/soc/mid-x86/sst_dsp.h      |  134 +++++++++++++++++
 sound/soc/mid-x86/sst_platform.c |  204 ++++++++++++++++++++++++++-
 sound/soc/mid-x86/sst_platform.h |   26 ++++-
 sound/soc/soc-compress.c         |  295 ++++++++++++++++++++++++++++++++++++++
 sound/soc/soc-core.c             |   57 +++++---
 11 files changed, 721 insertions(+), 27 deletions(-)
 create mode 100644 sound/soc/mid-x86/sst_dsp.h
 create mode 100644 sound/soc/soc-compress.c
