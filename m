From: Vinod Koul <vinod.koul@linux.intel.com>
Subject: [RFC PATCH 0/2] ASoC: add compress stream support
Date: Tue, 31 Jul 2012 12:11:38 +0530
Message-ID: <1343716900-23491-1-git-send-email-vinod.koul@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 01F43265CD9
 for <alsa-devel@alsa-project.org>; Tue, 31 Jul 2012 08:40:57 +0200 (CEST)
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
Cc: Vinod Koul <vinod.koul@linux.intel.com>, broonie@opensource.wolfsonmicro.com, pierre-louis.bossart@linux.intel.com, ramesh.babu@intel.com, namartax.kohli@intel.com, lrg@ti.com
List-Id: alsa-devel@alsa-project.org

Here is the much delayed support for compress audio streams in ASoC.
This patch series is in RFC form, once we have agreed on this I will send
the patches supporting Intel driver as well.

Mainly we indicate if the dai is of compressed nature and based on that
register a new compressed device. Also the platform driver adds the compress
stream operations.
Since the codecs handles PCM only, the assumption is that they will not have
anything to do here and machine needs to set codec appropriately for compressed
streams. In future if codec with such support are available then we can simply
add compressed operations into codec as well

Comments, criticism welcome...

--
Namarta Kohli (1):
  ASoC: add compress stream support

Vinod Koul (1):
  ASoC: add definations for compressed operations

 include/sound/compress_driver.h |    1 +
 include/sound/soc-dai.h         |    2 +
 include/sound/soc.h             |   17 ++-
 sound/soc/Makefile              |    2 +-
 sound/soc/soc-compress.c        |  297 +++++++++++++++++++++++++++++++++++++++
 sound/soc/soc-core.c            |   10 ++-
 6 files changed, 326 insertions(+), 3 deletions(-)
 create mode 100644 sound/soc/soc-compress.c
