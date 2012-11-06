From: Fengguang Wu <fengguang.wu@intel.com>
Subject: [asoc:topic/atmel 7/7] ERROR: Input tree has errors,
 aborting (use -f to force output)
Date: Tue, 6 Nov 2012 18:58:56 +0800
Message-ID: <20121106105856.GA17982@localhost>
References: <5098e341.O6MhFjJV2ViFIEza%yuanhan.liu@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id D8062261720
 for <alsa-devel@alsa-project.org>; Tue,  6 Nov 2012 11:59:02 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <5098e341.O6MhFjJV2ViFIEza%yuanhan.liu@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Bo Shen <voice.shen@atmel.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Hi Bo,

FYI, kernel build failed on

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git topic/atmel
head:   e9898f35f539f3a1aecf054d01cc1631aaa67be4
commit: e9898f35f539f3a1aecf054d01cc1631aaa67be4 [7/7] ARM: at91: atmel-ssc: add device tree support
config: make ARCH=arm at91_dt_defconfig

All error/warnings:

ERROR (duplicate_label): Duplicate label 'ssc0' on /ahb/apb/ssc@fffa0000 and /ahb/apb/ssc@fff9c000
ERROR: Input tree has errors, aborting (use -f to force output)

---
0-DAY kernel build testing backend         Open Source Technology Center
Fengguang Wu, Yuanhan Liu                              Intel Corporation
