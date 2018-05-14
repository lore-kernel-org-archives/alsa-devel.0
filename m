From: kbuild test robot <lkp@intel.com>
Subject: [sound:for-next 62/68]
 sound/pci/hda/patch_ca0132.c:5062:50-51: WARNING: Use ARRAY_SIZE
Date: Tue, 15 May 2018 03:02:14 +0800
Message-ID: <201805150307.Eek1tvZf%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by alsa0.perex.cz (Postfix) with ESMTP id 3164B266F46
 for <alsa-devel@alsa-project.org>; Mon, 14 May 2018 21:03:18 +0200 (CEST)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Connor McAdams <conmanx360@gmail.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, kbuild-all@01.org, Takashi Sakamoto <o-takashi@sakamocchi.jp>
List-Id: alsa-devel@alsa-project.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git for-next
head:   4844f51282b60f8a96b05d422f452a785df308b9
commit: 47cdf76e44e87d25b91c0f0d0539944c932941ba [62/68] ALSA: hda/ca0132: Add new control changes for SBZ + R3Di


coccinelle warnings: (new ones prefixed by >>)

>> sound/pci/hda/patch_ca0132.c:5062:50-51: WARNING: Use ARRAY_SIZE
   sound/pci/hda/patch_ca0132.c:5092:50-51: WARNING: Use ARRAY_SIZE

Please review and possibly fold the followup patch.

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
