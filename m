From: Naveen Manohar <naveen.m@intel.com>
Subject: [PATCH 0/5] ASoC: Intel: geminilake: Adds
	da7219+max98537 machine driver support
Date: Wed,  4 Apr 2018 10:16:54 +0530
Message-ID: <1522817219-3750-1-git-send-email-naveen.m@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by alsa0.perex.cz (Postfix) with ESMTP id 28F2C26760A
 for <alsa-devel@alsa-project.org>; Wed,  4 Apr 2018 06:47:41 +0200 (CEST)
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
Cc: vinod.koul@intel.com, harshapriya.n@intel.com, naveen.m@intel.com, broonie@kernel.org, pierre-louis.bossart@intel.com
List-Id: alsa-devel@alsa-project.org

Patch adds required changes in bxt machine & corresponding driver
entry in machine to use MAX98357A codec as speaker on SSP1 and
DA7219 codec as headset on SSP2 for GLK board.

Naveen Manohar (5):
  ASoC: Intel: broxton: reduce machine name for bxt_da7219_max98357a
  ASoC: Intel: Headset button support in broxton machine driver
  ASoC: Intel: Add Geminilake Dialog Maxim machine driver support
  ASoC: Intel: glk: Add DAI links for Multi-Playback
  ASoC: Intel: Add Geminilake Dialog+Maxim machine driver entry

 sound/soc/intel/boards/bxt_da7219_max98357a.c | 308 ++++++++++++++++++++++++--
 sound/soc/intel/skylake/skl.c                 |   9 +-
 2 files changed, 297 insertions(+), 20 deletions(-)

-- 
2.7.4
