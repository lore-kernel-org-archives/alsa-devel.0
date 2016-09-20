From: kbuild test robot <fengguang.wu@intel.com>
Subject: [sound:for-next 48/48]
 sound/usb/line6/driver.c:484:2-7: WARNING: NULL check before freeing
 functions like kfree, debugfs_remove,
 debugfs_remove_recursive or usb_free_urb is not needed. Maybe consider
 reorganizing relevant code to avoid passing NULL values.
Date: Tue, 20 Sep 2016 08:10:13 +0800
Message-ID: <201609200807.amTCnbAm%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by alsa0.perex.cz (Postfix) with ESMTP id 9889B266675
 for <alsa-devel@alsa-project.org>; Tue, 20 Sep 2016 02:10:48 +0200 (CEST)
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
To: Andrej Krutak <dev@andree.sk>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, kbuild-all@01.org
List-Id: alsa-devel@alsa-project.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git for-next
head:   a16039cbf1a1ee7e76d7d100f9e613998919ab91
commit: a16039cbf1a1ee7e76d7d100f9e613998919ab91 [48/48] ALSA: line6: Add hwdep interface to access the POD control messages


coccinelle warnings: (new ones prefixed by >>)

>> sound/usb/line6/driver.c:484:2-7: WARNING: NULL check before freeing functions like kfree, debugfs_remove, debugfs_remove_recursive or usb_free_urb is not needed. Maybe consider reorganizing relevant code to avoid passing NULL values.

Please review and possibly fold the followup patch.

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
