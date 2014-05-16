From: Sinan Akman <sinan@writeme.com>
Subject: Re: [RFT v3 3/3] ASoC: core: Add support for DAI
	multicodec
Date: Fri, 16 May 2014 16:06:50 -0400
Message-ID: <53766FDA.2080500@writeme.com>
References: <1398340906-5017-1-git-send-email-bcousson@baylibre.com>
 <1398340906-5017-4-git-send-email-bcousson@baylibre.com>
 <5368C67D.4080506@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from walmailout10.yourhostingaccount.com
 (mailout10.yourhostingaccount.com [65.254.253.82])
 by alsa0.perex.cz (Postfix) with ESMTP id 5F788261685
 for <alsa-devel@alsa-project.org>; Fri, 16 May 2014 22:07:11 +0200 (CEST)
Received: from mailscan13.yourhostingaccount.com ([10.1.15.13]
 helo=walmailscan13.yourhostingaccount.com)
 by walmailout10.yourhostingaccount.com with esmtp (Exim)
 id 1WlOPO-0006f1-Oz
 for alsa-devel@alsa-project.org; Fri, 16 May 2014 16:07:10 -0400
In-Reply-To: <5368C67D.4080506@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: alsa-devel@alsa-project.org, lgirdwood@gmail.com, Fabien Parent <fparent@baylibre.com>, broonie@kernel.org, Benoit Cousson <bcousson@baylibre.com>, misael.lopez@ti.com
List-Id: alsa-devel@alsa-project.org

On 05/06/2014 07:24 AM, Lars-Peter Clausen wrote:
> [...]
> I don't think it makes sense to artificially limit this to just CODECs.
> While we do not support multiple CPU DAIs (yet?) adding the check for
> CODECs just makes the code more complex, but doesn't gain us anything.

   I have a related question. I am trying to put together something
that would "bridge" a spdif rx into say ssi tx on iMX6. I am just not
sure how this would fit into the alsa model. Would multiple CPU DAIs be
the recommended model for this. In this case I will follow this
thread and try to extend/use that multiple CPU DAIs idea.

   I apologise if this is not related enough to the current thread.
If it is the case I'll  start a new thread.

   Thanks

   -- sinan
