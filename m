From: Fengguang Wu <fengguang.wu@intel.com>
Subject: [asoc:topic/adsp 33/33]
 sound/soc/codecs/wm2200.c:2555:10: sparse: unknown field name in
 initializer
Date: Sun, 28 Oct 2012 07:56:12 +0800
Message-ID: <20121027235612.GA3780@localhost>
References: <508c2732.ewftUhxw7qt5dqmE%yuanhan.liu@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [143.182.124.21])
 by alsa0.perex.cz (Postfix) with ESMTP id A728526529E
 for <alsa-devel@alsa-project.org>; Sun, 28 Oct 2012 01:56:16 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <508c2732.ewftUhxw7qt5dqmE%yuanhan.liu@linux.intel.com>
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

Errors in tree:

        git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git topic/adsp

sound/soc/codecs/wm2200.c:2555:10: sparse: unknown field name in initializer
sound/soc/codecs/wm2200.c:2555:2: error: unknown field 'num_ranges' specified in initializer

vim +2555 sound/soc/codecs/wm2200.c

d5315a23 Mark Brown 2012-01-25  2543  static const struct regmap_config wm2200_regmap = {
d5315a23 Mark Brown 2012-01-25  2544  	.reg_bits = 16,
d5315a23 Mark Brown 2012-01-25  2545  	.val_bits = 16,
d5315a23 Mark Brown 2012-01-25  2546  
eae2328d Mark Brown 2012-10-02  2547  	.max_register = WM2200_MAX_REGISTER + (ARRAY_SIZE(wm2200_ranges) *
eae2328d Mark Brown 2012-10-02  2548  					       WM2200_DSP_SPACING),
d5315a23 Mark Brown 2012-01-25  2549  	.reg_defaults = wm2200_reg_defaults,
d5315a23 Mark Brown 2012-01-25  2550  	.num_reg_defaults = ARRAY_SIZE(wm2200_reg_defaults),
d5315a23 Mark Brown 2012-01-25  2551  	.volatile_reg = wm2200_volatile_register,
d5315a23 Mark Brown 2012-01-25  2552  	.readable_reg = wm2200_readable_register,
d5315a23 Mark Brown 2012-01-25  2553  	.cache_type = REGCACHE_RBTREE,
eae2328d Mark Brown 2012-10-02  2554  	.ranges = wm2200_ranges,
eae2328d Mark Brown 2012-10-02 @2555  	.num_ranges = ARRAY_SIZE(wm2200_ranges),

It seems eae2328d introduced the .num_ranges reference while
struct regmap_config only defined:

        const struct regmap_range_cfg *ranges;
        unsigned int n_ranges;
};

Thanks,
Fengguang
