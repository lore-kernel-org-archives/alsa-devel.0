From: kbuild test robot <lkp@intel.com>
Subject: Re: [PATCH v3] ASoC: cs53l30: Add support for Cirrus
 Logic CS53L30
Date: Tue, 26 Jan 2016 10:14:18 +0800
Message-ID: <201601261031.Sr0GGepM%fengguang.wu@intel.com>
References: <1453763683-10009-1-git-send-email-tim.howe@cirrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id 1E061260575
 for <alsa-devel@alsa-project.org>; Tue, 26 Jan 2016 03:15:28 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1453763683-10009-1-git-send-email-tim.howe@cirrus.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
Cc: alsa-devel@alsa-project.org, lgirdwood@gmail.com, paul.handrigan@cirrus.com, broonie@kernel.org, kbuild-all@01.org, Tim Howe <tim.howe@cirrus.com>
List-Id: alsa-devel@alsa-project.org

Hi Tim,

[auto build test WARNING on v4.4-rc8]
[cannot apply to asoc/for-next v4.5-rc1 next-20160125]
[if your patch is applied to the wrong git tree, please drop us a note to help improving the system]

url:    https://github.com/0day-ci/linux/commits/tim-howe-cirrus-com/ASoC-cs53l30-Add-support-for-Cirrus-Logic-CS53L30/20160126-071847


coccinelle warnings: (new ones prefixed by >>)

>> sound/soc/codecs/cs53l30.c:921:6-11: No need to set .owner here. The core will do it.

Please review and possibly fold the followup patch.

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
