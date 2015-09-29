From: kbuild test robot <fengguang.wu@intel.com>
Subject: [sound:topic/firewire-update 15/15]
 sound/firewire/amdtp-am824.c:402:14: sparse: symbol
 'process_rx_data_blocks' was not declared. Should it be static?
Date: Tue, 29 Sep 2015 22:46:10 +0800
Message-ID: <201509292248.kwkRZFqi%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 647B4265705
 for <alsa-devel@alsa-project.org>; Tue, 29 Sep 2015 16:47:10 +0200 (CEST)
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
To: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, kbuild-all@01.org
List-Id: alsa-devel@alsa-project.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git topic/firewire-update
head:   df075feefbd347f13fba5198294cda619532c237
commit: df075feefbd347f13fba5198294cda619532c237 [15/15] ALSA: firewire-lib: complete AM824 data block processing layer
reproduce:
  # apt-get install sparse
  git checkout df075feefbd347f13fba5198294cda619532c237
  make ARCH=x86_64 allmodconfig
  make C=1 CF=-D__CHECK_ENDIAN__


sparse warnings: (new ones prefixed by >>)

>> sound/firewire/amdtp-am824.c:402:14: sparse: symbol 'process_rx_data_blocks' was not declared. Should it be static?
>> sound/firewire/amdtp-am824.c:423:14: sparse: symbol 'process_tx_data_blocks' was not declared. Should it be static?

Please review and possibly fold the followup patch.

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
