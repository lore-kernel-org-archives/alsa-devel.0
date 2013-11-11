From: Fabio Estevam <fabio.estevam@freescale.com>
Subject: Re: [RFC] ASoC: fsl-ssi: Missing DMA-Request workaround
Date: Mon, 11 Nov 2013 14:07:10 -0200
Message-ID: <528100AE.60901@freescale.com>
References: <1384185816-7730-1-git-send-email-mpa@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from tx2outboundpool.messaging.microsoft.com
 (tx2ehsobe004.messaging.microsoft.com [65.55.88.14])
 by alsa0.perex.cz (Postfix) with ESMTP id 8E41726109C
 for <alsa-devel@alsa-project.org>; Mon, 11 Nov 2013 17:07:53 +0100 (CET)
In-Reply-To: <1384185816-7730-1-git-send-email-mpa@pengutronix.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Markus Pargmann <mpa@pengutronix.de>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, Shawn Guo <shawn.guo@linaro.org>, Lars-Peter Clausen <lars@metafoo.de>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

Hi Markus,


On 11/11/2013 02:03 PM, Markus Pargmann wrote:
> There is a hardware issue when using capture and playback at the same
> time. In the tested scenario, the capture stream was started slightly

Just to confirm: do you have this patch applied?
https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git/commit/sound/soc/fsl/fsl_ssi.c?id=64d2307c3b7daa03dbc0c3a6b514709dd7b6eaee

Regards,

Fabio Estevam
