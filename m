From: Vinod Koul <vinod.koul@linux.intel.com>
Subject: [PATCH 0/6] compress: add compress data API to ALSA
	kernel
Date: Tue, 22 Nov 2011 14:21:54 +0530
Message-ID: <1321951920-4363-1-git-send-email-vinod.koul@linux.intel.com>
References: <1314943585-11670-1-git-send-email-vinod.koul@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [143.182.124.37])
	by alsa0.perex.cz (Postfix) with ESMTP id 96814103996
	for <alsa-devel@alsa-project.org>; Tue, 22 Nov 2011 09:56:07 +0100 (CET)
In-Reply-To: <1314943585-11670-1-git-send-email-vinod.koul@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: tiwai@suse.de, Vinod Koul <vinod.koul@linux.intel.com>, broonie@opensource.wolfsonmicro.com, lrg@ti.com, pierre-louis.bossart@linux.intel.com
List-Id: alsa-devel@alsa-project.org

As agreed during the ASoC workshop in May 2011, this set of patches are a
proposal from Intel to add a new compressed data interface to ALSA. This
proposal builds on the existing Intel solution and the experience gathered over
two years with Meego and Android solutions. This proposal is no longer
Intel-specific and was generalized with the addition of a basic core;
codec-related definitions are based on the vendor-neutral OpenMAX AL standard. 

These patches are also availble in git tree:
git://git.infradead.org/users/vkoul/snd-compress.git v2_patches

Changes in v2:
 Fixed the comments revived in v2
 Fixed the comments recieved during LPC discussions
 add support for alsa device registeration
 fix the bugs found in testing

Omair Mohammed Abdullah (1):
  core: add support for compressed devices

Vinod Koul (5):
  compress API documentation
  compress: add compress parameter definations
  compress: add API header and driver header files
  compress: add the core file
  compress: add makefile and kconfig file

 .../sound/alsa/compress/snd_compress_data.txt      |  187 +++++
 include/sound/compress_driver.h                    |  161 ++++
 include/sound/compress_offload.h                   |  150 ++++
 include/sound/core.h                               |    1 +
 include/sound/minors.h                             |    7 +-
 include/sound/snd_compress_params.h                |  395 +++++++++
 sound/Kconfig                                      |    2 +
 sound/Makefile                                     |    3 +-
 sound/compress_offload/Kconfig                     |   17 +
 sound/compress_offload/Makefile                    |    4 +
 sound/compress_offload/core.c                      |  839 ++++++++++++++++++++
 sound/core/sound.c                                 |    6 +
 12 files changed, 1770 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/sound/alsa/compress/snd_compress_data.txt
 create mode 100644 include/sound/compress_driver.h
 create mode 100644 include/sound/compress_offload.h
 create mode 100644 include/sound/snd_compress_params.h
 create mode 100644 sound/compress_offload/Kconfig
 create mode 100644 sound/compress_offload/Makefile
 create mode 100644 sound/compress_offload/core.c
