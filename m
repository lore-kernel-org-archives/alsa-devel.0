From: Fengguang Wu <fengguang.wu@intel.com>
Subject: [sound-unstable:master 118/143]
 sound/pci/hda/patch_cirrus.c:1414:10: sparse: Initializer entry defined
 twice
Date: Thu, 13 Sep 2012 15:49:40 +0800
Message-ID: <20120913074940.GA25767@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 1C2AA26526E
 for <alsa-devel@alsa-project.org>; Thu, 13 Sep 2012 09:49:45 +0200 (CEST)
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
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, kernel-janitors@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Hi Takashi,

FYI, there are new sparse warnings show up in

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound-unstable.git master
head:   82cb521360dfd32f4f03ceaa74ef6b83ae983593
commit: ef596a57b4d7d8b258beb570ed309ef85bf24dd1 [118/143] ALSA: hda - Add support for MacBook Pro 10,1

All sparse warnings:

+ sound/pci/hda/patch_cirrus.c:1414:10: sparse: Initializer entry defined twice
  sound/pci/hda/patch_cirrus.c:1418:10:   also defined here

The root cause is, CS420X_MBP101 == CS420X_GPIO_23:

        @@ -85,6 +85,8 @@ enum {
=>              CS420X_GPIO_23,
                CS420X_IMAC27_122 = CS420X_GPIO_23,
                CS420X_APPLE = CS420X_GPIO_13,
=>      +       CS420X_MBP101,
        +       CS420X_MBP101_COEF,
                CS420X_AUTO,
         };
         
vim +1414 sound/pci/hda/patch_cirrus.c
  1404		[CS420X_IMAC27] = {
  1405			.type = HDA_FIXUP_PINS,
  1406			.v.pins = imac27_pincfgs,
  1407			.chained = true,
  1408			.chain_id = CS420X_GPIO_13,
  1409		},
  1410		[CS420X_GPIO_13] = {
  1411			.type = HDA_FIXUP_FUNC,
  1412			.v.func = cs420x_fixup_gpio_13,
  1413		},
> 1414		[CS420X_GPIO_23] = {
  1415			.type = HDA_FIXUP_FUNC,
  1416			.v.func = cs420x_fixup_gpio_23,
  1417		},
  1418		[CS420X_MBP101] = {
  1419			.type = HDA_FIXUP_PINS,
  1420			.v.pins = mbp101_pincfgs,
  1421			.chained = true,
  1422			.chain_id = CS420X_MBP101_COEF,
  1423		},
  1424		[CS420X_MBP101_COEF] = {

---
0-DAY kernel build testing backend         Open Source Technology Centre
Fengguang Wu <wfg@linux.intel.com>                     Intel Corporation
