From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Subject: [PATCH v3 00/13] alsa-lib topology support
Date: Wed, 29 Jul 2015 17:45:12 +0100
Message-ID: <1438188325-11553-1-git-send-email-liam.r.girdwood@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id A64AD2605CD
 for <alsa-devel@alsa-project.org>; Wed, 29 Jul 2015 18:45:43 +0200 (CEST)
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
Cc: Takashi Iwai <tiwai@suse.de>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

This series adds support for parsing topology data text files and converting
to the binary topology format accepted by the kernel. 

Changes since V2 :-

  o Added documentation in doxygen format describing API and text file format.
  o use SNDERR macro for error reporting.
  o Added text copy helper.
  o Make all parsed keywords lowercase
  o Assignment for some structure copies instead of memcpy().
  o Fixed the private data parser to handle byte, short and word data.

Changes since V1 :-
 
  o Terminate all strncpy() strings with NULL.
  o Use snd_pcm_format_value() instead of local lookup.
  o Set a maximum size for private data files.
  o Set capture/playback stream direction for new PCMs
  o Only set TLV access flags for TLV CTLs.


Liam Girdwood (13):
  topology: uapi: Add UAPI headers for topology ABI
  topology: Add topology core parser.
  topology: Add text section parser.
  topology: Add PCM parser.
  topology: Add operations parser
  topology: Add private data parser
  topology: Add DAPM object parser
  topology: Add CTL parser
  topology: Add Channel map parser.
  topology: Add binary file builder.
  topology: autotools: Add build support for topology core
  topology: doxygen: Add doxygen support for topology core.
  conf: topology: Add topology file for broadwell audio DSP

 configure.ac                               |  11 +-
 doc/doxygen.cfg.in                         |   7 +-
 doc/index.doxygen                          |   1 +
 include/Makefile.am                        |   4 +
 include/sound/Makefile.am                  |   3 +-
 include/sound/asoc.h                       | 388 ++++++++++++++++++
 include/sound/tlv.h                        |  23 ++
 include/topology.h                         | 497 ++++++++++++++++++++++
 src/Makefile.am                            |   7 +
 src/conf/Makefile.am                       |   2 +-
 src/conf/topology/Makefile.am              |   1 +
 src/conf/topology/broadwell/Makefile.am    |   4 +
 src/conf/topology/broadwell/broadwell.conf | 375 +++++++++++++++++
 src/topology/Makefile.am                   |  19 +
 src/topology/builder.c                     | 327 +++++++++++++++
 src/topology/channel.c                     | 122 ++++++
 src/topology/ctl.c                         | 613 +++++++++++++++++++++++++++
 src/topology/dapm.c                        | 562 +++++++++++++++++++++++++
 src/topology/data.c                        | 396 ++++++++++++++++++
 src/topology/elem.c                        | 187 +++++++++
 src/topology/ops.c                         |  84 ++++
 src/topology/parser.c                      | 359 ++++++++++++++++
 src/topology/pcm.c                         | 639 +++++++++++++++++++++++++++++
 src/topology/text.c                        |  88 ++++
 src/topology/tplg_local.h                  | 234 +++++++++++
 25 files changed, 4948 insertions(+), 5 deletions(-)
 create mode 100644 include/sound/asoc.h
 create mode 100644 include/sound/tlv.h
 create mode 100644 include/topology.h
 create mode 100644 src/conf/topology/Makefile.am
 create mode 100644 src/conf/topology/broadwell/Makefile.am
 create mode 100644 src/conf/topology/broadwell/broadwell.conf
 create mode 100644 src/topology/Makefile.am
 create mode 100644 src/topology/builder.c
 create mode 100644 src/topology/channel.c
 create mode 100644 src/topology/ctl.c
 create mode 100644 src/topology/dapm.c
 create mode 100644 src/topology/data.c
 create mode 100644 src/topology/elem.c
 create mode 100644 src/topology/ops.c
 create mode 100644 src/topology/parser.c
 create mode 100644 src/topology/pcm.c
 create mode 100644 src/topology/text.c
 create mode 100644 src/topology/tplg_local.h

-- 
2.1.4
