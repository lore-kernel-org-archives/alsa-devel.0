From: Brian Austin <brian.austin@cirrus.com>
Subject: Re: [PATCH RESEND v2 2/4] ASoC: cs42l52: increase
 MAX_REGISTER for regmap_register_patch
Date: Fri, 25 Oct 2013 15:36:49 -0500
Message-ID: <alpine.DEB.2.10.1310251536240.11514@heelrod.ad.cirrus.com>
References: <1382713277-10306-1-git-send-email-brian.austin@cirrus.com>
 <1382713277-10306-3-git-send-email-brian.austin@cirrus.com>
 <20131025153736.GA26122@sirena.org.uk>
 <alpine.DEB.2.10.1310251244140.11514@heelrod.ad.cirrus.com>
 <20131025202212.GW2443@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from am1outboundpool.messaging.microsoft.com
 (am1ehsobe005.messaging.microsoft.com [213.199.154.208])
 by alsa0.perex.cz (Postfix) with ESMTP id 568C1261719
 for <alsa-devel@alsa-project.org>; Fri, 25 Oct 2013 22:34:31 +0200 (CEST)
In-Reply-To: <20131025202212.GW2443@sirena.org.uk>
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

> On Fri, Oct 25, 2013 at 12:49:50PM -0500, Brian Austin wrote:
>
>> 		ret = _regmap_write(map, regs[i].reg, regs[i].def);
>> 		if (ret != 0) {
>
> That's it, yes...  it's due to writeable_register() enforcing the
> max_register check.  Hrm, having looked again I'm not seeing a quick and
> obvious solution to this so I'll go ahead and apply your patch though we
> should fix things so that it's not needed.

I'll take a look and see about a fix.

Thanks
