From: Vinod Koul <vinod.koul@linux.intel.com>
Subject: [RFC 0/5] compress: add compress data API to ALSA
	kernel
Date: Fri,  2 Sep 2011 11:36:20 +0530
Message-ID: <1314943585-11670-1-git-send-email-vinod.koul@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by alsa0.perex.cz (Postfix) with ESMTP id 13D9B103865
	for <alsa-devel@alsa-project.org>;
	Fri,  2 Sep 2011 08:08:16 +0200 (CEST)
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
The code as is isn't functional and will need low-level hardware-specific
drivers and a tighter integration with ALSA and ASoC. The main ideas will be
presented during the Linux Plumbers Conference on September 9. Feedback through
the mailing list would be greatly appreciated as well.
Future versions will include support for capture, mmap, integration with alsa,
asoc, dsp etc
Support for effects is beyond the scope of this interface.

Vinod Koul (5):
  compress API documentation
  compress: add compress parameter definations
  compress: add API header and driver header files
  compress: add the core file
  compress: add makefile and kconfig file

 .../sound/alsa/compress/snd_compress_data.txt      |  186 ++++++
 include/sound/compress_driver.h                    |  138 +++++
 include/sound/compress_offload.h                   |  137 +++++
 include/sound/snd_compress_params.h                |  396 ++++++++++++
 sound/Kconfig                                      |    2 +
 sound/Makefile                                     |    3 +-
 sound/compress_offload/Kconfig                     |   12 +
 sound/compress_offload/Makefile                    |    3 +
 sound/compress_offload/core.c                      |  632 ++++++++++++++++++++
 9 files changed, 1508 insertions(+), 1 deletions(-)
 create mode 100644 Documentation/sound/alsa/compress/snd_compress_data.txt
 create mode 100644 include/sound/compress_driver.h
 create mode 100644 include/sound/compress_offload.h
 create mode 100644 include/sound/snd_compress_params.h
 create mode 100644 sound/compress_offload/Kconfig
 create mode 100644 sound/compress_offload/Makefile
 create mode 100644 sound/compress_offload/core.c
