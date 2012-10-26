From: Fengguang Wu <fengguang.wu@intel.com>
Subject: [asoc:topic/wm2200 37/37] ERROR: "wm_adsp1_event"
	undefined!
Date: Sat, 27 Oct 2012 04:16:17 +0800
Message-ID: <508aef91.6ZQu9BjDxGPPHShi%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 83FC3265B78
 for <alsa-devel@alsa-project.org>; Fri, 26 Oct 2012 23:47:17 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi Mark,

FYI, kernel build failed on

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git topic/wm2200
head:   21ee496ffc650f79c85ae318321a9d961e240738
commit: 21ee496ffc650f79c85ae318321a9d961e240738 [37/37] ASoC: wm2200: Convert over to wm_adsp for ADSP1 support
config: x86_64-allmodconfig # make ARCH=x86_64 allmodconfig

All error/warnings:

ERROR: "wm_adsp1_event" undefined!

---
0-DAY kernel build testing backend         Open Source Technology Center
Fengguang Wu, Yuanhan Liu                              Intel Corporation
