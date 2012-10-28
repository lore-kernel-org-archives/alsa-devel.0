From: Fengguang Wu <fengguang.wu@intel.com>
Subject: [asoc:topic/adsp] make[4]: *** No rule to make target
 `sound/soc/codecs/snd-soc-wm-adsp.c',
 needed by `sound/soc/codecs/snd-soc-wm-adsp.o'.
Date: Sun, 28 Oct 2012 09:13:55 +0800
Message-ID: <20121028011355.GA7603@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 125C8265243
 for <alsa-devel@alsa-project.org>; Sun, 28 Oct 2012 02:24:03 +0100 (CET)
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
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi Mark,

FYI, kernel build failed on

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git topic/adsp
config: x86_64-allmodconfig # make ARCH=x86_64 allmodconfig

All error/warnings:

make[4]: *** [sound/soc/codecs/wm2200.o] Error 1
make[4]: *** No rule to make target `sound/soc/codecs/snd-soc-wm-adsp.c', needed by `sound/soc/codecs/snd-soc-wm-adsp.o'.
make[4]: Target `__build' not remade because of errors.

---
0-DAY kernel build testing backend         Open Source Technology Center
Fengguang Wu, Yuanhan Liu                              Intel Corporation
