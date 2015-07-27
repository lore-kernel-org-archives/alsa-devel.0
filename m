From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/6] ASoC: wm8804: Drop dublicate const
Date: Mon, 27 Jul 2015 20:53:50 +0100
Message-ID: <20150727195350.GA6230@opensource.wolfsonmicro.com>
References: <1437987388-9706-1-git-send-email-lars@metafoo.de>
 <1437987388-9706-2-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 95DD3260488
 for <alsa-devel@alsa-project.org>; Mon, 27 Jul 2015 21:53:50 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1437987388-9706-2-git-send-email-lars@metafoo.de>
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
Cc: alsa-devel@alsa-project.org, Banajit Goswami <bgoswami@codeaurora.org>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Patrick Lai <plai@codeaurora.org>, patches@opensource.wolfsonmicro.com, Arnaud Pouliquen <arnaud.pouliquen@st.com>, Liam Girdwood <lgirdwood@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

On Mon, Jul 27, 2015 at 10:56:23AM +0200, Lars-Peter Clausen wrote:
> SOC_ENUM_SINGLE_DECL() already includes a const, drop the extra const.
> Fixes the following sparse warning:
> 
> 	sound/soc/codecs/wm8804.c:101:14: warning: duplicate const
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> ---

Acked-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>

Thanks,
Charles
