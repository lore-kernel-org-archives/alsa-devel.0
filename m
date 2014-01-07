From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH v2 11/11] ASoC: Allow PCMs to restrict the
 supported formats
Date: Tue, 7 Jan 2014 19:35:41 +0800
Message-ID: <20140107113540.GE12346@S2101-09.ap.freescale.net>
References: <1389014356-7014-1-git-send-email-lars@metafoo.de>
 <1389014356-7014-11-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from am1outboundpool.messaging.microsoft.com
 (am1ehsobe002.messaging.microsoft.com [213.199.154.205])
 by alsa0.perex.cz (Postfix) with ESMTP id D6F2C2616CB
 for <alsa-devel@alsa-project.org>; Tue,  7 Jan 2014 12:34:58 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1389014356-7014-11-git-send-email-lars@metafoo.de>
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
Cc: alsa-devel@alsa-project.org, Nicolin Chen <b42378@freescale.com>, Liam Girdwood <lgirdwood@gmail.com>, Timur Tabi <timur@tabi.org>, Mark Brown <broonie@kernel.org>, Markus Pargmann <mpa@pengutronix.de>
List-Id: alsa-devel@alsa-project.org

On Mon, Jan 06, 2014 at 02:19:16PM +0100, Lars-Peter Clausen wrote:
> Some DMA cores might add additional restrictions on which in memory audio
> formats can be supported by the compound sound card. If the PCM component
> specifies a set of formats it supports (by setting the formats field to non 0)
> take these into account when calculating the format set for the compound sound
> card.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> Cc: Timur Tabi <timur@tabi.org>
> Cc: Shawn Guo <shawn.guo@linaro.org>

For patches 4, 7, and 11:

Tested-by: Shawn Guo <shawn.guo@linaro.org>
