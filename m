Return-Path: <alsa-devel-bounces@alsa-project.org>
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by alsa0.perex.cz (Postfix) with ESMTP id E7D94266E30
 for <alsa-devel@alsa-project.org>; Wed, 11 Apr 2018 12:25:53 +0200 (CEST)
From: Naveen Manohar <naveen.m@intel.com>
Date: Wed, 11 Apr 2018 15:54:58 +0530
Message-Id: <1523442303-12710-1-git-send-email-naveen.m@intel.com>
Subject: [alsa-devel] [PATCH v2 0/5] ASoC: Intel: geminilake: Adds
	da7219+max98537 machine driver support
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: vinod.koul@intel.com, harshapriya.n@intel.com, naveen.m@intel.com, broonie@kernel.org, pierre-louis.bossart@intel.com
List-ID: <alsa-devel@alsa-project.org>

Patch adds required changes in bxt machine & corresponding driver
entry in machine to use MAX98357A codec as speaker on SSP1 and
DA7219 codec as headset on SSP2 for GLK board. 

Naveen Manohar (5):
  ASoC: Intel: broxton: reduce machine name for bxt_da7219_max98357a
  ASoC: Intel: Headset button support in broxton machine driver
  ASoC: Intel: Add Geminilake Dialog Maxim machine driver support
  ASoC: Intel: glk: Add DAI links for Multi-Playback
  ASoC: Intel: Add Geminilake Dialog+Maxim machine driver entry

 sound/soc/intel/boards/bxt_da7219_max98357a.c | 152 ++++++++++++++++++++++----
 sound/soc/intel/skylake/skl.c                 |   9 +-
 2 files changed, 141 insertions(+), 20 deletions(-)

-- 
v1->v2: Unified dai-link usage between bxt & glk mach, corrected jack CTRL
2.7.4

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
