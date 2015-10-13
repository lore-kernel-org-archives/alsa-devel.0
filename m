From: Jie Yang <yang.jie@intel.com>
Subject: [PATCH v3 0/2] make it possible to not compile
	compress APIs
Date: Tue, 13 Oct 2015 17:11:02 +0800
Message-ID: <1444727464-10385-1-git-send-email-yang.jie@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 94A4F260711
 for <alsa-devel@alsa-project.org>; Tue, 13 Oct 2015 11:05:23 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org
Cc: alsa-devel@alsa-project.org, liam.r.girdwood@intel.com
List-Id: alsa-devel@alsa-project.org

Compress APIs are not always needed, but they are always built currentlly,
in both ALSA core and ASoC core. 

This series make it possible to not compile it when unneeded.

Hi, Takashi & all,

I am not sure you will like the patch 2/2, it split soc-compress to a
module, but introduced several extra 'EXPORT_SYMBOL_GPL' there. If don't
like it, you can just apply the first one(1/2) and skip 2/2.

thanks,
~Keyon

Changes in this version:
1. change to use a callback for compress_new, and remove compress_dai
bool.
2. remove the empty module_init/exit for soc-compress module.

Jie Yang (2):
  ASoC: soc-compress: add a config item for soc-compress
  ASoC: soc-compress: split soc-compress to a module

 include/sound/soc-dai.h                      |  2 +-
 include/sound/soc.h                          |  2 ++
 sound/soc/Kconfig                            |  6 +++++-
 sound/soc/Makefile                           |  5 ++++-
 sound/soc/intel/Kconfig                      |  1 +
 sound/soc/intel/atom/sst-mfld-platform-pcm.c |  2 +-
 sound/soc/soc-compress.c                     | 10 ++++++++++
 sound/soc/soc-core.c                         |  4 ++--
 sound/soc/soc-dapm.c                         |  1 +
 sound/soc/soc-pcm.c                          | 13 +++++++++++++
 10 files changed, 40 insertions(+), 6 deletions(-)

-- 
1.9.1
