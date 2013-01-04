From: kbuild test robot <fengguang.wu@intel.com>
Subject: [sound:for-linus 4/4] sound/oss/pas2_card.c:338:5:
 warning: too many arguments for format
Date: Fri, 04 Jan 2013 17:32:01 +0800
Message-ID: <50e6a191.sDZeREDTt2gcR/8X%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [143.182.124.21])
 by alsa0.perex.cz (Postfix) with ESMTP id 0500F2616BC
 for <alsa-devel@alsa-project.org>; Fri,  4 Jan 2013 10:33:22 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Asim Kadav <kadav@cs.wisc.edu>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git for-linus
head:   b56458b36c8922d1d57c2320151194059dfb9a31
commit: b56458b36c8922d1d57c2320151194059dfb9a31 [4/4] sound: oss/pas2: Fix possible access out of array
config: make ARCH=x86_64 allyesconfig

All warnings:

sound/oss/pas2_card.c: In function 'attach_pas_card':
sound/oss/pas2_card.c:338:5: warning: too many arguments for format [-Wformat-extra-args]

vim +338 sound/oss/pas2_card.c

^1da177e Linus Torvalds 2005-04-16  322  	return pas_model;
^1da177e Linus Torvalds 2005-04-16  323  }
^1da177e Linus Torvalds 2005-04-16  324  
^1da177e Linus Torvalds 2005-04-16  325  static void __init attach_pas_card(struct address_info *hw_config)
^1da177e Linus Torvalds 2005-04-16  326  {
^1da177e Linus Torvalds 2005-04-16  327  	pas_irq = hw_config->irq;
^1da177e Linus Torvalds 2005-04-16  328  
^1da177e Linus Torvalds 2005-04-16  329  	if (detect_pas_hw(hw_config))
^1da177e Linus Torvalds 2005-04-16  330  	{
^1da177e Linus Torvalds 2005-04-16  331  
^1da177e Linus Torvalds 2005-04-16  332  		if ((pas_model = pas_read(0xFF88)))
^1da177e Linus Torvalds 2005-04-16  333  		{
^1da177e Linus Torvalds 2005-04-16  334  			char            temp[100];
^1da177e Linus Torvalds 2005-04-16  335  
b56458b3 Asim Kadav     2013-01-03  336  			if (pas_model < 0 ||
b56458b3 Asim Kadav     2013-01-03  337  			    pas_model >= ARRAY_SIZE(pas_model_names)) {
b56458b3 Asim Kadav     2013-01-03 @338  				printk(KERN_ERR, "pas2 unrecognized model.\n");
b56458b3 Asim Kadav     2013-01-03  339  				return;
b56458b3 Asim Kadav     2013-01-03  340  			}
^1da177e Linus Torvalds 2005-04-16  341  			sprintf(temp,
^1da177e Linus Torvalds 2005-04-16  342  			    "%s rev %d", pas_model_names[(int) pas_model],
^1da177e Linus Torvalds 2005-04-16  343  				    pas_read(0x2789));
^1da177e Linus Torvalds 2005-04-16  344  			conf_printf(temp, hw_config);
^1da177e Linus Torvalds 2005-04-16  345  		}
^1da177e Linus Torvalds 2005-04-16  346  		if (config_pas_hw(hw_config))

---
0-DAY kernel build testing backend         Open Source Technology Center
Fengguang Wu, Yuanhan Liu                              Intel Corporation
