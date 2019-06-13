From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: Re: [RFC/RFT PATCH v2] ASoC: fsl_esai: Revert "ETDR
 and TX0~5 registers are non volatile"
Date: Wed, 12 Jun 2019 20:54:35 -0700
Message-ID: <20190613035434.GA7692@Asurada>
References: <VE1PR04MB6479D4B1D5F00B07C5CECC5BE3EF0@VE1PR04MB6479.eurprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com
 [IPv6:2607:f8b0:4864:20::442])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id AAE40F80794
 for <alsa-devel@alsa-project.org>; Thu, 13 Jun 2019 05:54:51 +0200 (CEST)
Received: by mail-pf1-x442.google.com with SMTP id j2so10918236pfe.6
 for <alsa-devel@alsa-project.org>; Wed, 12 Jun 2019 20:54:50 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <VE1PR04MB6479D4B1D5F00B07C5CECC5BE3EF0@VE1PR04MB6479.eurprd04.prod.outlook.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: "S.j. Wang" <shengjiu.wang@nxp.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "timur@kernel.org" <timur@kernel.org>, "Xiubo.Lee@gmail.com" <Xiubo.Lee@gmail.com>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "tiwai@suse.com" <tiwai@suse.com>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "broonie@kernel.org" <broonie@kernel.org>, "festevam@gmail.com" <festevam@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

Hi Shengjiu,

On Thu, Jun 13, 2019 at 03:00:58AM +0000, S.j. Wang wrote:
> > Commit 8973112aa41b ("ASoC: fsl_esai: ETDR and TX0~5 registers are non
> > volatile") removed TX data registers from the volatile_reg list and appended
> > default values for them. However, being data registers of TX, they should
> > not have been removed from the list because they should not be cached --
> > see the following reason.
> > 
> > When doing regcache_sync(), this operation might accidentally write some
> > dirty data to these registers, in case that cached data happen to be
> > different from the default ones, which might also result in a channel shift or
> > swap situation, since the number of write-via-sync operations at ETDR
> > would very unlikely match the channel number.
> > 
> > So this patch reverts the original commit to keep TX data registers in
> > volatile_reg list in order to prevent them from being written by
> > regcache_sync().
> > 
> > Note: this revert is not a complete revert as it keeps those macros of
> > registers remaining in the default value list while the original commit also
> > changed other entries in the list. And this patch isn't very necessary to Cc
> > stable tree since there has been always a FIFO reset operation around the
> > regcache_sync() call, even prior to this reverted commit.
> > 
> > Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
> > Cc: Shengjiu Wang <shengjiu.wang@nxp.com>
> > ---
> > Hi Mark,
> > In case there's no objection against the patch, I'd still like to wait for a
> > Tested-by from NXP folks before submitting it. Thanks!
> 
> bool regmap_volatile(struct regmap *map, unsigned int reg)
> {
>         if (!map->format.format_write && !regmap_readable(map, reg))
>                 return false;
> 
> 
> Actually with this patch, the regcache_sync will write the 0 to ETDR, even
> It is declared volatile, the reason is that in regmap_volatile(), the first
> condition
> 
> (!map->format.format_write && !regmap_readable(map, reg))  is true.
> 
> So the regmap_volatile will return false.

Interesting finding.....so a write-only register will not be treated
as a volatile register (to avoid regcache_sync) at all....

> And in regcache_reg_needs_sync(), because there is no default value
> It will return true, then the ETDR need be synced, and be written 0.

Looks like either way of keeping them in or out of volatile_reg list
might have the same result of having a data being written, while our
current code at least would not force to write 0.

So I think having a FIFO reset won't be a bad idea at all. And since
our suspend/resume() functions are already doing regcache_sync() with
a FIFO reset, we can just reuse that code for your reset routine.

Thanks a lot
Nicolin
