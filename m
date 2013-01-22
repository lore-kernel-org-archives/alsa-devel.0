From: kbuild test robot <fengguang.wu@intel.com>
Subject: [asoc:topic/ioremap 1/1]
 sound/soc/codecs/jz4740.c:364:2: error: implicit declaration of function
 'devm_ioremap_resource'
Date: Tue, 22 Jan 2013 17:27:44 +0800
Message-ID: <50fe5b90.O49HZShgZv4WYr22%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id C5BEE2650B7
 for <alsa-devel@alsa-project.org>; Tue, 22 Jan 2013 10:31:24 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Thierry Reding <thierry.reding@avionic-design.de>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git topic/ioremap
head:   bc96ea9b07adce5ec678899ea2604bd38677938e
commit: bc96ea9b07adce5ec678899ea2604bd38677938e [1/1] ASoC: Convert to devm_ioremap_resource()
config: make ARCH=i386 allyesconfig

All error/warnings:

   sound/soc/codecs/jz4740.c: In function 'jz4740_codec_probe':
>> sound/soc/codecs/jz4740.c:364:2: error: implicit declaration of function 'devm_ioremap_resource' [-Werror=implicit-function-declaration]
   sound/soc/codecs/jz4740.c:364:7: warning: assignment makes pointer from integer without a cast [enabled by default]
   cc1: some warnings being treated as errors

vim +/devm_ioremap_resource +364 sound/soc/codecs/jz4740.c

   358		jz4740_codec = devm_kzalloc(&pdev->dev, sizeof(*jz4740_codec),
   359					    GFP_KERNEL);
   360		if (!jz4740_codec)
   361			return -ENOMEM;
   362	
   363		mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 > 364		base = devm_ioremap_resource(&pdev->dev, mem);
   365		if (IS_ERR(base))
   366			return PTR_ERR(base);
   367	

---
0-DAY kernel build testing backend              Open Source Technology Center
http://lists.01.org/mailman/listinfo/kbuild                 Intel Corporation
