From: Julia Lawall <julia.lawall@lip6.fr>
Subject: Re: unnecessary test?
Date: Wed, 6 Jun 2018 21:43:21 +0900 (JST)
Message-ID: <alpine.DEB.2.20.1806062142300.4445@hadrien>
References: <alpine.DEB.2.20.1806062135430.4445@hadrien>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail3-relais-sop.national.inria.fr
 (mail3-relais-sop.national.inria.fr [192.134.164.104])
 by alsa0.perex.cz (Postfix) with ESMTP id A9074266F0F
 for <alsa-devel@alsa-project.org>; Wed,  6 Jun 2018 14:43:26 +0200 (CEST)
In-Reply-To: <alpine.DEB.2.20.1806062135430.4445@hadrien>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: perex@perex.cz
Cc: alsa-devel@alsa-project.org, tiwai@suse.com, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org



On Wed, 6 Jun 2018, Julia Lawall wrote:

> In the file sound/pci/ctxfi/cthw20k1.c, the function daio_mgr_dao_init
> contains:
>
> set_field(&ctl->spoctl, SPOCTL_OS << (idx*8),
>           ((conf >> 3) & 0x1) ? 2 : 2); /* Raw */
>
> Could the second argument just be 2?  It's true that the preceeding call
> contains conf >> ..., but in a more useful way, so perhaps it could be
> useful for uniformity?

There is similar code in daio_mgr_dao_init in sound/pci/ctxfi/cthw20k2.c:

        	set_field(&ctl->txctl[idx], ATXCTL_RAW,
                         ((conf >> 3) & 0x1) ? 0 : 0);


julia
