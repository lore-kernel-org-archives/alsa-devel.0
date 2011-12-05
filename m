From: Vinod Koul <vinod.koul@linux.intel.com>
Subject: [PATCH v3 0/6] core: add compress data API to ALSA
	kernel
Date: Mon,  5 Dec 2011 13:09:45 +0530
Message-ID: <1323070791-12620-1-git-send-email-vinod.koul@linux.intel.com>
References: <1321951920-4363-1-git-send-email-vinod.koul@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by alsa0.perex.cz (Postfix) with ESMTP id 0C931243D1
	for <alsa-devel@alsa-project.org>; Mon,  5 Dec 2011 08:41:49 +0100 (CET)
In-Reply-To: <1321951920-4363-1-git-send-email-vinod.koul@linux.intel.com>
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
Cc: tiwai@suse.de, Vinod Koul <vinod.koul@linux.intel.com>, broonie@opensource.wolfsonmicro.com, lrg@ti.com
List-Id: alsa-devel@alsa-project.org

As agreed during the ASoC workshop in May 2011, this set of patches are a
proposal from Intel to add a new compressed data interface to ALSA. This
proposal builds on the existing Intel solution and the experience gathered over
two years with Meego and Android solutions. This proposal is no longer
Intel-specific and was generalized with the addition of a basic core;
codec-related definitions are based on the vendor-neutral OpenMAX AL standard. 

These patches are also available in git tree:
git://git.infradead.org/users/vkoul/snd-compress.git v3_patches

Changes in v3:
 Fixed the device registration for compressed devices as discussed
 moved card creation to lower level drivers
 Added new api for device node creation
 changes fragment/frame callbacks to single inlined callback

Changes in v2:
 Fixed the comments revived in v2
 Fixed the comments recieved during LPC discussions
 add support for alsa device registeration
 fix the bugs found in testing

Omair Mohammed Abdullah (1):
  core: add support for compressed devices

Pierre-Louis Bossart (1):
  compress API documentation

Vinod Koul (4):
  core: add compress parameter definations
  core: add API header and driver header files
  core: add support for compress_offload
  core: add makefile and kconfig file for compress

 Documentation/sound/alsa/snd_compress_data.txt |  184 +++++++
 include/sound/compress_driver.h                |  164 ++++++
 include/sound/compress_offload.h               |  151 +++++
 include/sound/core.h                           |    1 +
 include/sound/minors.h                         |    7 +-
 include/sound/snd_compress_params.h            |  395 +++++++++++++
 sound/core/Kconfig                             |    8 +
 sound/core/Makefile                            |    4 +
 sound/core/compress_offload.c                  |  701 ++++++++++++++++++++++++
 sound/core/sound.c                             |    6 +
 10 files changed, 1620 insertions(+), 1 deletions(-)
 create mode 100644 Documentation/sound/alsa/snd_compress_data.txt
 create mode 100644 include/sound/compress_driver.h
 create mode 100644 include/sound/compress_offload.h
 create mode 100644 include/sound/snd_compress_params.h
 create mode 100644 sound/core/compress_offload.c
