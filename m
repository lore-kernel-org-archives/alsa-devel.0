From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH] ASoC: Allow source specification for CODEC
 level sysclk
Date: Tue, 30 Aug 2011 17:55:19 +0200
Message-ID: <4E5D07E7.80305@metafoo.de>
References: <1314212978-18293-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailhost.informatik.uni-hamburg.de
	(mailhost.informatik.uni-hamburg.de [134.100.9.70])
	by alsa0.perex.cz (Postfix) with ESMTP id 43699246EB
	for <alsa-devel@alsa-project.org>;
	Tue, 30 Aug 2011 17:56:11 +0200 (CEST)
In-Reply-To: <1314212978-18293-1-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On 08/24/2011 09:09 PM, Mark Brown wrote:
> Similarly to PLLs/FLLs some modern CODECs provide selectable system clock
> sources. When the clock is the clock for a DAI we do not usually need to
> identify which clock is being configured so can use clk_id for the source
> clock but with CODEC wide system clocks we will need to specify both the
> clock being configured and the source.
> 
> Add a source argument to the CODEC driver set_sysclk() operation to
> reflect this. As this operation is not as widely used as the DAI
> set_sysclk() operation the change is not very invasive. We probably
> ought to go and make the same alternation for DAIs at some point.

If we also want to change the DAI driver's set_sysclck we should probably do
this better now than later, because the number of affected drivers is probably
not going to decline.

> 
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> ---
>  include/sound/soc.h          |    4 ++--
>  sound/soc/codecs/wm9081.c    |    4 ++--
>  sound/soc/samsung/speyside.c |    2 +-
>  sound/soc/soc-core.c         |    8 +++++---

The adau1701 and adav80x drivers also implement the CODEC driver set_sysclk.
