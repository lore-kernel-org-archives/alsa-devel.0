From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 2/2] ASoC: sta32x: Convert to regmap
Date: Mon, 10 Sep 2012 15:49:54 +0800
Message-ID: <20120910074952.GD6749@opensource.wolfsonmicro.com>
References: <1347246103-10010-1-git-send-email-broonie@opensource.wolfsonmicro.com>
 <1347246103-10010-2-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 19495264F41
 for <alsa-devel@alsa-project.org>; Mon, 10 Sep 2012 09:50:00 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1347246103-10010-2-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>, Johannes Stezenbach <js@sig21.net>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, Sep 10, 2012 at 11:01:43AM +0800, Mark Brown wrote:
> Long term all drivers should be using regmap directly. This is more
> idiomatic and moves us towards the removal of the ASoC level cache
> code.

This also needs

	.cache_type = REGCACHE_RBTREE

in the regmap config.  I've fixed up locally.
