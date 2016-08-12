From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 0/4] ASoC: Intel: Skylake: Add token support
	for topology data
Date: Fri, 12 Aug 2016 12:29:49 +0530
Message-ID: <1470985193-10680-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id ED0B4266C29
 for <alsa-devel@alsa-project.org>; Fri, 12 Aug 2016 08:52:15 +0200 (CEST)
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
Cc: liam.r.girdwood@linux.intel.com, patches.audio@intel.com, broonie@kernel.org, Vinod Koul <vinod.koul@intel.com>
List-Id: alsa-devel@alsa-project.org

With topology changes in alsa-lib, driver data for modules can now be
passed in topology conf file using tuples.

These changes allow private data to represented by tuples of type UUID,
byte, short, word and strings.

This patch series adds changes to:
 - Define vendor tokens to best describe module private data
 - Parse these token value to populate module private data
 - Remove the skl_dfw_config structure as it would no longer be required.
 - Define tokens for manifest private data and parse them to populate
   library names for library loading.

Shreyas NC (4):
  ASoC: uapi: Intel: Skylake: Define vendor specific tokens
  ASoC: Intel: Skylake: Parse vendor tokens to build module data
  ASoC: Intel: Skylake: Remove dfw config and associated structures
  ASoC: Intel: Skylake: Parse manifest data

 include/uapi/sound/Kbuild                    |   1 +
 include/uapi/sound/snd_sst_tokens.h          | 214 +++++++
 sound/soc/intel/skylake/skl-sst-utils.c      |   5 -
 sound/soc/intel/skylake/skl-topology.c       | 839 +++++++++++++++++++++++----
 sound/soc/intel/skylake/skl-tplg-interface.h |  83 +--
 5 files changed, 953 insertions(+), 189 deletions(-)
 create mode 100644 include/uapi/sound/snd_sst_tokens.h

-- 
1.9.1
