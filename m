From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: DMA engine API issue
Date: Thu, 24 Jul 2014 14:29:09 +0200
Message-ID: <53D0FC15.6050601@metafoo.de>
References: <1406032431-3807-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <87d2cwvmxa.wl%kuninori.morimoto.gx@gmail.com> <3361994.F0HgAeJkR9@avalon>
 <28702317.aD0C1Ga3DS@avalon>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-248.synserver.de (smtp-out-248.synserver.de
 [212.40.185.248])
 by alsa0.perex.cz (Postfix) with ESMTP id 5A338265580
 for <alsa-devel@alsa-project.org>; Thu, 24 Jul 2014 14:29:10 +0200 (CEST)
In-Reply-To: <28702317.aD0C1Ga3DS@avalon>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, linux-sh@vger.kernel.org, Vinod Koul <vinod.koul@intel.com>, Magnus Damm <magnus.damm@gmail.com>, dmaengine@vger.kernel.org, Maxime Ripard <maxime.ripard@free-electrons.com>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

On 07/23/2014 01:07 PM, Laurent Pinchart wrote:
[...]
> Let's start by answering the background question and updating the DMA engine
> API documentation once and for good : in which context are drivers allowed to
> call the prep, tx_submit and issue_pending functions ?
>

I think the expectation is that these functions can be called in any 
context. Maybe what's missing is a way to tell the DMA engine driver to get 
ready and that it is going to be used very soon. This could be done from the 
sound devices open() callback.

- Lars
