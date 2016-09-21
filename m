From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Subject: Re: [PATCH 4/5] ASoC: fsl_ssi: use flat regmap cache
Date: Wed, 21 Sep 2016 18:28:44 +0200
Message-ID: <57E2B53C.6080708@maciej.szmigiero.name>
References: <20160919193029.8119-1-marex@denx.de>
 <20160919193029.8119-4-marex@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from vps-vb.mhejs.net (vps-vb.mhejs.net [37.28.154.113])
 by alsa0.perex.cz (Postfix) with ESMTP id 53671266FBB
 for <alsa-devel@alsa-project.org>; Wed, 21 Sep 2016 18:28:48 +0200 (CEST)
In-Reply-To: <20160919193029.8119-4-marex@denx.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: marex@denx.de
Cc: alsa-devel@alsa-project.org, Xiubo Li <Xiubo.Lee@gmail.com>, Timur Tabi <timur@tabi.org>, Liam Girdwood <lgirdwood@gmail.com>, Nicolin Chen <nicoleotsuka@gmail.com>, Mark Brown <broonie@kernel.org>, Fabio Estevam <fabio.estevam@nxp.com>
List-Id: alsa-devel@alsa-project.org

Hi Marek,

On 19.09.2016 21:30, Marek Vasut wrote:
> Same as commit ce492b3b8f99cf9d2f807ec22d8805c996a09503
> Subject: drm/fsl-dcu: use flat regmap cache
> 
> Using flat regmap cache instead of RB-tree to avoid the following
> lockdep warning on driver load:
> WARNING: CPU: 0 PID: 1 at kernel/locking/lockdep.c:2871 lockdep_trace_alloc+0x104/0x128
> DEBUG_LOCKS_WARN_ON(irqs_disabled_flags(flags))
> 
> The RB-tree regmap cache needs to allocate new space on first
> writes.

That's why SSI driver had .num_reg_defaults_raw set in regmap config.
With this set and .reg_defaults_raw unset regcache_hw_init() will read
existing register content which then will be used to populate cache
(and so allocate RB tree nodes) at regcache initialization time.

This means that allocation of new cache RB tree nodes should never happen
during actual write.
If you get a warning that it happened then maybe there is a write to
some register not covered by .num_reg_defaults_raw - this should be
fixed.

The problem with flat cache is that it is zero-initialized, that is,
all registers are assumed to contain zeros by default.
This is generally not true in case of SSI so reads from and bit updates
in non-volatile registers will corrupt their value.

You can also refer to discussion when .num_reg_defaults_raw was first
added here:
http://www.gossamer-threads.com/lists/linux/kernel/2330573

Maciej
