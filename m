From: "S.j. Wang" <shengjiu.wang@nxp.com>
Subject: Re: [RFC/RFT PATCH v2] ASoC: fsl_esai: Revert "ETDR
 and TX0~5 registers are non volatile"
Date: Thu, 13 Jun 2019 03:00:58 +0000
Message-ID: <VE1PR04MB6479D4B1D5F00B07C5CECC5BE3EF0@VE1PR04MB6479.eurprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
 (mail-eopbgr80051.outbound.protection.outlook.com [40.107.8.51])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 0F699F80794
 for <alsa-devel@alsa-project.org>; Thu, 13 Jun 2019 05:01:00 +0200 (CEST)
Content-Language: en-US
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Nicolin Chen <nicoleotsuka@gmail.com>, "broonie@kernel.org" <broonie@kernel.org>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "timur@kernel.org" <timur@kernel.org>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "Xiubo.Lee@gmail.com" <Xiubo.Lee@gmail.com>, "tiwai@suse.com" <tiwai@suse.com>, "festevam@gmail.com" <festevam@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

Hi
> 
> Commit 8973112aa41b ("ASoC: fsl_esai: ETDR and TX0~5 registers are non
> volatile") removed TX data registers from the volatile_reg list and appended
> default values for them. However, being data registers of TX, they should
> not have been removed from the list because they should not be cached --
> see the following reason.
> 
> When doing regcache_sync(), this operation might accidentally write some
> dirty data to these registers, in case that cached data happen to be
> different from the default ones, which might also result in a channel shift or
> swap situation, since the number of write-via-sync operations at ETDR
> would very unlikely match the channel number.
> 
> So this patch reverts the original commit to keep TX data registers in
> volatile_reg list in order to prevent them from being written by
> regcache_sync().
> 
> Note: this revert is not a complete revert as it keeps those macros of
> registers remaining in the default value list while the original commit also
> changed other entries in the list. And this patch isn't very necessary to Cc
> stable tree since there has been always a FIFO reset operation around the
> regcache_sync() call, even prior to this reverted commit.
> 
> Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
> Cc: Shengjiu Wang <shengjiu.wang@nxp.com>
> ---
> Hi Mark,
> In case there's no objection against the patch, I'd still like to wait for a
> Tested-by from NXP folks before submitting it. Thanks!

bool regmap_volatile(struct regmap *map, unsigned int reg)
{
        if (!map->format.format_write && !regmap_readable(map, reg))
                return false;


Actually with this patch, the regcache_sync will write the 0 to ETDR, even
It is declared volatile, the reason is that in regmap_volatile(), the first
condition

(!map->format.format_write && !regmap_readable(map, reg))  is true.

So the regmap_volatile will return false.

And in regcache_reg_needs_sync(), because there is no default value
It will return true, then the ETDR need be synced, and be written 0.

Here is the code for regcache_default_sync()

static int regcache_default_sync(struct regmap *map, unsigned int min,
                                 unsigned int max)
{
        unsigned int reg;

        for (reg = min; reg <= max; reg += map->reg_stride) {
                unsigned int val;
                int ret;

                if (regmap_volatile(map, reg) ||
                    !regmap_writeable(map, reg))
                        continue;

                ret = regcache_read(map, reg, &val);
                if (ret)
                        return ret;

                if (!regcache_reg_needs_sync(map, reg, val))
                        continue;

                map->cache_bypass = true;
                ret = _regmap_write(map, reg, val);
                map->cache_bypass = false;

Best regards
Wang shengjiu
