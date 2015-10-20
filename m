From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH 1/2] ASoC: ssm2518: Drop .volatile_reg
	implementation
Date: Tue, 20 Oct 2015 11:02:40 +0200
Message-ID: <56260330.8070800@metafoo.de>
References: <1445331286.25880.1.camel@ingics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-188.synserver.de (smtp-out-200.synserver.de
 [212.40.185.200])
 by alsa0.perex.cz (Postfix) with ESMTP id 2475D26640F
 for <alsa-devel@alsa-project.org>; Tue, 20 Oct 2015 11:02:44 +0200 (CEST)
In-Reply-To: <1445331286.25880.1.camel@ingics.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Axel Lin <axel.lin@ingics.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

On 10/20/2015 10:54 AM, Axel Lin wrote:
> The implementation of ssm2518_register_volatile always returns false,
> this behavior is the same as no .volatile_reg callback implementation
> when cache_type != REGCACHE_NONE.
> 
> Signed-off-by: Axel Lin <axel.lin@ingics.com>

Acked-by: Lars-Peter Clausen <lars@metafoo.de>

Thanks.
