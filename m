From: Brian Austin <brian.austin@cirrus.com>
Subject: Re: [PATCH RESEND v2 2/4] ASoC: cs42l52: increase
 MAX_REGISTER for regmap_register_patch
Date: Fri, 25 Oct 2013 12:49:50 -0500
Message-ID: <alpine.DEB.2.10.1310251244140.11514@heelrod.ad.cirrus.com>
References: <1382713277-10306-1-git-send-email-brian.austin@cirrus.com>
 <1382713277-10306-3-git-send-email-brian.austin@cirrus.com>
 <20131025153736.GA26122@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe004.messaging.microsoft.com [216.32.181.184])
 by alsa0.perex.cz (Postfix) with ESMTP id 720992616FF
 for <alsa-devel@alsa-project.org>; Fri, 25 Oct 2013 19:47:47 +0200 (CEST)
In-Reply-To: <20131025153736.GA26122@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: Brian Austin <brian.austin@cirrus.com>, alsa-devel@alsa-project.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


On Fri, 25 Oct 2013, Mark Brown wrote:

> On Fri, Oct 25, 2013 at 10:01:15AM -0500, Brian Austin wrote:
>> regmap_register_patch fails without the MAX_REGISTER set to highest
>> register written to. Increase to register 0x47
>
> Hrm.  It probably shouldn't be doing that, unless there's some great
> reason I've not thought of - this is for random undocumented registers
> which we ought to be able to exclude from the the register map that
> Linux knows about.  What's the root cause?
>
I thought this odd as well, but if I do not have a .max_register defined 
that is >= a register in the patch function, it will fail at that 
register. It does make sense that we should not have to define or mention 
chicken bits for this stuff.

Could it be related to this?

int regmap_register_patch(struct regmap *map, const struct reg_default 
*regs, int num_regs)
{
...

/* Write out first; it's useful to apply even if we fail later. */
 	for (i = 0; i < num_regs; i++) {
 		ret = _regmap_write(map, regs[i].reg, regs[i].def);
 		if (ret != 0) {
 			dev_err(map->dev, "Failed to write %x = %x: %d\n",
 				regs[i].reg, regs[i].def, ret);
 			goto out;
 		}
 	}

But it does not seem to apply later.
I believe that if I call regcache_cache_bypass it might work.
