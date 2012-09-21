From: Fengguang Wu <fengguang.wu@intel.com>
Subject: sound/pci/hda/patch_ca0132.c: potential null
	dereference 'dma_engine'
Date: Fri, 21 Sep 2012 18:22:42 +0800
Message-ID: <20120921102242.GA11865@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 33A0F260727
 for <alsa-devel@alsa-project.org>; Fri, 21 Sep 2012 12:22:49 +0200 (CEST)
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
To: Ian Minett <ian_minett@creativelabs.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, kernel-janitors@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Hi Ian,

FYI, there are new smatch warnings show up in

commit 0b37d4c7982442730061a737c16939e8cc363861
Author:     Ian Minett <ian_minett@creativelabs.com>
Commit:     Takashi Iwai <tiwai@suse.de>
CommitDate: Fri Sep 21 09:54:29 2012 +0200

+ sound/pci/hda/patch_ca0132.c:2056 dspxfr_image() error: potential null dereference 'dma_engine'.  (kzalloc returns null)
+ sound/pci/hda/patch_ca0132.c:2056 dspxfr_image() error: we previously assumed 'dma_engine' could be null (see line 1963)

---
0-DAY kernel build testing backend         Open Source Technology Centre
Fengguang Wu, Yuanhan Liu                              Intel Corporation
