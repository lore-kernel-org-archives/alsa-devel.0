From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: ASoC: ssm2518: bug in ssm2518_set_tdm_slot
Date: Mon, 10 Jun 2013 15:56:29 +0200
Message-ID: <51B5DB0D.9040103@metafoo.de>
References: <1370871581.22493.0.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-071.synserver.de (smtp-out-071.synserver.de
 [212.40.185.71])
 by alsa0.perex.cz (Postfix) with ESMTP id EE913261664
 for <alsa-devel@alsa-project.org>; Mon, 10 Jun 2013 15:56:21 +0200 (CEST)
In-Reply-To: <1370871581.22493.0.camel@phoenix>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Axel Lin <axel.lin@ingics.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

On 06/10/2013 03:39 PM, Axel Lin wrote:
> ASoC: ssm2518: bug in ssm2518_set_tdm_slot
> 
> The code in ssm2518_set_tdm_slot looks wrong:
> 
>         if (tx_mask == 0 || tx_mask != 0)
>                 return -EINVAL;
> 
> So ssm2518_set_tdm_slot() always returns error.
> 

Ah, damm, the second should be rx_mask. Do you want to sent a fix, or want
me to do it?

Thanks,
- Lars
