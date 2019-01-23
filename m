From: Yong Zhi <yong.zhi@intel.com>
Subject: [PATCH v3 0/3] ASoC: Intel: Update broxton machine
	driver
Date: Wed, 23 Jan 2019 10:38:34 -0800
Message-ID: <1548268717-32596-1-git-send-email-yong.zhi@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 by alsa0.perex.cz (Postfix) with ESMTP id D1BEF267561
 for <alsa-devel@alsa-project.org>; Wed, 23 Jan 2019 19:44:39 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org, alsa-devel@alsa-project.org
Cc: harshapriya.n@intel.com, naveen.m@intel.com, vkoul@kernel.org, pierre-louis.bossart@linux.intel.com, Yong Zhi <yong.zhi@intel.com>
List-Id: alsa-devel@alsa-project.org

Hello,

This patchset is an update to the following v2 posted by Naveen last year:

https://patchwork.kernel.org/patch/10335295/
https://patchwork.kernel.org/patch/10335293/
https://patchwork.kernel.org/patch/10335297/

1/5 and 5/5 of original series were merged. The changes have been tested for
both bxt_da7219_max98357a and glk_da7219_max98357a.

Yong Zhi (3):
  ASoC: Intel: Headset button support in broxton machine driver
  ASoC: Intel: Add Geminilake Dialog Maxim machine driver
  ASoC: Intel: glk: Add DAI links for Multi-Playback

 sound/soc/intel/boards/bxt_da7219_max98357a.c | 101 +++++++++++++++++++++++---
 1 file changed, 89 insertions(+), 12 deletions(-)

-- 
2.7.4
