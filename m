From: kbuild test robot <lkp@intel.com>
Subject: Re: [PATCH 1/2 v2][resend] ASoC: rsnd: Request/Release
 DMA channel each time
Date: Mon, 14 Nov 2016 11:40:01 +0800
Message-ID: <201611141126.6FOXkqB2%fengguang.wu@intel.com>
References: <871syelupe.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 401E0266851
 for <alsa-devel@alsa-project.org>; Mon, 14 Nov 2016 04:41:05 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <871syelupe.wl-kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>, kbuild-all@01.org, Simon <horms@verge.net.au>, Laurent <laurent.pinchart@ideasonboard.com>
List-Id: alsa-devel@alsa-project.org

Hi Kuninori,

[auto build test WARNING on asoc/for-next]
[also build test WARNING on next-20161111]
[cannot apply to v4.9-rc5]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Kuninori-Morimoto/ASoC-rsnd-DMA-power-fix-and-IOMMU-support/20161114-101334
base:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next


coccinelle warnings: (new ones prefixed by >>)

>> sound/soc/sh/rcar/dma.c:169:9-16: ERROR: PTR_ERR applied after initialization to constant on line 167

vim +169 sound/soc/sh/rcar/dma.c

   161		 * Let's call it under nolock_start
   162		 */
   163		dmaen->chan = rsnd_dmaen_request_channel(io,
   164							 dma->mod_from,
   165							 dma->mod_to);
   166		if (IS_ERR_OR_NULL(dmaen->chan)) {
 > 167			dmaen->chan = NULL;
   168			dev_err(dev, "can't get dma channel\n");
 > 169			return PTR_ERR(dmaen->chan);
   170		}
   171	
   172		return 0;

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
