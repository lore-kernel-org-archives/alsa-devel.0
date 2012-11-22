From: kbuild test robot <fengguang.wu@intel.com>
Subject: [sound:for-next 70/72]
 sound/pci/rme9652/hdsp.c:5103:4: error: implicit declaration of function
 'vmalloc'
Date: Fri, 23 Nov 2012 02:31:43 +0800
Message-ID: <50ae6f8f.YSly4KtV7qrTIU9O%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 551AF260840
 for <alsa-devel@alsa-project.org>; Thu, 22 Nov 2012 19:32:39 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git for-next
head:   4f86f120d9d65b3a8f17e48dca1f991d861b5cd7
commit: 90caaef6a1ce2ec6675b1dc5afd57767954ab7e8 [70/72] ALSA: hdsp: improve firmware caching
config: make ARCH=powerpc allmodconfig

All error/warnings:

sound/pci/rme9652/hdsp.c: In function 'snd_hdsp_hwdep_ioctl':
sound/pci/rme9652/hdsp.c:5103:4: error: implicit declaration of function 'vmalloc' [-Werror=implicit-function-declaration]
sound/pci/rme9652/hdsp.c:5103:22: warning: assignment makes pointer from integer without a cast [enabled by default]
sound/pci/rme9652/hdsp.c:5110:4: error: implicit declaration of function 'vfree' [-Werror=implicit-function-declaration]
cc1: some warnings being treated as errors

vim +5103 +/vmalloc sound/pci/rme9652/hdsp.c

^1da177e Linus Torvalds 2005-04-16  5097  			return -EFAULT;
f9ffc5d6 Tim Blechmann  2009-02-20  5098  
b0b98119 Takashi Iwai   2005-10-20  5099  		if (hdsp_check_for_iobox (hdsp))
^1da177e Linus Torvalds 2005-04-16  5100  			return -EIO;
^1da177e Linus Torvalds 2005-04-16  5101  
90caaef6 Takashi Iwai   2012-11-22  5102  		if (!hdsp->fw_uploaded) {
90caaef6 Takashi Iwai   2012-11-22 @5103  			hdsp->fw_uploaded = vmalloc(HDSP_FIRMWARE_SIZE);
90caaef6 Takashi Iwai   2012-11-22  5104  			if (!hdsp->fw_uploaded)
90caaef6 Takashi Iwai   2012-11-22  5105  				return -ENOMEM;
90caaef6 Takashi Iwai   2012-11-22  5106  		}
90caaef6 Takashi Iwai   2012-11-22  5107  
90caaef6 Takashi Iwai   2012-11-22  5108  		if (copy_from_user(hdsp->fw_uploaded, firmware_data,
90caaef6 Takashi Iwai   2012-11-22  5109  				   HDSP_FIRMWARE_SIZE)) {
90caaef6 Takashi Iwai   2012-11-22 @5110  			vfree(hdsp->fw_uploaded);
90caaef6 Takashi Iwai   2012-11-22  5111  			hdsp->fw_uploaded = NULL;
^1da177e Linus Torvalds 2005-04-16  5112  			return -EFAULT;
90caaef6 Takashi Iwai   2012-11-22  5113  		}

---
0-DAY kernel build testing backend         Open Source Technology Center
Fengguang Wu, Yuanhan Liu                              Intel Corporation
